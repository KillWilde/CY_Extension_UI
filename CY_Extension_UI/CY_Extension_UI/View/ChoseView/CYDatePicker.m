//
//  CYDatePicker.m
//  CY_Extension_UI
//
//  Created by Megatron on 2019/11/9.
//  Copyright © 2019 SaturdayNight. All rights reserved.
//

#import "CYDatePicker.h"
#import "NSDate+Extension.h"

@interface CYDatePicker ()

@property (nonatomic,strong) UIDatePicker *datePicker;

@property (nonatomic,strong) UIButton *btnCancel;

@property (nonatomic,strong) UIButton *btnOK;

@end

@implementation CYDatePicker

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.datePicker];
        [self addSubview:self.btnCancel];
        [self addSubview:self.btnOK];
        
        self.datePicker.translatesAutoresizingMaskIntoConstraints = NO;
        [NSLayoutConstraint constraintWithItem:self.datePicker attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0].active = YES;
        [NSLayoutConstraint constraintWithItem:self.datePicker attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0].active = YES;
        [NSLayoutConstraint constraintWithItem:self.datePicker attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:0.8 constant:0].active = YES;
        [NSLayoutConstraint constraintWithItem:self.datePicker attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:0.5 constant:0].active = YES;
        
        self.btnCancel.translatesAutoresizingMaskIntoConstraints = NO;
        [NSLayoutConstraint constraintWithItem:self.btnCancel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:0.5 constant:0].active = YES;
        [NSLayoutConstraint constraintWithItem:self.btnCancel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.datePicker attribute:NSLayoutAttributeBottom multiplier:1 constant:20].active = YES;
        [NSLayoutConstraint constraintWithItem:self.btnCancel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:0 constant:120].active = YES;
        [NSLayoutConstraint constraintWithItem:self.btnCancel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:0 constant:35];
        
        self.btnOK.translatesAutoresizingMaskIntoConstraints = NO;
        [NSLayoutConstraint constraintWithItem:self.btnOK attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.5 constant:0].active = YES;
        [NSLayoutConstraint constraintWithItem:self.btnOK attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.datePicker attribute:NSLayoutAttributeBottom multiplier:1 constant:20].active = YES;
        [NSLayoutConstraint constraintWithItem:self.btnOK attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:0 constant:120].active = YES;
        [NSLayoutConstraint constraintWithItem:self.btnOK attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:0 constant:35];
    }
    
    return self;
}

//MARK: - EventAction
- (void)showInView:(UIView *)view{
    [view addSubview:self];
    
    self.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeTop multiplier:1 constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeBottom multiplier:1 constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeLeading multiplier:1 constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeTrailing multiplier:1 constant:0].active = YES;
}

- (void)listenChoseDateAction:(DatePickerAction)action{
    self.datePickerAction = action;
}

- (void)btnOKClicked{
    if (self.datePickerAction) {
        self.datePickerAction([self.datePicker.date getYMD]);
    }
    
    [self btnCancelClicked];
}

- (void)btnCancelClicked{
    [UIView animateWithDuration:0.3 animations:^{
        [self removeFromSuperview];
    }];
}

//MARK: - LazyLoad
- (UIDatePicker *)datePicker{
    if (!_datePicker) {
        _datePicker = [[UIDatePicker alloc] init];
        NSLocale *local = [NSLocale localeWithLocaleIdentifier:@"zh_CN"];
        _datePicker.locale = local;
        _datePicker.datePickerMode = UIDatePickerModeDate;
    }
    
    return _datePicker;
}

- (UIButton *)btnOK{
    if (!_btnOK) {
        _btnOK = [UIButton buttonWithType:UIButtonTypeSystem];
        [_btnOK setTitle:@"确定" forState:UIControlStateNormal];
        [_btnOK addTarget:self action:@selector(btnOKClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _btnOK;
}

- (UIButton *)btnCancel{
    if (!_btnCancel) {
        _btnCancel = [UIButton buttonWithType:UIButtonTypeSystem];
        [_btnCancel setTitle:@"取消" forState:UIControlStateNormal];
        [_btnCancel addTarget:self action:@selector(btnCancelClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _btnCancel;
}

@end
