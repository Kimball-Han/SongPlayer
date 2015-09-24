//
//  SongDownloadCenter.h
//  SongPlayer
//
//  Created by HAN on 15/5/23.
//  Copyright (c) 2015年 qianfeng01. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SongModel.h"

typedef void(^proBlcok)(NSString *pro);
@interface SongDownloadCenter : NSObject
@property(nonatomic,copy)SongModel *m;
@property(nonatomic,copy)NSString *progress;
@property(nonatomic,copy)proBlcok prob;
@end
