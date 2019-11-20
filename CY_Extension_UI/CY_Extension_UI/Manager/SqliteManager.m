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
    NSString *billDBPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Bill_db.sqlite"];
    
    if (sqlite3_open([billDBPath UTF8String], &billDB) == SQLITE_OK) {
        NSLog(@"SQLITE_OK");
    }else{
        NSLog(@"SQLITE_ERROR");
    }
}

@end
