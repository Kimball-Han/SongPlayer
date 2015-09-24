//
//  ArtistViewController.h
//  SongPlayer
//
//  Created by qianfeng01 on 15-4-20.
//  Copyright (c) 2015年 qianfeng01. All rights reserved.
//

#import "BaseViewController.h"

@interface ArtistViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UILabel *namelb;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *area;
@property(nonatomic,copy)NSString *sex;
@property(nonatomic,copy)NSString *cate;
@property(nonatomic,assign)NSInteger offset;
@end
