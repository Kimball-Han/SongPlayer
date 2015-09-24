//
//  MessageCenter.m
//  SongPlayer
//
//  Created by qianfeng01 on 15-4-20.
//  Copyright (c) 2015年 qianfeng01. All rights reserved.
//

#import "MessageCenter.h"

@implementation MessageCenter

+(MessageCenter *)MessageManager
{
   static dispatch_once_t onceToken;
    static MessageCenter *manager=nil;
    dispatch_once(&onceToken, ^{
        manager=[[MessageCenter alloc] init];
    });
    return manager;
    
}

@end
