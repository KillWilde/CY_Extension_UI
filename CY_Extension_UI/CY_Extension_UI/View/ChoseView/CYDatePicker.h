//
//  CYDatePicker.h
//  CY_Extension_UI
//
//  Created by Megatron on 2019/11/9.
//  Copyright © 2019 SaturdayNight. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DatePickerAction)(NSString *_Nullable date);

NS_ASSUME_NONNULL_BEGIN

@interface CYDatePicker : UIView

@property (nonatomic,copy) DatePickerAction datePickerAction;

- (void)showInView:(UIView *)view;

- (void)listenChoseDateAction:(DatePickerAction)action;

@end

NS_ASSUME_NONNULL_END
