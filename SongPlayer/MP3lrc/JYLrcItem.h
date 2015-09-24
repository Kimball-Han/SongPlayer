//
//  JYLrcItem.h
//  歌词解析的封装
//
//  Created by Jerry on 15/1/12.
//  Copyright (c) 2015年 Jerry. All rights reserved.
//

#import <Foundation/Foundation.h>

// 歌词类
@interface JYLrcItem : NSObject

@property (nonatomic) float time;
@property (nonatomic) NSString *lrc;

- (JYLrcItem *)initWithTime:(float)time lrc:(NSString *)lrc;

- (BOOL)isBiggerTimeThanLrcItem:(JYLrcItem *)lrcItem;

@end
