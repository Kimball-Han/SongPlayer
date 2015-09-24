//
//  JYLrcItem.m
//  歌词解析的封装
//
//  Created by Jerry on 15/1/12.
//  Copyright (c) 2015年 Jerry. All rights reserved.
//

#import "JYLrcItem.h"

@implementation JYLrcItem

- (JYLrcItem *)initWithTime:(float)time lrc:(NSString *)lrc
{
    if (self = [super init]) {
        _time = time;
        _lrc = lrc;
    }
    return self;
}

- (BOOL)isBiggerTimeThanLrcItem:(JYLrcItem *)lrcItem
{
    return self.time > lrcItem.time;
}

@end
