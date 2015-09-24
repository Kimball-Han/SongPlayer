                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  //
//  JYLrcParser.m
//  歌词解析的封装
//
//  Created by Jerry on 15/1/12.
//  Copyright (c) 2015年 Jerry. All rights reserved.
//

#import "JYLrcParser.h"
#import "JYLrcItem.h"

@implementation JYLrcParser

- (id)initWithFile:(NSString *)file
{
    if (self = [super init]) {
        _allLrcItems = [[NSMutableArray alloc] init];
      
        [self parseLrcFromFile:file];
    }
    return self;
}

- (void)parseLrcFromFile:(NSString *)file
{
    //1、读取歌词文件内容，内容如下：
    NSString *lrcFile = [NSString stringWithContentsOfFile:file encoding:NSUTF8StringEncoding error:nil];
//    [ti:蓝莲花]
//    [ar:许巍]
//    [al:时光-漫步]
//    [by:fanver]
//    [offset:500]
//    [00:00.20]蓝莲花
    
    //2、将歌词内容按照'\n'进行切割
    NSArray *lrcAry = [lrcFile componentsSeparatedByString:@"\n"];
    
    if (lrcAry.count==0) {
        return;
    }
    //3、遍历数组，解析【歌曲信息】和【歌词信息】
    for (NSString *str in lrcAry) {
        //解决那个二哥随意在歌词文件中添加空行的问题
        if ([str isEqualToString:@""]) {
            continue;
        }
        if (str.length<2) {
            continue;
        }
        unichar ch=[str characterAtIndex:1];
        //4、获取每行的第1个字符
       
        //判断是否是数字
        if (ch>='0' && ch<='9') {
            //5-1、是歌词信息，封装一个函数进行解析
            [self parseLrcFromTimeString:str];
        } else {
            //5-2、是歌曲信息，封装一个函数进行解析
            //[self parseLrcFromInfoString:str];
        }
    }
    
    //6、全部解析完后，按照时间先后进行排序
    [self sortByTime];
}

- (void)parseLrcFromTimeString:(NSString *)timeString
{
    //[02:11.27][01:50.22][00:21.95]穿过幽暗地岁月
    //1、按照']'进行切割
    NSArray *array = [timeString componentsSeparatedByString:@"]"];
    //[02:11.27
    //[01:50.22
    //[00:21.95
    //穿过幽暗地岁月
    
    //2、判断是否有歌词，没有就直接返回
    if (array.count == 1) {
        return;
    }
    //3、提取歌词内容: 穿过幽暗地岁月
    NSString *lrc = array[array.count - 1];
    //4、循环遍历数组，提取时间信息
    for (int i=0; i<array.count-1; i++) {
        //[02:11.27
         
        //5、提取时间 【分】【秒】，然后合并
        float min = [[array[i] substringWithRange:NSMakeRange(1, 2)] floatValue];
        float sec = [[array[i] substringFromIndex:4] floatValue];
        float time = min*60 + sec;
        
        //6、创建JYLrcItem对象
        JYLrcItem *lrcItem = [[JYLrcItem alloc] initWithTime:time lrc:lrc];
        
        //7、将JYLrcItem对象添加到数组中
        [_allLrcItems addObject:lrcItem];
    }
}

- (void)parseLrcFromInfoString:(NSString *)infoString
{
    //    [ti:蓝莲花]
    //    [ar:许巍]
    //    [al:时光-漫步]
    //    [by:fanver]
    //    [offset:500]
    
    //1、按照':'进行切割
    NSArray *array = [infoString componentsSeparatedByString:@":"];
    
    //    [ti
    //    蓝莲花]
    //2、提取信息说明  【[ti】
    
    if (array.count==1) {
        NSLog(@"歌词文件格式不支持");
        return;
    }
    
    NSString *str = array[0];
    //3、提取信息有效内容  【蓝莲花】
    //先计算有效信息的长度
    if ([array[1] length]<=0) {
        return;
    }
    NSUInteger len = [array[1] length] - 1;
    NSString *info = [array[1] substringToIndex:len];
    //4、判断是歌曲的那个信息，并进行更新
    if ([str isEqualToString:@"[ti"]) {
        _title = info;
    } else if ([str isEqualToString:@"[ar"]) {
        _author = info;
    } else if ([str isEqualToString:@"[al"]) {
        _albume = info;
    } else if ([str isEqualToString:@"[by"]) {
        _byEditor = info;
    } else if ([str isEqualToString:@"[ve"]) {
        _version = info;
    }
}

- (NSString *)getLrcByTime:(float)second
{
    //11
    
    //9
    //10
    //15
    //18
    
    if (_allLrcItems.count == 0) {
        return @"木有找个歌词";
   }
    NSUInteger index = _allLrcItems.count - 1;
    //循环遍历数组，查找合适歌词
    for (int i=0; i<_allLrcItems.count; i++) {
        if ([_allLrcItems[i] time] > second) {
            index = i - (i!=0);
            break;
        }
    }
    return [_allLrcItems[index] lrc];
}

- (void)sortByTime
{
    [_allLrcItems sortUsingSelector:@selector(isBiggerTimeThanLrcItem:)];
}

- (void)showSongInformation
{
    // 歌词作者 [ar:歌词作者]
    //@property NSString *author;
    // 歌词所在的唱片集 [al:这首歌所在的唱片集]
    //@property NSString *albume;
    // 本lrc编辑作者 [by:本LRC文件的创建者]
    //@property NSString *byEditor;
    // 歌曲标题 [ti:歌词(歌曲)的标题]
    //@property NSString *title;
    // 歌曲版本 [ve:程序的版本]
    //@property NSString *version;
    
    if (_author) {
        printf("艺术家：%s\n", [_author UTF8String]);
    }
    if (_albume) {
        printf("专辑：%s\n", [_albume UTF8String]);
    }
    if (_title) {
        printf("歌名：%s\n", [_title UTF8String]);
    }
    if (_byEditor) {
        printf("编辑：%s\n", [_byEditor UTF8String]);
    }
    if (_version) {
        printf("版本：%s\n", [_version UTF8String]);
    }
}

@end
