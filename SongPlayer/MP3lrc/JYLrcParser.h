//
//  JYLrcParser.h
//  歌词解析的封装
//
//  Created by Jerry on 15/1/12.
//  Copyright (c) 2015年 Jerry. All rights reserved.
//

#import <Foundation/Foundation.h>

// 歌词管理类
@interface JYLrcParser : NSObject

// 歌词作者 [ar:歌词作者]
@property NSString *author;
// 歌词所在的唱片集 [al:这首歌所在的唱片集]
@property NSString *albume;
// 本lrc编辑作者 [by:本LRC文件的创建者]
@property NSString *byEditor;
// 歌曲标题 [ti:歌词(歌曲)的标题]
@property NSString *title;
// 歌曲版本 [ve:程序的版本]
@property NSString *version;

//把解析的歌词模型 对象地址放入数组中
//存放的是JYLrcItem类的对象地址
@property NSMutableArray *allLrcItems;

// 初始化这个lrc
- (id) initWithFile:(NSString *)file;
// 通过second取得当前的歌词
- (NSString *) getLrcByTime:(float)second;
//显示歌曲信息
- (void)showSongInformation;

@end
