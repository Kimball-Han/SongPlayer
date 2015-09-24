//
//  PlayerCenter.m
//  SongPlayer
//
//  Created by qianfeng01 on 15-4-20.
//  Copyright (c) 2015年 qianfeng01. All rights reserved.
//

#import "PlayerCenter.h"


#import "HttpRequest.h"

@implementation PlayerCenter
{
    AFSoundManager *_manager;
}
+(PlayerCenter *)sharePlayerCenter
{
    static dispatch_once_t onceToken;
    static PlayerCenter *center=nil;
    dispatch_once(&onceToken, ^{
        center=[[PlayerCenter alloc] init];
        
    });
    return center;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        _manager=[AFSoundManager sharedManager];
        [_manager forceOutputToDefaultDevice];
        AVAudioSession *session = [AVAudioSession sharedInstance];
        [session setActive:YES error:nil];
        [session setCategory:AVAudioSessionCategoryPlayback error:nil];
       
        
            }
    return self;
}
-(void)defaultPlay
{
    
}
-(void)setM:(playeSongMoel *)m
{
    _m=nil;
    _m=m;
    _manager.player=nil;
    _manager.audioPlayer=nil;
     dispatch_queue_t main=dispatch_get_main_queue();
    dispatch_async(main, ^{
        if (m.islocal) {
            [self local];
            [self loadLocalLrc];
        }else{
            [self streaming];
            [self loadMusicLrc];
        }
        if (self.imageview) {
            self.imageview();
        }

    });
   
}

-(void)play{
    [_manager resume];
}
-(void)pause{
    [_manager pause];
}

//本地音乐播放
-(void)local
{
    [[AFSoundManager sharedManager]startPlayingLocalFileWithName:_m.name andBlock:^(int percentage, CGFloat elapsedTime, CGFloat timeRemaining, NSError *error, BOOL finished) {
        if (!error) {
           //已经播放时间timeRemainingDate和剩余音乐播放时间timeRemaining
            NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
            [formatter setDateFormat:@"mm:ss"];
            NSDate *elapsedTimeDate = [NSDate dateWithTimeIntervalSince1970:elapsedTime];
            NSString *  elapsedTime = [formatter stringFromDate:elapsedTimeDate];
            NSDate *timeRemainingDate = [NSDate dateWithTimeIntervalSince1970:timeRemaining];
            NSString * timeRemaining = [formatter stringFromDate:timeRemainingDate];
            if (finished) {
                NSLog(@"11111");
                [[AFSoundManager sharedManager] stop]; 
            }
            //percentage当前播放进度
            //finished播放是否完成
                if (self.currentSatus) {
                    self.currentSatus(percentage,elapsedTime,timeRemaining,finished);
                }
            //歌词同步
                if (self.refrshMusicVC) {
                    self.refrshMusicVC(percentage,elapsedTime,timeRemaining,finished);
               }
        }else{
            //播放失败
            NSLog(@"There has been an error playing the local file: %@", [error description]);
        }
    }];

}
//网络音乐播放
-(void)streaming
{
    [[AFSoundManager sharedManager]startStreamingRemoteAudioFromURL:_m.NetLinkUrl andBlock:^(int percentage, CGFloat elapsedTime, CGFloat timeRemaining, NSError *error, BOOL finished) {
        if (!error) {
         //已经播放时间timeRemainingDate和剩余音乐播放时间timeRemaining
            NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
            [formatter setDateFormat:@"mm:ss"];
            NSDate *elapsedTimeDate = [NSDate dateWithTimeIntervalSince1970:elapsedTime];
            NSString *  elapsedTime = [formatter stringFromDate:elapsedTimeDate];
            NSDate *timeRemainingDate = [NSDate dateWithTimeIntervalSince1970:timeRemaining];
            NSString * timeRemaining = [formatter stringFromDate:timeRemainingDate];
            //percentage当前播放进度
            //finished播放是否完成
            if (finished) {
                 NSLog(@"bofangwancheng");
                [[AFSoundManager sharedManager] stop];
            }
                if (self.currentSatus) {
                    self.currentSatus(percentage,elapsedTime,timeRemaining,finished);
                }
            //歌词,歌词同步刷新
                if (self.refrshMusicVC) {
                    self.refrshMusicVC(percentage,elapsedTime,timeRemaining,finished);
                }
        } else {
            //播放失败
            NSLog(@"There has been an error playing the remote file: %@", [error description]);
        }
    }];
}
-(void)changeVolumeToValue:(CGFloat)volume
{
   
}
-(void)moveToSecond:(int)second
{
    [_manager moveToSecond:second];
}
-(void)loadMusicLrc
{

    NSString *str=[NSString stringWithFormat:@"/Documents/MusicLrc" ];
    NSString * path = [NSHomeDirectory() stringByAppendingString:str];
    NSFileManager * manager = [NSFileManager defaultManager];
    //创建文件夹
    if(![manager fileExistsAtPath:path]) {
        
        [manager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    //歌词路径
    NSString *pathLrc=  [path stringByAppendingFormat:@"/%@.lrc",[PlayerCenter sharePlayerCenter].m.name];
    
    [manager createFileAtPath:pathLrc contents:nil attributes:nil];
    
    [[HttpRequest shareRequestManager] downloadFileURL:[PlayerCenter sharePlayerCenter].m.lrclink savePath:path fileName:[PlayerCenter sharePlayerCenter].m.name succuss:^(NSString *ret,NSError *error){
        
        if ([ret isEqualToString:@"yes"]) {
            _lrcModel=nil;
            _lrcModel=[[JYLrcParser alloc] initWithFile:pathLrc];
            if (self.startPlay) {
                self.startPlay();
            }
        }
    }];
    
}
-(void)loadLocalLrc
{
    NSString *str=[NSString stringWithFormat:@"/Documents/MusicLrc" ];
    NSString * path = [NSHomeDirectory() stringByAppendingString:str];

    NSString *pathLrc=  [path stringByAppendingFormat:@"/%@.lrc",self.m.name];
    _lrcModel=nil;
    _lrcModel=[[JYLrcParser alloc] initWithFile:pathLrc];
    if (self.startPlay) {
        self.startPlay();
    }
}


@end
