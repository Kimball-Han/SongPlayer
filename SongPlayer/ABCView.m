//
//  ABCView.m
//  SongPlayer
//
//  Created by qianfeng01 on 15-4-20.
//  Copyright (c) 2015年 qianfeng01. All rights reserved.
//

#import "ABCView.h"

@implementation ABCView

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
        [self customUI];
    }
    return self;
}
-(void)customUI
{
    NSMutableArray *arr=[[NSMutableArray alloc] init];
    [arr addObject:@"热门"];
    for (int i=0; i<26; i++) {
        [arr addObject:[NSString
                        stringWithFormat:@"%c",('A'+i)]];
        
    }
    self.backgroundColor=[UIColor whiteColor];
    [arr addObject:@"其他"];
    UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 39)];
    label.textAlignment=NSTextAlignmentCenter;
    label.text=@"歌手首字母";
    [self addSubview:label];
    for (int i=0; i<arr.count; i++) {
        UIButton *button=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        button.frame=CGRectMake((i%4)*80, 40+(i/4)*40, 79, 39);
        [button setTitle:arr[i] forState:UIControlStateNormal];
        [self addSubview: button];
        [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        button.tag=10+i;
    }
    UIButton*but=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    but.frame=CGRectMake(0, 320, self.bounds.size.width, 40);
    but.tag=8;
    [but setTitle:@"关闭" forState:UIControlStateNormal];
    [but addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:but];
    
    
    
}
-(void)click:(UIButton *)button
{
    if (button.tag>=10) {
        if (self.back) {
            self.back([button titleForState:UIControlStateNormal]);
        }
    }else{
        if (self.back) {
            self.back(nil);
        }
    }
}

@end
