//
//  InputBillVC.m
//  CY_Extension_UI
//
//  Created by Megatron on 2019/11/7.
//  Copyright © 2019 SaturdayNight. All rights reserved.
//

#import "InputBillVC.h"

@interface InputBillVC ()

@end

@implementation InputBillVC
    
-  (void)viewWillDisappear:(BOOL)animated{
    if ([self.navigationController.viewControllers indexOfObject:self] == NSNotFound) {
        NSLog(@"导航栏返回");
    }
}

- (void)viewWillAppear:(BOOL)animated{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    //添加导航栏右侧按钮
    UIButton *btnRight = [UIButton buttonWithType:UIButtonTypeSystem];
    btnRight.frame = CGRectMake(0, 0, 50, 30);
    [btnRight setTitle:@"保存" forState:UIControlStateNormal];
    [btnRight setTitleColor:[UIColor colorWithRed:50/255.0 green:130/255.0 blue:252/255.0 alpha:1] forState:UIControlStateNormal];
    btnRight.titleLabel.font = [UIFont systemFontOfSize:18];
    [btnRight addTarget:self action:@selector(btnRightClicked) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *itemRight = [[UIBarButtonItem alloc] initWithCustomView:btnRight];
    self.navigationItem.rightBarButtonItem = itemRight;
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor darkGrayColor];
}

//MARK: - 导航栏右侧按钮点击
- (void)btnRightClicked{
    
}

@end
