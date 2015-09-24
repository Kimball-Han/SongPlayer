//
//  SqliteCenter.h
//  SongPlayer
//
//  Created by HAN on 15/5/24.
//  Copyright (c) 2015年 qianfeng01. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "playeSongMoel.h"
#import "SongDownloadCenter.h"
#import "SongModel.h"
@interface SqliteCenter : NSObject
+(SqliteCenter *)shareDataCenter;
-(void)ScanningTheLocalSongs;
-(BOOL)addDownloadSong:(SongModel *)model;
-(BOOL)addPlaySongModel:(playeSongMoel *)model;
-(NSMutableArray *)readLocalSongsFromSqlite;
-(NSMutableArray *)readFaSongsFromSqlite;
@end
