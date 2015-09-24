//
//  MessageCenter.h
//  SongPlayer
//
//  Created by qianfeng01 on 15-4-20.
//  Copyright (c) 2015年 qianfeng01. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^Transfer)(id message);
@interface MessageCenter : NSObject
+(MessageCenter *)MessageManager;
@property(nonatomic,copy)Transfer toPushArtistView;
@property(nonatomic,copy)Transfer toPushArtistSongView;
@property(nonatomic,copy)Transfer ToPushBangView;
@property(nonatomic,copy)Transfer toPushLISTSONGView;
@property(nonatomic,copy)Transfer topushListSongView2;
@property(nonatomic,copy)Transfer toPushAlbumsView;
@property(nonatomic,copy)Transfer toPushAlbumSongsview2;
@property(nonatomic,copy)Transfer sliderInfo;
@property(nonatomic,copy)Transfer searchInfo;


@end
