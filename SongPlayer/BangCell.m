//
//  BangCell.m
//  SongPlayer
//
//  Created by qianfeng01 on 15-4-19.
//  Copyright (c) 2015年 qianfeng01. All rights reserved.
//

#import "BangCell.h"
#import <UIImageView+AFNetworking.h>
@implementation BangCell

- (void)awakeFromNib {
    // Initialization code
}
-(void)setM:(BangModel *)m
{
    _m=m;
    [self.img setImageWithURL:[NSURL URLWithString:m.pic_s192]];
    self.songLb1.text=[NSString stringWithFormat:@"1.%@-%@",m.song1,m.song1au];
    self.songLb2.text=[NSString stringWithFormat:@"2.%@-%@",m.song2,m.song2au];
    self.songLb3.text=[NSString stringWithFormat:@"3.%@-%@",m.song3,m.song3au];
}

@end
