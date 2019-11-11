//
//  InputBillVC.m
//  CY_Extension_UI
//
//  Created by Megatron on 2019/11/7.
//  Copyright © 2019 SaturdayNight. All rights reserved.
//

#import "InputBillVC.h"
#import "LeftTitleRightArrowCell.h"
#import "ChoseTypeVC.h"
#import "CYDatePicker.h"

static NSString *const kLeftTitleRightArrowCell = @"kLeftTitleRightArrowCell";

@interface InputBillVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) NSMutableArray *dataSource;

@property (nonatomic,strong) CYDatePicker *datePicker;

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

    //导航栏配置
    self.navigationItem.title = @"";
    
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
    
    //记账类型选择
    [self.segmentType removeAllSegments];
    [self.segmentType insertSegmentWithTitle:@"支出" atIndex:0 animated:NO];
    [self.segmentType insertSegmentWithTitle:@"收入" atIndex:1 animated:NO];
    [self.segmentType setSelectedSegmentIndex:0];
    [self.segmentType setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:50/255.0 green:130/255.0 blue:252/255.0 alpha:1]} forState:UIControlStateSelected];
    [self.segmentType addTarget:self action:@selector(segmentValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    //列表配置
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 1;
    layout.minimumInteritemSpacing = 0.5;
    
    [self.list setCollectionViewLayout:layout];
    self.list.delegate = self;
    self.list.dataSource = self;
    self.list.alwaysBounceVertical = YES;
    
    UINib *nib = [UINib nibWithNibName:NSStringFromClass([LeftTitleRightArrowCell class]) bundle:nil];
    [self.list registerNib:nib forCellWithReuseIdentifier:kLeftTitleRightArrowCell];
}

//MARK: - Delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LeftTitleRightArrowCell *cell = (LeftTitleRightArrowCell *)[collectionView dequeueReusableCellWithReuseIdentifier:kLeftTitleRightArrowCell forIndexPath:indexPath];
    
    NSDictionary *info = [self.dataSource objectAtIndex:indexPath.row];
    cell.titleLeft.text = [info objectForKey:@"name"];
    cell.titleRight.text = [info objectForKey:@"data"];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGRect rect = [UIScreen mainScreen].bounds;
    
    return CGSizeMake(rect.size.width, 50);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString *name = [[self.dataSource objectAtIndex:indexPath.row] objectForKey:@"name"];
    if ([name isEqualToString:@"日期"]) {
        [self.datePicker showInView:self.view];
        [self.datePicker listenChoseDateAction:^(NSString * _Nullable date) {
            [self changeName:@"日期" data:date];
            [self.list reloadData];
        }];
        return;
    }
    
    NSString *strSegue = [[self.dataSource objectAtIndex:indexPath.row] objectForKey:@"segue"];

    if (strSegue) {
        [self performSegueWithIdentifier:strSegue sender:nil];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"GoChoseTypeVC"]) {
        ChoseTypeVC *vc = segue.destinationViewController;
        [vc listenChoseType:^(NSString * _Nullable type) {
            [self changeName:@"消费类型" data:type];
            [self.list reloadData];
        }];
    }
}

- (void)changeName:(NSString *)name data:(NSString *)data{
    for (int i = 0; i < self.dataSource.count; i ++) {
        NSMutableDictionary *dic = [[self.dataSource objectAtIndex:i] mutableCopy];
        NSString *dName = [dic objectForKey:@"name"];
        if ([name isEqualToString:dName]) {
            [dic setObject:data forKey:@"data"];
            [self.dataSource replaceObjectAtIndex:i withObject:dic];
            break;
        }
    }
}

//MARK: - 导航栏右侧按钮点击
- (void)btnRightClicked{
    
}

- (void)segmentValueChanged:(UISegmentedControl *)sender{
    
}

//MARK: - LazyLoad
- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray arrayWithCapacity:0];
        [_dataSource addObject:@{@"name":@"消费类型",@"data":@"午餐",@"segue":@"GoChoseTypeVC"}];
        [_dataSource addObject:@{@"name":@"日期",@"data":@"2019-10-31"}];
        [_dataSource addObject:@{@"name":@"金额",@"data":@"26.5"}];
        [_dataSource addObject:@{@"name":@"备注",@"data":@"一个人吃"}];
    }
    
    return _dataSource;
}

-(CYDatePicker *)datePicker{
    if (!_datePicker) {
        _datePicker = [[CYDatePicker alloc] init];
    }
    
    return _datePicker;
}

@end
