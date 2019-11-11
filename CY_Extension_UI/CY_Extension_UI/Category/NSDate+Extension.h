//
//  NSDate+Extension.h
//  CY_Extension_UI
//
//  Created by Megatron on 2019/11/11.
//  Copyright © 2019 SaturdayNight. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (Extension)

//MARK: NSDate转NSString
- (NSString *)getYMD;

- (NSString *)getHMS;

- (NSString *)getYMDHMS;


@end

NS_ASSUME_NONNULL_END
