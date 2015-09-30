//
//  BangdanView.m
//  SongPlayer
//
//  Created by qianfeng01 on 15-4-19.
//  Copyright (c) 2015年 qianfeng01. All rights reserved.
//

#import "BangdanView.h"
#import <UIImageView+AFNetworking.h>
#import "RequestUrl.h"
#import "HttpRequest.h"
#import "BangModel.h"
#import "BangCell.h"
#import "MessageCenter.h"
#import "SongClass.h"
@implementation BangdanView

{
    UICollectionView *_collectionView;
    NSMutableArray *_dataArr;
    
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}
-(void)initUI
{
    UICollectionViewFlowLayout *layOut=[[UICollectionViewFlowLayout alloc] init];
    _collectionView=[[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layOut];
    [self addSubview:_collectionView];
    _collectionView.dataSource=self;
    _collectionView.delegate=self;
    _collectionView.backgroundColor=[UIColor whiteColor];
  
    [_collectionView registerNib:[UINib nibWithNibName:@"BangCell" bundle:nil] forCellWithReuseIdentifier:@"BANG"];
    _dataArr=[NSMutableArray array];
    
    [self getData];
    
    
}
-(void)getData
{
    [[HttpRequest shareRequestManager] getBangDanUrl:BangDanUrl returnData:^(id response,NSError *error){
        [_dataArr addObjectsFromArray:response];
        [_collectionView reloadData];
    }];
    
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BangCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"BANG" forIndexPath:indexPath];
    cell.m=_dataArr[indexPath.row];
    
    return cell;
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return _dataArr.count;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((Screen_Width-20)/2.0, (Screen_Width-20)*4.0/6.0) ;
    
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10.0;
    
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section;
{
    return UIEdgeInsetsMake(5, 5, 5, 5) ;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    BangCell *cell=(BangCell *)[_collectionView cellForItemAtIndexPath:indexPath];
   
        if ([MessageCenter MessageManager].ToPushBangView) {
            [MessageCenter MessageManager].ToPushBangView(cell.m.type);
        }
   
}


@end
