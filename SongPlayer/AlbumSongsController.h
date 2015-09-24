//
//  AlbumSongsController.h
//  SongPlayer
//
//  Created by qianfeng01 on 15-4-23.
//  Copyright (c) 2015年 qianfeng01. All rights reserved.
//

#import "BaseViewController.h"

@interface AlbumSongsController : BaseViewController
@property (weak, nonatomic) IBOutlet UICollectionView *collview;
@property (weak, nonatomic) IBOutlet UIView *topview;

@property (weak, nonatomic) IBOutlet UILabel *titlelb;
@property (assign,nonatomic)NSInteger  offset;

@end
