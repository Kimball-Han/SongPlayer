//
//  PlayerCenter.h
//  SongPlayer
//
//  Created by qianfeng01 on 15-4-20.
//  Copyright (c) 2015年 qianfeng01. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "playeSongMoel.h"
#import "AFSoundManager.h"
#import <AVFoundation/AVFoundation.h>
#import "JYLrcParser.h"
typedef void(^refreshSongInfo)(int percentage, NSString *elapsedTime,NSString *timeRemaining,BOOL finished);
typedef void(^message)();

@interface PlayerCenter : NSObject
@property(nonatomic,strong)playeSongMoel *m;
@property(nonatomic,strong) JYLrcParser *lrcModel;

@property(nonatomic,copy)refreshSongInfo currentSatus;
@property(nonatomic,copy)refreshSongInfo refrshMusicVC;
@property(nonatomic,copy)message startPlay;
@property(nonatomic,copy)message imageview;
@property(nonatomic,assign)BOOL playing;


+(PlayerCenter *)sharePlayerCenter;
-(void)defaultPlay;
-(void)play;
-(void)pause;
-(void)changeVolumeToValue:(CGFloat)volume;
-(void)moveToSecond:(int)second;
@end
