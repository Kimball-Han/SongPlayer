//
//  playeSongMoel.h
//  SongPlayer
//
//  Created by qianfeng01 on 15-4-20.
//  Copyright (c) 2015年 qianfeng01. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface playeSongMoel : NSObject

@property(nonatomic,assign)BOOL islocal;
@property(nonatomic,copy)NSString * name;
@property(nonatomic,copy)NSString * NetLinkUrl;
@property(nonatomic,copy)NSString * lrclink;
@property(nonatomic,copy)NSString * imgUrl;
@property(nonatomic,copy)NSString * imgPath;
@property(nonatomic,copy)NSString * des;
@property(nonatomic,copy)NSString * author;
@end
