//
//  Infoview.m
//  SongPlayer
//
//  Created by qianfeng01 on 15-4-20.
//  Copyright (c) 2015年 qianfeng01. All rights reserved.
//

#import "Infoview.h"

@implementation Infoview
{
    __weak IBOutlet UILabel *authorname;
    
    __weak IBOutlet UILabel *birth;
    __weak IBOutlet UILabel *country;
}
- (IBAction)shareButton:(id)sender {
    if (self.share) {
        self.share(self.m);
    }
}
-(void)setM:(ArtistModel *)m
{
    _m=m;
    authorname.text=m.name;
    country.text=m.country;
    
   birth.text=m.birth;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
