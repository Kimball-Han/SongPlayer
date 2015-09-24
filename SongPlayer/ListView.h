//
//  ListView.h
//  SongPlayer
//
//  Created by qianfeng01 on 15-4-19.
//  Copyright (c) 2015年 qianfeng01. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListView : UIView<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,assign)NSInteger page;
@end
