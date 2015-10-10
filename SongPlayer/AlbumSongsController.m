//
//  AlbumSongsController.m
//  SongPlayer
//
//  Created by qianfeng01 on 15-4-23.
//  Copyright (c) 2015年 qianfeng01. All rights reserved.
//

#import "AlbumSongsController.h"
#import "MobCell.h"
#import "AlbumModel.h"
#import "ViewController.h"
@interface AlbumSongsController ()<UICollectionViewDataSource,UICollectionViewDelegate>
{
    NSMutableArray *_dataArr;
}

@end

@implementation AlbumSongsController

- (void)viewDidLoad {
    _dataArr=[[NSMutableArray alloc] init];
   
    [super viewDidLoad];
    _collview.dataSource=self;
    _collview.delegate=self;
    [_collview registerNib:[UINib nibWithNibName:@"MobCell" bundle:nil] forCellWithReuseIdentifier:@"MOB"];
    [self.collview addLegendHeaderWithRefreshingBlock:^{
        self.offset=0;
        [self getData];
    }];
    [self.collview.header beginRefreshing];
//    [self.collview addLegendFooterWithRefreshingBlock:^{
//        self.offset=0;
//        [self getData];
//    }];
    
}
-(void)getData
{
    [[HttpRequest shareRequestManager] getMoreAlbumsByUrl:[NSString stringWithFormat:getMoreAlbumsUrl,(long)self.offset] returnData:^(id response,NSError *error){
        if (self.offset==0) {
            [_dataArr removeAllObjects];
            [_dataArr addObjectsFromArray:response];
            [_collview.header endRefreshing];
        }else{
        [_dataArr addObjectsFromArray:response];
            [_collview.footer endRefreshing ];
        }
        [self.collview reloadData];
        
    }];
}
- (IBAction)popview:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
     _collview.footer.hidden=_dataArr.count==0;
    return _dataArr.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MobCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"MOB" forIndexPath:indexPath];
    AlbumModel *m=_dataArr[indexPath.row];
    [cell.img setImageWithURL:[NSURL URLWithString:m.pic_big]];
    cell.des.text=[NSString stringWithFormat:@"%@\n%@",m.titlestr,m.author];
    cell.buttonhide=YES;
    return cell;

}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
return UIEdgeInsetsMake(10, 10, 10, 10) ;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
        return CGSizeMake(140, 175) ;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    AlbumModel *m=_dataArr[indexPath.row];
    ViewController *vie=[[ViewController alloc] init];
    vie.ablum_id=m.album_id;
    [self.navigationController pushViewController:vie animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
