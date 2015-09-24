//
//  MobCell.h
//  SongPlayer
//
//  Created by qianfeng01 on 15-4-18.
//  Copyright (c) 2015年 qianfeng01. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MobCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *des;
@property (weak, nonatomic) IBOutlet UILabel *numlb;
@property (weak, nonatomic) IBOutlet UIImageView *smallimg;
@property (weak, nonatomic) IBOutlet UIView *btview;
@property(nonatomic,assign)BOOL buttonhide;
@end
