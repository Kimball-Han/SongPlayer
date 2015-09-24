//
//  SliderViewCell.m
//  SongPlayer
//
//  Created by qianfeng01 on 15-4-18.
//  Copyright (c) 2015年 qianfeng01. All rights reserved.
//

#import "SliderViewCell.h"
#import <UIImageView+AFNetworking.h>
#import "RequestUrl.h"
#import "HttpRequest.h"
#import "MessageCenter.h"
@implementation SliderViewCell
{
    NSMutableArray * _dateArr;
}

- (void)awakeFromNib{
    [self getdata];
}
-(void)getdata
{
    _dateArr=[[NSMutableArray alloc] init];
     _scrollView.contentSize=CGSizeMake(self.bounds.size.width*5,self.bounds.size.height);
    _scrollView.delegate=self;
    _scrollView.pagingEnabled=YES;
    _scrollView.contentSize=CGSizeMake(self.bounds.size.width*5, 0);
    [[HttpRequest shareRequestManager] getFirstTopUrl:firstUpUrl returnData:^(id response,NSError *error){
        [_dateArr addObjectsFromArray:response];
        [self customUI];
    }];
    
}
-(void)customUI
{
    if (_dateArr.count<5) {
        return;
    }
    for (int i=0; i<5; i++) {
        _scrollView.bounces=NO;
        _scrollView.showsHorizontalScrollIndicator=NO;
        _scrollView.userInteractionEnabled=YES;
        UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(self.bounds.size.width*i, 0, self.bounds.size.width, self.bounds.size.height)];
        NSDictionary *dic=_dateArr[i];
        imageView.userInteractionEnabled=YES;
        imageView.tag=10+i;
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ontap:)];
        
        [imageView addGestureRecognizer:tap];
     
        [imageView setImageWithURL:[NSURL URLWithString:dic[@"randpic"]]];
        [_scrollView addSubview:imageView];
        
    }
   
}
-(void)ontap:(UITapGestureRecognizer *)tap
{
     MessageCenter *message=[MessageCenter MessageManager];
    if (message.sliderInfo) {
        message.sliderInfo(_dateArr[tap.view.tag-10]);
    }
  
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    _pageControl.currentPage=scrollView.contentOffset.x/scrollView.bounds.size.width;
}


@end
