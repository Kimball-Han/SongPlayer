//
//  SongLrcView.m
//  SongPlayer
//
//  Created by qianfeng01 on 15-4-21.
//  Copyright (c) 2015年 qianfeng01. All rights reserved.
//

#import "SongLrcView.h"
#import "JYLrcItem.h"
#import "JYLrcParser.h"
#import "HttpRequest.h"
#import "LrcRowCell.h"
#import "PlayerCenter.h"
@implementation SongLrcView
{
    UITableView *_tableview;
    JYLrcParser *_lrcModel;
    CGPoint _point;
    NSInteger index;
    NSInteger centerIndex;

}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _tableview=[[UITableView alloc] initWithFrame:self.bounds];
        self.backgroundColor=[UIColor clearColor];
        _tableview.delegate=self;
        _tableview.dataSource=self;
        centerIndex=frame.size.height/50;
        [self createUI];
    }
    return self;
}
-(void)getdata
{
    _lrcModel=nil;
    _lrcModel=[PlayerCenter sharePlayerCenter].lrcModel;
    [_tableview reloadData];
}
-(void)createUI
{
       [self addSubview:_tableview];
    _point=_tableview.contentOffset;
    _tableview.showsVerticalScrollIndicator=NO;
    _tableview.userInteractionEnabled=YES;
    [_tableview registerNib:[UINib nibWithNibName:@"LrcRowCell" bundle:nil] forCellReuseIdentifier:@"LRCID"];
   
    [_tableview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    _tableview.backgroundColor = [UIColor clearColor];
    _tableview.rowHeight=30.0f;
    
     [PlayerCenter sharePlayerCenter].startPlay=^
        {
        [self getdata];
        };
        [PlayerCenter sharePlayerCenter].currentSatus=^(int percentage, NSString *elapsedTime,NSString *timeRemaining,BOOL finished){
            
            
            NSInteger second = 0;
            NSArray *arry=[elapsedTime componentsSeparatedByString:@":"];
            if (arry.count==2) {
                second =[arry[0] integerValue]*60+[arry[1] integerValue]+1;
            }
           
            
            if (_lrcModel.allLrcItems.count == 0) {
                
            }else{
                index = _lrcModel.allLrcItems.count - 1;
                //循环遍历数组，查找当前歌词在数组中的位置
                static NSInteger j=0;
                for (int i=0; i<_lrcModel.allLrcItems.count; i++) {
                    JYLrcItem *ite=_lrcModel.allLrcItems[i];
                    if (ite.time > second) {
                        index = i - (i!=0);
                        break;
                    }
                }
                if (index==0) {
                    LrcRowCell *cell1=(LrcRowCell *)[_tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
                    cell1.linelrc.font=[UIFont systemFontOfSize:20];
                    cell1.linelrc.textColor=[UIColor purpleColor] ;
                }
                
                if (index!=j) {
                    LrcRowCell *cell=(LrcRowCell *)[_tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:j inSection:0]];
                    cell.linelrc.font=[UIFont systemFontOfSize:16];
                    cell.linelrc.textColor=[UIColor  whiteColor];
                    
                    j=index;
                    
                    LrcRowCell *cell1=(LrcRowCell *)[_tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
                    cell1.linelrc.font=[UIFont systemFontOfSize:20];
                  
                    cell1.linelrc.textColor=[UIColor purpleColor] ;
                  //  cell1.linelrc.font=[UIFont fontWithName:@"American Typewrite-bold" size:20];
                    CGPoint  point=_point;
                   // if (index>7) {
                        point.y=25.0*(index-centerIndex);
                    
                    //}
                    
                    [_tableview setContentOffset:point animated:YES];
                    if (index==_lrcModel.allLrcItems.count) {
                        j=0;
                    }
                    
                }
            }
            
        };
  

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_lrcModel==nil) {
        return 0;
        
    }else{
        return  _lrcModel.allLrcItems.count;
    }
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LrcRowCell *cell=[tableView dequeueReusableCellWithIdentifier:@"LRCID"];
    cell.linelrc.font=[UIFont systemFontOfSize:14];
    cell.linelrc.textColor=[UIColor whiteColor];
    if (indexPath.row==index) {
        cell.linelrc.font=[UIFont systemFontOfSize:20];
        cell.linelrc.textColor=[UIColor purpleColor] ;
         //  cell.linelrc.font=[UIFont fontWithName:@"American Typewrite-bold" size:20];
        
    }
    if (_lrcModel.allLrcItems.count>indexPath.row) {
        cell.linelrc.text=[_lrcModel.allLrcItems[indexPath.row] lrc] ;
         
    }
    
    return cell;
}

@end
