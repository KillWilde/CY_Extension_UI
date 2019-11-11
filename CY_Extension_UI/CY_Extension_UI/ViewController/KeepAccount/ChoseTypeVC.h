//
//  ChoseTypeVC.h
//  CY_Extension_UI
//
//  Created by Megatron on 2019/11/9.
//  Copyright © 2019 SaturdayNight. All rights reserved.
//

#import <UIKit/UIKit.h>

//选择消费类型回调
typedef void(^VCBackAction)(NSString *_Nullable type);

NS_ASSUME_NONNULL_BEGIN

@interface ChoseTypeVC : UIViewController

@property (weak, nonatomic) IBOutlet UICollectionView *list;

@property (nonatomic,copy) VCBackAction backAction;

- (void)listenChoseType:(VCBackAction)action;

@end

NS_ASSUME_NONNULL_END
