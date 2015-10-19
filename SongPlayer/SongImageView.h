//
//  SongImageView.h
//  SongPlayer
//
//  Created by qianfeng01 on 15-4-21.
//  Copyright (c) 2015年 qianfeng01. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^callBack)(id dat);
@interface SongImageView : UIView
@property(nonatomic,weak)UIImageView *image11;

@property(nonatomic,copy)callBack buttonClick;
@property(nonatomic,copy)callBack imageBack;
-(void)loadimage;
@end
