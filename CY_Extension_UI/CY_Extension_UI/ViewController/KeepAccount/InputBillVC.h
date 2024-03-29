//
//  InputBillVC.h
//  CY_Extension_UI
//
//  Created by Megatron on 2019/11/7.
//  Copyright © 2019 SaturdayNight. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface InputBillVC : UIViewController

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentType;
@property (weak, nonatomic) IBOutlet UICollectionView *list;

@end

NS_ASSUME_NONNULL_END
