//
//  ListBillCell.h
//  CY_Extension_UI
//
//  Created by Megatron on 2019/11/23.
//  Copyright © 2019 SaturdayNight. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ListBillCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *leftImageIcon;

@property (weak, nonatomic) IBOutlet UILabel *lbLeftTitle;

@property (weak, nonatomic) IBOutlet UILabel *lbLeftDescription;

@property (weak, nonatomic) IBOutlet UILabel *lbRightDescription;

@end

NS_ASSUME_NONNULL_END
