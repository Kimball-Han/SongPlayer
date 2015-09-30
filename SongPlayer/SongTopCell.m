//
//  SongTopCell.m
//  SongPlayer
//
//  Created by qianfeng01 on 15-4-19.
//  Copyright (c) 2015年 qianfeng01. All rights reserved.
//

#import "SongTopCell.h"
#import <AFNetworking.h>
#import <UIImageView+AFNetworking.h>
#import "ArtistModel.h"
#import "RequestUrl.h"
#import "HttpRequest.h"
#import "MessageCenter.h"
#import "SongClass.h"
@implementation SongTopCell
{
    
    __weak IBOutlet UIScrollView *_scrollView;
    __weak IBOutlet UIPageControl *pagect;
    NSMutableArray *_dataArr;
}

- (void)awakeFromNib {
    _dataArr=[[NSMutableArray alloc] init];
    [self getData];
    _scrollView.delegate=self;
}
-(void)getData
{
    [[HttpRequest shareRequestManager] getHotSongerUrl:HotSongerUrl returnData:^(id response,NSError *error){
        [_dataArr addObjectsFromArray:response];
        [self customUI];
        
    }];
}
-(void)customUI
{
    for (int i=0; i<_dataArr.count; i++) {
        ArtistModel *model=_dataArr[i];
        UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake((Screen_Width-290)/4.0*(i/3+1)+(90+(Screen_Width-290)/4.0)*i, 0, 90, 90)];
        [_scrollView addSubview:imageView];
        imageView.userInteractionEnabled=YES;
        imageView.tag=10+i;
        [imageView setImageWithURL:[NSURL URLWithString:model.avatar_big]];
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ontap:)];
        [imageView addGestureRecognizer:tap];
        
        [_scrollView addSubview:imageView];
        UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake((Screen_Width-290)/4.0*(i/3+1)+(90+(Screen_Width-290)/4.0)*i, 90, 90, 30)];
        [_scrollView addSubview:label];
        label.textAlignment=NSTextAlignmentCenter;
        label.text=model.name;
        label.font=[UIFont systemFontOfSize:15];
    }
    _scrollView.pagingEnabled=YES;
    _scrollView.contentSize=CGSizeMake(_scrollView.frame.size.width*4,_scrollView.frame.size.height);
    _scrollView.showsHorizontalScrollIndicator=NO;
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    pagect.currentPage=scrollView.contentOffset.x/scrollView.frame.size.width;
}
-(void)ontap:(UITapGestureRecognizer *)tap
{
    MessageCenter *center=  [MessageCenter MessageManager];
    if (center.toPushArtistSongView) {
        center.toPushArtistSongView([_dataArr[tap.view.tag-10] ting_uid]);
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
