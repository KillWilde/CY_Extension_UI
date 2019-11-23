//
//  SqliteManager.h
//  CY_Extension_UI
//
//  Created by Megatron on 2019/11/14.
//  Copyright © 2019 SaturdayNight. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ABill.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^BillSearchCallBack)(NSMutableArray <ABill *>*list,int result);

@interface SqliteManager : NSObject

@property (nonatomic,copy) BillSearchCallBack billSearchCallBack;

/*
 记账相关操作
 */
- (void)prepareDB;
//MARK: 创建表 并插入数据
- (void)createTable:(NSString *)tbName typeName:(NSString *)typeName date:(NSString *)date money:(NSString *)money remarks:(NSString *)remarks;
//MARK: 查询表中记录
- (void)searchFromTable:(NSString *)tbaName condition:(NSString *)condition completed:(BillSearchCallBack)completion;

@end

NS_ASSUME_NONNULL_END
