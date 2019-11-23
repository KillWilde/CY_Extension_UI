//
//  SqliteManager.m
//  CY_Extension_UI
//
//  Created by Megatron on 2019/11/14.
//  Copyright © 2019 SaturdayNight. All rights reserved.
//

#import "SqliteManager.h"
#import <sqlite3.h>

static sqlite3 *billDB = nil;

@implementation SqliteManager

- (void)prepareDB{
    NSString *billDBPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"Bill_db.sqlite"];
    
    if (sqlite3_open([billDBPath UTF8String], &billDB) == SQLITE_OK) {
        NSLog(@"SQLITE_OK");
    }else{
        NSLog(@"SQLITE_ERROR");
    }
}

//MARK: 创建表 并插入数据
- (void)createTable:(NSString *)tbName typeName:(NSString *)typeName date:(NSString *)date money:(NSString *)money remarks:(NSString *)remarks{
    [self prepareDB];
    
    /*
     ID 主键 自增
     TypeName   消费类型
     Date   发生日期
     Money  消费数额
     Remarks    备注
     */
    
    //创建表
    NSString *sqlCreateTable = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (ID INTEGER PRIMARY KEY AUTOINCREMENT,TypeName text NOT NULL,Date text NOT NULL,Money float NOT NULL,Remarks text);",tbName];
    
    char *error;
    int result = sqlite3_exec(billDB, [sqlCreateTable UTF8String], NULL, NULL, &error);
    if (result == SQLITE_OK) {
        NSLog(@"sqlCreateTable SQLITE_OK");
    }else{
        NSLog(@"sqlCreateTable SQLITE_ERROR");
    }
    
    //插入数据
    NSString *sqlInsert = [NSString stringWithFormat:@"INSERT INTO %@ (TypeName,Date,Money,Remarks) VALUES ('%@','%@',%f,'%@');",tbName,typeName,date,[money floatValue],remarks];

    result = sqlite3_exec(billDB, [sqlInsert UTF8String], NULL, NULL, &error);
    if (result == SQLITE_OK) {
        NSLog(@"sqlInsert SQLITE_OK");
    }else{
        NSLog(@"sqlInsert SQLITE_ERROR");
    }
    
    sqlite3_close(billDB);
}

//MARK: 查询表中记录
- (void)searchFromTable:(NSString *)tbaName condition:(NSString *)condition completed:(BillSearchCallBack)completion{
    self.billSearchCallBack = completion;
    
    NSMutableArray *list = [NSMutableArray arrayWithCapacity:0];
    
    [self prepareDB];
    
    NSString *sqlSearch;
    if (condition.length == 0) {
        sqlSearch = [NSString stringWithFormat:@"SELECT * FROM %@;",tbaName];
    }else{
        sqlSearch = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE %@;",tbaName,condition];
    }
    
    sqlite3_stmt *stmt = NULL;
    int result = sqlite3_prepare_v2(billDB, [sqlSearch UTF8String], -1, &stmt, NULL);
    if (result == SQLITE_OK) {
        NSLog(@"sqlSearch SQLITE_OK");
        
        while (sqlite3_step(stmt) ==SQLITE_ROW) {
            char *typeName = (char *)sqlite3_column_text(stmt, 1);
            char *date = (char *)sqlite3_column_text(stmt, 2);
            float money = (float)sqlite3_column_double(stmt, 3);
            char *remarks = (char *)sqlite3_column_text(stmt, 4);
            
            ABill *bill = [[ABill alloc] init];
            bill.typeName = [NSString stringWithCString:typeName encoding:NSUTF8StringEncoding];
            bill.date = [NSString stringWithCString:date encoding:NSUTF8StringEncoding];
            bill.money = money;
            bill.remarks = [NSString stringWithCString:remarks encoding:NSUTF8StringEncoding];
            
            [list addObject:bill];
        }
        
        if (self.billSearchCallBack) {
            self.billSearchCallBack(list, 0);
        }
    }else{
        if (self.billSearchCallBack) {
            self.billSearchCallBack(list, -1);
        }
        NSLog(@"sqlSearch SQLITE_ERROR");
    }
    
    sqlite3_close(billDB);
}

@end
