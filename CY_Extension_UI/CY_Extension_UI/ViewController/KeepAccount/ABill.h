//
//  ABill.h
//  CY_Extension_UI
//
//  Created by Megatron on 2019/11/23.
//  Copyright © 2019 SaturdayNight. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ABill : NSObject

//MARK:消费类型
@property (nonatomic,copy) NSString *typeName;
//MARK:消费金额
@property (nonatomic,assign) float money;
//MARK:消费时间 yyyy-mm-dd
@property (nonatomic,copy) NSString *date;
//MARK:消费备注
@property (nonatomic,copy) NSString *remarks;

@end

NS_ASSUME_NONNULL_END
