//
//  ListBillVC.m
//  CY_Extension_UI
//
//  Created by Megatron on 2019/11/23.
//  Copyright © 2019 SaturdayNight. All rights reserved.
//

#import "ListBillVC.h"
#import "ListBillCell.h"
#import "SqliteManager.h"

static NSString *kListBillCell = @"kListBillCell";

@interface ListBillVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) NSMutableArray <ABill *>*dataSource;

@property (nonatomic,strong) SqliteManager *sqliteManager;

@end

@implementation ListBillVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //导航栏配置
    self.navigationItem.title = @"详情";
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 1;
    layout.minimumInteritemSpacing = 0.5;
    
    [self.list setCollectionViewLayout:layout];
    self.list.delegate = self;
    self.list.dataSource = self;
    self.list.alwaysBounceVertical = YES;
    
    UINib *nib = [UINib nibWithNibName:NSStringFromClass([ListBillCell class]) bundle:nil];
    [self.list registerNib:nib forCellWithReuseIdentifier:kListBillCell];
    
    [self.sqliteManager searchFromTable:@"bill2019" condition:@"" completed:^(NSMutableArray<ABill *> * _Nonnull list, int result) {
        if (result >= 0) {
            self.dataSource = [list mutableCopy];
            [self.list reloadData];
        }
    }];
}

//MARK: - Delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ListBillCell *cell = (ListBillCell *)[collectionView dequeueReusableCellWithReuseIdentifier:kListBillCell forIndexPath:indexPath];
    
    ABill *bill = [self.dataSource objectAtIndex:indexPath.row];
    cell.lbLeftTitle.text = bill.typeName;
    cell.lbLeftDescription.text = bill.date;
    cell.lbRightDescription.text = [NSString stringWithFormat:@"%0.2f",bill.money];
    cell.leftImageIcon.image = [UIImage imageNamed:@"xiaofei"];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGRect rect = [UIScreen mainScreen].bounds;
    
    return CGSizeMake(rect.size.width, 70);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
}

//MARK: - LazyLoad
- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray arrayWithCapacity:0];
    }
    
    return _dataSource;
}

- (SqliteManager *)sqliteManager{
    if (!_sqliteManager) {
        _sqliteManager = [[SqliteManager alloc] init];
    }
    
    return _sqliteManager;
}

@end
