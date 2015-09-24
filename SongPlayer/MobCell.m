//
//  MobCell.m
//  SongPlayer
//
//  Created by qianfeng01 on 15-4-18.
//  Copyright (c) 2015年 qianfeng01. All rights reserved.
//

#import "MobCell.h"

@implementation MobCell

- (void)awakeFromNib {
    // Initialization code
}
-(void)setButtonhide:(BOOL)buttonhide
{
    _buttonhide=buttonhide;
    if (_buttonhide) {
        self.numlb.hidden=YES;
        self.smallimg.hidden=YES;
        self.btview.hidden=YES;
    }else{
        self.numlb.hidden=NO;
        self.smallimg.hidden=NO;
        self.btview.hidden=NO;
    }
    
}

@end
