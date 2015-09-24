//
//  ListView.m
//  SongPlayer
//
//  Created by qianfeng01 on 15-4-19.
//  Copyright (c) 2015年 qianfeng01. All rights reserved.
//

#import "ListView.h"
#import "RequestUrl.h"
#import "HttpRequest.h"
#import "ListModel.h"
#import <UIImageView+AFNetworking.h>
#import <MJRefresh.h>
#import "MobCell.h"
#import "ListSongsController.h"
#import "MessageCenter.h"
@implementation ListView
{
    UICollectionView *_collectionView;
    NSMutableArray *_dataArr;
   
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
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
    _page=1;
    [_collectionView registerNib:[UINib nibWithNibName:@"MobCell" bundle:nil] forCellWithReuseIdentifier:@"MOB"];
    _dataArr=[NSMutableArray array];
    //[self addSubview:_collectionView];
    [self refreshUI];
    //[self getData];

    
}
-(void)refreshUI
{
    __weak ListView* weakSelf=self;
    [_collectionView addLegendHeaderWithRefreshingBlock:^{
    
        weakSelf.page=1;
        [weakSelf getData];
    
    }];
    [_collectionView.header beginRefreshing];
    
    [_collectionView addLegendFooterWithRefreshingBlock:^{
        weakSelf.page++;
       [weakSelf getData];
        
    }];
    //[_collectionView.footer beginRefreshing];
    _collectionView.footer.hidden = YES;
}
-(void)getData
{
    
    [[HttpRequest shareRequestManager] getSongListUrl:[NSString stringWithFormat:SongListUrl,_page] returnData:^( id response,NSError *error){
        if (_page==1) {
            [_dataArr removeAllObjects];
              [_collectionView.header endRefreshing];
        }else{
           
           
            [_collectionView.footer endRefreshing ];
        }
        
        [_dataArr addObjectsFromArray:response];
        [_collectionView reloadData];
        
        
        
    }];
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MobCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"MOB" forIndexPath:indexPath];
    ListModel *m=_dataArr[indexPath.row];
    cell.des.text=m.titlestr;
    [cell.img setImageWithURL:[NSURL URLWithString:m.pic_300]];
    cell.buttonhide=YES;
    
    return cell;
  
    

}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
   _collectionView.footer.hidden=_dataArr.count==0;
    return _dataArr.count;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(140, 175) ;
   
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
     return UIEdgeInsetsMake(10, 10, 10, 10) ;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    MessageCenter *center=[MessageCenter MessageManager];
    if (center.toPushLISTSONGView) {
        center.toPushLISTSONGView([_dataArr[indexPath.row] listid]);
    }
   
}


@end
