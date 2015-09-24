//
//  ListTCell.h
//  SongPlayer
//
//  Created by qianfeng01 on 15-4-23.
//  Copyright (c) 2015年 qianfeng01. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListTCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *songLb;
@property (weak, nonatomic) IBOutlet UILabel *author;

@end
