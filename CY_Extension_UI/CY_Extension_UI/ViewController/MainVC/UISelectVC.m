//
//  UISelectVC.m
//  CY_Extension_UI
//
//  Created by Megatron on 2019/11/5.
//  Copyright © 2019 SaturdayNight. All rights reserved.
//

#import "UISelectVC.h"
#import "CollectionViewCell.h"

static NSString *kCollectionViewCell = @"kCollectionViewCell";

@interface UISelectVC () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) NSMutableArray *dataSource;

@end

@implementation UISelectVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 1;
    layout.minimumInteritemSpacing = 1;
    
    [self.selectUIList setCollectionViewLayout:layout];
    self.selectUIList.delegate = self;
    self.selectUIList.dataSource = self;
    
    UINib *nib = [UINib nibWithNibName:kCollectionViewCell bundle:nil];
    [self.selectUIList registerNib:nib forCellWithReuseIdentifier:kCollectionViewCell];
}

//MARK: - Delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CollectionViewCell *cell = (CollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:kCollectionViewCell forIndexPath:indexPath];
    
    NSDictionary *info = [self.dataSource objectAtIndex:indexPath.row];
    cell.lbName.text = [info objectForKey:@"name"];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGRect rect = [UIScreen mainScreen].bounds;
    
    return CGSizeMake(rect.size.width * 0.5 - 3, rect.size.width * 0.5 - 3);
}

//MARK: - LazyLoad
- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray arrayWithCapacity:0];
        [_dataSource addObject:@{@"name":@"UILabel"}];
        [_dataSource addObject:@{@"name":@"UIButton"}];
        [_dataSource addObject:@{@"name":@"UISlider"}];
    }
    
    return _dataSource;
}

@end
