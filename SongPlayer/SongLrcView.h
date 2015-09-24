//
//  SongLrcView.h
//  SongPlayer
//
//  Created by qianfeng01 on 15-4-21.
//  Copyright (c) 2015年 qianfeng01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayerCenter.h"
#import "RequestUrl.h"
#import "HttpRequest.h"

@interface SongLrcView : UIView<UITableViewDelegate,UITableViewDataSource>
-(void)getdata;
@end
