//
//  DownloadCell.h
//  SongPlayer
//
//  Created by HAN on 15/5/23.
//  Copyright (c) 2015年 qianfeng01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SongDownloadCenter.h"

typedef void(^FinishCall)(SongDownloadCenter *m);
@interface DownloadCell : UITableViewCell

@property(nonatomic,copy)SongDownloadCenter *m;
@property(nonatomic,assign)BOOL hideProLabel;
@property(nonatomic,copy)FinishCall Finish;
@end
