//
//  ArtistModel.h
//  SongPlayer
//
//  Created by qianfeng01 on 15-4-19.
//  Copyright (c) 2015年 qianfeng01. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArtistModel : NSObject
@property(nonatomic,copy)NSString *ting_uid;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *avatar_big;
@property(nonatomic,copy)NSString *avatar_s500;
@property(nonatomic,copy)NSString *country;
@property(nonatomic,copy)NSString *intro;

@property(nonatomic,copy)NSString *birth;
@end
