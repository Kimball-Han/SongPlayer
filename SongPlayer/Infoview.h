//
//  Infoview.h
//  SongPlayer
//
//  Created by qianfeng01 on 15-4-20.
//  Copyright (c) 2015年 qianfeng01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArtistModel.h"

typedef void(^callBack)(id des);
@interface Infoview : UIView
@property(nonatomic,strong)ArtistModel *m;
@property(nonatomic,copy)callBack share;
@end
