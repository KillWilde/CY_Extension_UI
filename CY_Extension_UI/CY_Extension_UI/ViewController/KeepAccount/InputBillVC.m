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
#import "SqliteManager.h"

static NSString *const kLeftTitleRightArrowCell = @"kLeftTitleRightArrowCell";

@interface InputBillVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITextFieldDelegate>

@property (nonatomic,strong) NSMutableArray *dataSource;
//日期选择器
@property (nonatomic,strong) CYDatePicker *datePicker;
//数据库操作管理
@property (nonatomic,strong) SqliteManager *sqliteManager;
//用于弹出输入键盘
@property (nonatomic,strong) UITextField *tfInput;

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
    
    [self.view addSubview:self.tfInput];
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
    }else if ([name isEqualToString:@"金额"]){
        [self.tfInput becomeFirstResponder];
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
    [self.tfInput resignFirstResponder];
    
    [self.sqliteManager createTable:@"bill2019" typeName:[[self.dataSource objectAtIndex:0] objectForKey:@"data"] date:[[self.dataSource objectAtIndex:1] objectForKey:@"data"] money:[[self.dataSource objectAtIndex:2] objectForKey:@"data"] remarks:[[self.dataSource objectAtIndex:3] objectForKey:@"data"]];
}

- (void)segmentValueChanged:(UISegmentedControl *)sender{
    
}

//MARK: - Delegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSLog(@"textField %@ string %@",textField.text,string);
    
    NSString *curText = textField.text;
    if (string.length == 0) {
        if (curText.length > 0) {
            curText = [curText substringToIndex:(curText.length - 1)];
            [self changeLoaclMoney:curText];
            return YES;
        }
        return NO;
    }else if ([string isEqualToString:@"."]){
        if ([curText containsString:@"."]) {
            return NO;
        }
        curText = [curText stringByAppendingString:@"."];
        [self changeLoaclMoney:curText];
        return YES;
    }else{
        curText = [curText stringByAppendingString:string];
        [self changeLoaclMoney:curText];
        return YES;
    }
}

- (void)changeLoaclMoney:(NSString *)money{
    NSMutableDictionary *dic = [[self.dataSource objectAtIndex:2] mutableCopy];
    [dic setObject:money forKey:@"data"];
    [self.dataSource replaceObjectAtIndex:2 withObject:dic];
    [self.list reloadData];
}

//MARK: - LazyLoad
- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray arrayWithCapacity:0];
        [_dataSource addObject:@{@"name":@"消费类型",@"data":@"午餐",@"segue":@"GoChoseTypeVC"}];
        [_dataSource addObject:@{@"name":@"日期",@"data":@"2019-10-31"}];
        [_dataSource addObject:@{@"name":@"金额",@"data":@""}];
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

- (SqliteManager *)sqliteManager{
    if (!_sqliteManager) {
        _sqliteManager = [[SqliteManager alloc] init];
    }
    
    return _sqliteManager;
}

- (UITextField *)tfInput{
    if (!_tfInput) {
        _tfInput = [[UITextField alloc] init];
        _tfInput.delegate = self;
        _tfInput.keyboardType = UIKeyboardTypeDecimalPad;
    }
    
    return _tfInput;
}

@end
