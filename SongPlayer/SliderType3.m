//
//  SliderType3.m
//  SongPlayer
//
//  Created by qianfeng01 on 15-4-27.
//  Copyright (c) 2015年 qianfeng01. All rights reserved.
//

#import "SliderType3.h"
#import "SongModel.h"
#import "ListTCell.h"
@interface SliderType3 ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *_dataArr;
    __weak IBOutlet UITableView *_tableView;
    __weak IBOutlet UIView *topview;
    __weak IBOutlet UILabel *titlename;
    UIImageView *img;
}

@end

@implementation SliderType3
- (IBAction)pop:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
   _dataArr=[[NSMutableArray alloc] init];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    [_tableView registerNib:[UINib nibWithNibName:@"ListTCell" bundle:nil] forCellReuseIdentifier:@"CELLLIST"];
    img=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.width)];
    _tableView.tableHeaderView=img;
    [self getdata];
}
-(void)getdata
{
    [[HttpRequest shareRequestManager]getSliderSongsByUrl:[NSString stringWithFormat: SliderType3Url,self.code] returnData:^(id dic,NSError *eror){
        if (dic[@"list"]==[NSNull null]) {
            return ;
        }
        NSArray *arr=dic[@"list"][0][@"songList"];
        for (NSDictionary *subdic in arr) {
            SongModel *m=[[SongModel alloc] init];
            m.titlestr=subdic[@"title"];
            [m setValuesForKeysWithDictionary:subdic];
            [_dataArr addObject:m];
        }
        titlename.text=dic[@"name"];
        [img setImageWithURL:[NSURL URLWithString:dic[@"pic"]]];
        [_tableView reloadData];
        
    }];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArr.count;
   
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ListTCell *cell=[tableView dequeueReusableCellWithIdentifier:@"CELLLIST"];
    SongModel *m=_dataArr[indexPath.row];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.backgroundColor=[UIColor clearColor];
    cell.songLb.textColor=[UIColor blackColor];
    cell.songLb.text=m.titlestr;
    cell.author.text=m.author;
    
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MusicCenterController *center=[MusicCenterController CenterController];
    center.dataArr=_dataArr;
    center.curentIndex=indexPath.row;
    [center playsong];
    

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
