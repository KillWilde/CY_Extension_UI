//
//  UISelectVC.m
//  CY_Extension_UI
//
//  Created by Megatron on 2019/11/5.
//  Copyright © 2019 SaturdayNight. All rights reserved.
//

#import "UISelectVC.h"
#import "CollectionViewCell.h"
#import "LabelVC.h"

static NSString *kCollectionViewCell = @"kCollectionViewCell";

@interface UISelectVC () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) NSMutableArray *dataSource;

@end

@implementation UISelectVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //防止导航栏push 或者 pop时 右上角出现黑色阴影
    self.navigationController.navigationBar.translucent = false;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 1;
    layout.minimumInteritemSpacing = 1;
    
    [self.selectUIList setCollectionViewLayout:layout];
    self.selectUIList.delegate = self;
    self.selectUIList.dataSource = self;
    self.selectUIList.alwaysBounceVertical = YES;
    
    UINib *nib = [UINib nibWithNibName:NSStringFromClass([CollectionViewCell class]) bundle:nil];
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
    cell.imgIcon.image = [UIImage imageNamed:[info objectForKey:@"image"]];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGRect rect = [UIScreen mainScreen].bounds;
    
    return CGSizeMake(rect.size.width / 3.0 - 2, rect.size.width / 3.0 - 2);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"GoLabelVC" sender:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
}

//MARK: - LazyLoad
- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray arrayWithCapacity:0];
        [_dataSource addObject:@{@"name":@"账单",@"image":@"jizhang"}];
        [_dataSource addObject:@{@"name":@"日记",@"image":@"riji"}];
        [_dataSource addObject:@{@"name":@"计算器",@"image":@"jisuanqi"}];
        [_dataSource addObject:@{@"name":@"照相机",@"image":@"zhaoxiangji"}];
        [_dataSource addObject:@{@"name":@"二维码扫描",@"image":@"erweima"}];
        [_dataSource addObject:@{@"name":@"手机相册",@"image":@"xiangce"}];
        [_dataSource addObject:@{@"name":@"地图",@"image":@"ditu"}];
        [_dataSource addObject:@{@"name":@"更多",@"image":@"gengduo"}];
    }
    
    return _dataSource;
}

@end
