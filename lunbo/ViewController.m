//
//  ViewController.m
//  lunbo
//
//  Created by 李荣潭 on 2018/1/2.
//  Copyright © 2018年 李荣潭. All rights reserved.
//

#import "ViewController.h"
#import "LRTFlowLayout.h"
#import "LRTCollectionViewCell.h"
@interface ViewController () <UICollectionViewDelegate ,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *showArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.collectionView reloadData];
    [self performSelector:@selector(_after) withObject:nil afterDelay:0.1];
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)_after{
    self.collectionView.contentOffset = CGPointMake(75 * (self.showArray.count /2), 0);
}
#pragma mark -- UICollectionView Delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.showArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LRTCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.contentString = self.showArray [indexPath.row];
    cell.contentView.backgroundColor = [UIColor colorWithRed:arc4random()%256 /255.0 green:arc4random()%256 /255.0 blue:arc4random()%256 /255.0 alpha:1];
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.x < (75 + 5) * 3) {
        scrollView.contentOffset = CGPointMake((75 + 5) * (self.showArray.count - 6), 0);
//        [self scrollViewDidEndDragging:self.collectionView willDecelerate:YES];
    }
    if (scrollView.contentOffset.x /(75 + 5) > self.showArray.count - 6) {
        scrollView.contentOffset = CGPointMake((75 + 5) * 3, 0);
//        [self scrollViewDidEndDragging:self.collectionView willDecelerate:YES];
    }
}

#pragma mark -- 懒加载
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        LRTFlowLayout *layout = [[LRTFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.itemSize = CGSizeMake(75, 75);
        layout.minimumLineSpacing = 5;
        layout.minimumInteritemSpacing = 5;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 200, [UIScreen mainScreen].bounds.size.width, 150) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[LRTCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray ) {
        _dataArray = [NSMutableArray arrayWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8", @"1",@"2",@"3",@"4",@"5",@"6",@"7",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"1",@"2",@"3",@"4",@"5",@"6",@"7",nil];
    }
    return _dataArray;
}
- (NSMutableArray *)showArray{
    if (!_showArray) {
        _showArray = [NSMutableArray arrayWithCapacity:0];
        if (self.dataArray.count > 0) {
            [self.dataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [_showArray addObject:obj];
            }];
            [self.dataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [_showArray addObject:obj];
            }];
        }
    }
    return _showArray;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
