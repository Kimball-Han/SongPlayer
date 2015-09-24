//
//  ABCView.h
//  SongPlayer
//
//  Created by qianfeng01 on 15-4-20.
//  Copyright (c) 2015年 qianfeng01. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^callback)(NSString *abc);
@interface ABCView : UIView


@property(nonatomic,copy)callback back;
@end
