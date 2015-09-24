//
//  SectionCell.m
//  SongPlayer
//
//  Created by qianfeng01 on 15-4-19.
//  Copyright (c) 2015年 qianfeng01. All rights reserved.
//

#import "SectionCell.h"
#import "MessageCenter.h"
@implementation SectionCell

- (void)awakeFromNib {
    // Initialization code
}
-(void)setMoreHide:(BOOL)moreHide
{
    _moreHide=moreHide;
    if (_moreHide) {
        self.moreButton.hidden=YES;
    }else{
        self.moreButton.hidden=NO;
    }
}
- (IBAction)pushAlbum:(id)sender {
    if ([MessageCenter MessageManager].toPushAlbumsView) {
        [MessageCenter MessageManager].toPushAlbumsView(nil);
    }
}

@end
