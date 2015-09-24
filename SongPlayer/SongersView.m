//
//  SongersView.m
//  SongPlayer
//
//  Created by qianfeng01 on 15-4-19.
//  Copyright (c) 2015年 qianfeng01. All rights reserved.
//

#import "SongersView.h"
#import "SongTopCell.h"
#import "SongerUnCell.h"
#import "MessageCenter.h"
@implementation SongersView
{
    NSMutableArray *_dataArr;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self getData];
        self.dataSource=self;
        self.delegate=self;
        [self registerNib:[UINib nibWithNibName:@"SongTopCell" bundle:nil] forCellReuseIdentifier:@"SOTO"];
        [self registerNib:[UINib nibWithNibName:@"SongerUnCell" bundle:nil] forCellReuseIdentifier:@"CATE"];
    }
    return self;
}
-(void)getData
{
    _dataArr =[NSMutableArray array];
      NSDictionary *dic=@{@"name":@"华语男歌手",@"area":@"6",@"sex":@"1"};
      NSDictionary *dic1=@{@"name":@"华语女歌手",@"area":@"6",@"sex":@"2"};
      NSDictionary *dic2=@{@"name":@"华语乐队组合",@"area":@"6",@"sex":@"3"};
    NSArray *arr1=@[dic,dic1,dic2];
    
      NSDictionary *dic3=@{@"name":@"欧美男歌手",@"area":@"3",@"sex":@"1"};
      NSDictionary *dic4=@{@"name":@"欧美女歌手",@"area":@"3",@"sex":@"2"};
      NSDictionary *dic5=@{@"name":@"欧美乐队组合",@"area":@"3",@"sex":@"3"};
     NSArray *arr2=@[dic3,dic4,dic5];
    
      NSDictionary *dic6=@{@"name":@"韩国男歌手",@"area":@"7",@"sex":@"1"};
      NSDictionary *dic7=@{@"name":@"韩国女歌手",@"area":@"7",@"sex":@"2"};
      NSDictionary *dic8=@{@"name":@"韩国乐队组合",@"area":@"7",@"sex":@"3"};
     NSArray *arr3=@[dic6,dic7,dic8];
    
      NSDictionary *dic9=@{@"name":@"日本男歌手",@"area":@"60",@"sex":@"1"};
      NSDictionary *dic10=@{@"name":@"日本女歌手",@"area":@"60",@"sex":@"2"};
      NSDictionary *dic11=@{@"name":@"日本乐队组合",@"area":@"60",@"sex":@"3"};
     NSArray *arr4=@[dic9,dic10,dic11];
    
      NSDictionary *dic12=@{@"name":@"其他",@"area":@"5",@"sex":@"4"};
     NSArray *arr5=@[dic12];
    [_dataArr addObject:arr1];
    [_dataArr addObject:arr2];
    [_dataArr addObject:arr3];
    [_dataArr addObject:arr4];
    [_dataArr addObject:arr5];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0||section==5) {
        return 1;
    }else{
        return 3;
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 6;
}
-(UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
     SongTopCell *cell=   [tableView dequeueReusableCellWithIdentifier:@"SOTO"];
        return cell;
    }
    NSArray *arr=_dataArr[indexPath.section-1];
    
    SongerUnCell *cell=[tableView dequeueReusableCellWithIdentifier:@"CATE"];
    cell.cateSonger.text=arr[indexPath.row][@"name"];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section!=0) {
        MessageCenter *manager=[MessageCenter MessageManager];
        if (manager.toPushArtistView) {
            manager.toPushArtistView(_dataArr[indexPath.section-1][indexPath.row]);
        }
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 210;
    }else{
        return 40;
    }

}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
@end
