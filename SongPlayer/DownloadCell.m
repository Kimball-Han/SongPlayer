//
//  DownloadCell.m
//  SongPlayer
//
//  Created by HAN on 15/5/23.
//  Copyright (c) 2015年 qianfeng01. All rights reserved.
//

#import "DownloadCell.h"
#import "SqliteCenter.h"
@implementation DownloadCell
{
    __weak IBOutlet UILabel *name;
    
    __weak IBOutlet UILabel *pro;
    __weak IBOutlet UILabel *subname;
}

- (void)awakeFromNib {
    // Initialization code
}
-(void)setM:(SongDownloadCenter *)m
{
    _m=m;
    name.text=m.m.titlestr;
    subname.text=m.m.author;
    __weak UILabel * weakPro=pro;
    __weak DownloadCell * weakSelf=self;
    _m.prob=^(NSString *prol){
        weakPro.text=[NSString stringWithFormat:@"%.2f%%",[prol floatValue]*100];
        if ([prol isEqualToString:@"YES"]) {
            [[SqliteCenter shareDataCenter] addDownloadSong:weakSelf.m.m];
            if (weakSelf.Finish) {
                weakSelf.Finish(weakSelf.m);
            }
        }
       
    };
    
}
-(void)setHideProLabel:(BOOL )hideProLabel
{
    _hideProLabel=hideProLabel;
    if (hideProLabel) {
        pro.hidden=YES;
        
    }else{
        pro.hidden=NO;
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
