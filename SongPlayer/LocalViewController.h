//
//  LocalViewController.h
//  SongPlayer
//
//  Created by qianfeng01 on 15-5-5.
//  Copyright (c) 2015年 qianfeng01. All rights reserved.
//

#import "BaseViewController.h"

@interface LocalViewController : BaseViewController

+(LocalViewController *)DownloadCenter;
@property(nonatomic,copy)NSMutableArray *dataArr;
@property(nonatomic,copy)NSMutableArray *DownLoadArr;
@property(nonatomic,copy)NSMutableArray *arr;
@property(nonatomic,assign)BOOL isPresent;

@end
