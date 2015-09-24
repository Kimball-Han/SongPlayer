//
//  BangCell.h
//  SongPlayer
//
//  Created by qianfeng01 on 15-4-19.
//  Copyright (c) 2015年 qianfeng01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BangModel.h"
@interface BangCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *songLb1;
@property (weak, nonatomic) IBOutlet UILabel *songLb2;
@property (weak, nonatomic) IBOutlet UILabel *songLb3;
@property (nonatomic,strong) BangModel *m;
@end
