//
//  CollectionViewCell.h
//  CY_Extension_UI
//
//  Created by Megatron on 2019/11/6.
//  Copyright © 2019 SaturdayNight. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgIcon;
@property (weak, nonatomic) IBOutlet UILabel *lbName;

@end

NS_ASSUME_NONNULL_END
