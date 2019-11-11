//
//  ChoseTypeVC.m
//  CY_Extension_UI
//
//  Created by Megatron on 2019/11/9.
//  Copyright © 2019 SaturdayNight. All rights reserved.
//

#import "ChoseTypeVC.h"
#import "CollectionViewCell.h"

static NSString *kCollectionViewCell = @"kCollectionViewCell";

@interface ChoseTypeVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) NSMutableArray *dataSource;

@end

@implementation ChoseTypeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 1;
    layout.minimumInteritemSpacing = 0.5;
    
    [self.list setCollectionViewLayout:layout];
    self.list.delegate = self;
    self.list.dataSource = self;
    self.list.alwaysBounceVertical = YES;
    
    UINib *nib = [UINib nibWithNibName:NSStringFromClass([CollectionViewCell class]) bundle:nil];
    [self.list registerNib:nib forCellWithReuseIdentifier:kCollectionViewCell];
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
    
    return CGSizeMake(rect.size.width / 4.0 - 1.5, rect.size.width / 4.0 - 1.5);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString *type = [[self.dataSource objectAtIndex:indexPath.row] objectForKey:@"name"];
    if (self.backAction) {
        self.backAction(type);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    return;
    NSString *strSegue = [[self.dataSource objectAtIndex:indexPath.row] objectForKey:@"segue"];

    if (strSegue) {
        [self performSegueWithIdentifier:strSegue sender:nil];
    }

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
}

//MARK: - LazyLoad
- (void)listenChoseType:(VCBackAction)action{
    self.backAction = action;
}

//MARK: - LazyLoad
- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray arrayWithCapacity:0];
        [_dataSource addObject:@{@"name":@"餐饮",@"image":@"canyin"}];
        [_dataSource addObject:@{@"name":@"购物",@"image":@"chaoshi"}];
        [_dataSource addObject:@{@"name":@"出行",@"image":@"gongjiao"}];
        [_dataSource addObject:@{@"name":@"酒店",@"image":@"jiudian"}];
        [_dataSource addObject:@{@"name":@"娱乐",@"image":@"yule"}];
        [_dataSource addObject:@{@"name":@"通讯",@"image":@"tongxun"}];
        [_dataSource addObject:@{@"name":@"医疗",@"image":@"yiliao"}];
        [_dataSource addObject:@{@"name":@"更多",@"image":@"gengduo"}];
    }
    
    return _dataSource;
}

@end
