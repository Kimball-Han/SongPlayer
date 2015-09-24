//
//  MusicCenterController.h
//  SongPlayer
//
//  Created by qianfeng01 on 15-4-21.
//  Copyright (c) 2015年 qianfeng01. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MusicCenterController : UIViewController

+(MusicCenterController*)CenterController;
@property(nonatomic,copy)NSArray *dataArr;
@property(nonatomic,assign)NSInteger curentIndex;
-(void)getlinkUrlAndPlayer:(NSString *)songid;
-(void)playsong;
@end
