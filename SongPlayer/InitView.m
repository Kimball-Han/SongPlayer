//
//  InitView.m
//  SongPlayer
//
//  Created by qianfeng01 on 15-4-19.
//  Copyright (c) 2015年 qianfeng01. All rights reserved.
//

#import "InitView.h"
#import "RequestUrl.h"
#import "HttpRequest.h"
#import "SliderViewCell.h"
#import "MobCell.h"
#import "AlbumModel.h"
#import "SectionCell.h"
#import "MessageCenter.h"
#import <UIImageView+AFNetworking.h>
@implementation InitView
{
    UICollectionView *_collectionView;
    NSMutableArray *_moddataArr;
    NSMutableArray *_botdataArr;

}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
        _collectionView=[[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        _collectionView.backgroundColor=[UIColor whiteColor];
        [self addSubview:_collectionView];
       
      
        [self first];
    
    }
    return self;
}
-(void)first
{
    _botdataArr=[[NSMutableArray alloc] init];
    _moddataArr=[[NSMutableArray alloc] init];
    
   _collectionView.dataSource=self;
   _collectionView.delegate=self;
    [_collectionView registerNib:[UINib nibWithNibName:@"SliderViewCell" bundle:nil] forCellWithReuseIdentifier:@"SLI"];
   [ _collectionView registerNib:[UINib nibWithNibName:@"MobCell" bundle:nil ]forCellWithReuseIdentifier:@"MOB"];
    [ _collectionView registerNib:[UINib nibWithNibName:@"SectionCell" bundle:nil ]forCellWithReuseIdentifier:@"SEC"];
    [self getData];
}
-(void)getData
{
    [[HttpRequest shareRequestManager] getFirstModUrl:firstMobUrl returnData:^(id response,NSError *error){
        [_moddataArr addObjectsFromArray:response];
        [_collectionView reloadData];
    }];
    [[HttpRequest shareRequestManager] getFirstBotUrl:firstBotUrl returnData:^(id response,NSError *error){
        [_botdataArr addObjectsFromArray:response];
        [_collectionView reloadData];
    }];
    
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    switch (indexPath.section) {
        case 0:
        {
            SliderViewCell *cell= [collectionView dequeueReusableCellWithReuseIdentifier:@"SLI" forIndexPath:indexPath];
            return cell;
        }
            break;
        case 1:
        {
            SectionCell *cell= [collectionView dequeueReusableCellWithReuseIdentifier:@"SEC" forIndexPath:indexPath];
            cell.titleLb.text=@"歌单推荐";
            cell.moreHide=YES;
            return cell;
        }
            break;

            
        case 2:
        {
            MobCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"MOB" forIndexPath:indexPath];
            NSDictionary *dic=_moddataArr[indexPath.row];
            cell.des.text=dic[@"title"];
            [cell.img setImageWithURL:[NSURL URLWithString:dic[@"pic"]] placeholderImage:[UIImage imageNamed:@""]];
            cell.numlb.text=dic[@"listenum"];
            cell.buttonhide=NO;
            return cell;
            
        }
            break;
        case 3:
        {
            SectionCell *cell= [collectionView dequeueReusableCellWithReuseIdentifier:@"SEC" forIndexPath:indexPath];
            cell.titleLb.text=@"新碟上架";
            cell.moreHide=NO;
            return cell;
        }
            break;
        case 4:
        {
            MobCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"MOB" forIndexPath:indexPath];
            AlbumModel *m=_botdataArr[indexPath.row];
            [cell.img setImageWithURL:[NSURL URLWithString:m.pic_big]];
            cell.des.text=[NSString stringWithFormat:@"%@\n%@",m.titlestr,m.author];
            cell.buttonhide=YES;
            return cell;
            
        }
            break;
            
        default:
        {
            UICollectionViewCell *cell=[[UICollectionViewCell alloc] init];
            return cell;
        }
            break;
    }
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 1;
            break;
        case 2:
            return _moddataArr.count;
            break;
        case 3:
            return 1;
            break;
        case 4:
            return _botdataArr.count;
            break;
            
        default:
            return 0;
            break;
    }
    
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 5;
}



- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            return CGSizeMake(320, 140);
            break;
        case 1:
            return CGSizeMake(320, 40);
            break;

        case 2:
            return CGSizeMake(140, 175) ;
            break;
        case 3:
            return CGSizeMake(320, 40);
            break;

        case 4:
            return CGSizeMake(140, 175);
            break;
            
        default:
            return CGSizeMake(140, 175);
            break;
    }
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10.0;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section;
{
    switch (section) {
        case 0:
            return UIEdgeInsetsMake(5, 0, 5, 0);
            break;
        case 1:
            return UIEdgeInsetsMake(5, 0, 5, 0);
            break;
        case 2:
            return UIEdgeInsetsMake(10, 10, 10, 10) ;
            break;
        case 3:
            return UIEdgeInsetsMake(5, 0, 5, 0);
            break;
        case 4:
            return UIEdgeInsetsMake(10, 10, 10, 10);
            break;
            
        default:
            return UIEdgeInsetsMake(10, 10, 10, 10);
            break;
    }

}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    MessageCenter *message=[MessageCenter MessageManager];
    if (indexPath.section==2) {
        if (message.topushListSongView2) {
            message.topushListSongView2(_moddataArr[indexPath.row][@"listid"] );
        }
    }
    if (indexPath.section==4) {
        if (message.toPushAlbumSongsview2) {
            message.toPushAlbumSongsview2([_botdataArr[indexPath.row] album_id]);
        }
    }

}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
