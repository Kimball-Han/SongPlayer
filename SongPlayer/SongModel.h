//
//  SongModel.h
//  SongPlayer
//
//  Created by qianfeng01 on 15-4-18.
//  Copyright (c) 2015年 qianfeng01. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SongModel : NSObject
@property(nonatomic,copy)NSString *song_id;
@property(nonatomic,copy)NSString *titlestr;
@property(nonatomic,copy)NSString *author;
@property(nonatomic,copy)NSString *ting_uid;
@property(nonatomic,copy)NSString *pic_small;
@property(nonatomic,copy)NSNumber *has_mv;
@property(nonatomic,copy)NSString *lrclink;
@property(nonatomic,assign)BOOL isLocal;


@end
