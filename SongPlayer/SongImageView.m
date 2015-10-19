//
//  SongImageView.m
//  SongPlayer
//
//  Created by qianfeng01 on 15-4-21.
//  Copyright (c) 2015年 qianfeng01. All rights reserved.
//

#import "SongImageView.h"
#import <UIImageView+AFNetworking.h>
#import "PlayerCenter.h"
@implementation SongImageView
{
    UIImageView *_image;
    UILabel *_label;
    UIButton *_faButton;
    UIButton *_downButton;
    UIButton *_mvButton;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.masksToBounds=YES;
        self.clipsToBounds=YES;
        _image=[[UIImageView alloc] initWithFrame:CGRectMake(0, 32, self.bounds.size.width, self.bounds.size.height-65)];
        [_image setContentMode:UIViewContentModeScaleAspectFit];
        _image.clipsToBounds=YES;
        _image.layer.masksToBounds=YES;
     
        
        _label=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 30)];
        _label.textAlignment=NSTextAlignmentCenter;
        _label.textColor=[UIColor whiteColor];
        [self addSubview:_label];
        [PlayerCenter sharePlayerCenter].imageview=^{
            [self loadimage];
        };
        _downButton=[UIButton buttonWithType:UIButtonTypeCustom];
        _mvButton=[UIButton buttonWithType:UIButtonTypeCustom];
        _faButton=[UIButton buttonWithType:UIButtonTypeCustom];
        _downButton.frame=CGRectMake(self.bounds.size.width-50, self.bounds.size.height-28, 28, 28);
        _downButton.tag=10;
        
        _mvButton.frame=CGRectMake(self.bounds.size.width-100, self.bounds.size.height-28, 28, 28);
        _mvButton.tag=11;
        _faButton.frame=CGRectMake(self.bounds.size.width-150, self.bounds.size.height-28, 28, 28);
        _faButton.tag=12;
        [_downButton setImage:[UIImage imageNamed:@"bt_list_more_down02_press"] forState:UIControlStateSelected];
        [_downButton setImage:[UIImage imageNamed:@"bt_list_more_down02_normal"] forState:UIControlStateNormal];
        [_mvButton setImage:[UIImage imageNamed:@"bt_list_more_mtv_press"] forState:UIControlStateSelected];
        [_mvButton setImage:[UIImage imageNamed:@"bt_list_more_mtv_normal"] forState:UIControlStateNormal];
        [_faButton setImage:[UIImage imageNamed:@"bt_list_more_collection_choice"] forState:UIControlStateNormal];
        [_faButton setImage:[UIImage imageNamed:@"bt_list_more_collection_normal"] forState:UIControlStateSelected];
        [self addSubview:_faButton];
        [self addSubview:_downButton];
        [self addSubview:_mvButton];
        [_downButton addTarget:self action:@selector(more:) forControlEvents:UIControlEventTouchUpInside];
        [_mvButton addTarget:self action:@selector(more:) forControlEvents:UIControlEventTouchUpInside];
        [_faButton addTarget:self action:@selector(more:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}
-(void)more:(UIButton *)button
{
    if (self.buttonClick) {
        self.buttonClick(button);
    }
   
}
-(void)loadimage
{
    PlayerCenter *ce= [PlayerCenter sharePlayerCenter];
    _label.text=[NSString stringWithFormat:@"%@-%@",ce.m.name,ce.m.author];
    [_image setImageWithURL:[NSURL URLWithString:ce.m.imgUrl]placeholderImage:[UIImage imageNamed:@"35.jpg"]];
    self.image11.image=_image.image;
    
}

@end
