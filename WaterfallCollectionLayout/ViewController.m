//
//  ViewController.m
//  WaterfallCollectionLayout
//
//  Created by ci123 on 16/1/26.
//  Copyright © 2016年 tanhui. All rights reserved.
//

#import "ViewController.h"
#import "WaterfallColectionLayout.h"

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property(nonatomic,strong)UICollectionView* collectionView;
@property(nonatomic,strong)UICollectionViewLayout* layout;

@property(nonatomic,strong)NSArray* heightArr;
@end

@implementation ViewController
static NSString * identifer = @"CollectionCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    self.edgesForExtendedLayout=UIRectEdgeNone;
    [self.view addSubview:self.collectionView];
}

#pragma mark collectionViewDelegate-collectionViewDatesource
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CollectionViewCell* cell = (CollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:identifer forIndexPath:indexPath];
    return cell;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.heightArr.count;
}
#pragma mark getter-setter
-(UICollectionView *)collectionView{
    if(!_collectionView){
        _collectionView = [[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:self.layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate=self;
        _collectionView.dataSource=self;
        [_collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:identifer];
    }
    return _collectionView;
}
-(UICollectionViewLayout *)layout{
    if(!_layout){
        _layout = [[WaterfallColectionLayout alloc]initWithItemsHeightBlock:^CGFloat(NSIndexPath *index) {
            return [self.heightArr[index.item] floatValue];
        }];
        
    }
    return _layout;
}
-(NSArray *)heightArr{
    if(!_heightArr){
        //随机生成高度
        NSMutableArray *arr = [NSMutableArray array];
        for (int i = 0; i<100; i++) {
            [arr addObject:@(arc4random()%50+80)];
        }
        _heightArr = [arr copy];
    }
    return _heightArr;
}
@end

@interface CollectionViewCell()

@end
@implementation CollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor=[self randomColor];
    }
    return self;
}
-(UIColor *) randomColor
{
    CGFloat hue = ( arc4random() % 256 / 256.0 ); //0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5; // 0.5 to 1.0,away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5; //0.5 to 1.0,away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}
@end

