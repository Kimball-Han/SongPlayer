//
//  ArtistViewController.m
//  SongPlayer
//
//  Created by qianfeng01 on 15-4-20.
//  Copyright (c) 2015年 qianfeng01. All rights reserved.
//

#import "ArtistViewController.h"
#import "ArtistModel.h"
#import "RequestUrl.h"
#import <UIImageView+AFNetworking.h>
#import "HttpRequest.h"
#import <MJRefresh.h>
#import "SongerCell.h"
#import "ABCView.h"
#import "ArtistSongsController.h"
@interface ArtistViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    
    __weak IBOutlet UITableView *_tabeview;
    NSMutableArray *_dataArr;
    ABCView *_abc;
}

@end

@implementation ArtistViewController
- (IBAction)popbu:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)morecate:(id)sender {
    [UIView animateWithDuration:0.5 animations:^{
        _abc.frame=CGRectMake(0, Screen_Height-360, Screen_Width, 360);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _tabeview.delegate=self;
    _tabeview.dataSource=self;
    self.namelb.text=self.name;
    _abc=[[ABCView alloc] initWithFrame:CGRectMake(0, Screen_Height, Screen_Width, 0)];
    [self.view addSubview:_abc];
    __weak ArtistViewController *weakSelf=self;
    __weak ABCView *weakAbc=_abc;
    _abc.back=^(NSString *str){
        if (str!=nil) {
           weakSelf.cate=str;
            weakSelf.offset=0;
            [weakSelf addrefresh];
        }
        [UIView animateWithDuration:0.5 animations:^{
            weakAbc.frame=CGRectMake(0, Screen_Height,Screen_Width, 0);
            
        }];

    };
      _dataArr=[[NSMutableArray alloc] init];
    [_tabeview registerNib:[UINib nibWithNibName:@"SongerCell" bundle:nil] forCellReuseIdentifier:@"SOCELL"];
    [self addrefresh];
   
}
-(void)addrefresh
{
    dispatch_queue_t main=dispatch_get_main_queue();
    
    [_tabeview addLegendHeaderWithRefreshingBlock:^{
        self.offset=0;
        dispatch_async(main, ^{
            [self getData];
        });
    }];
    [_tabeview.header beginRefreshing];
    [_tabeview addLegendFooterWithRefreshingBlock:^{
        self.offset+=50;
        dispatch_async(main, ^{
            [self getData];
        });
       
    }];
}
-(void)getData
{
   // NSLog(@"%@",self.cate);
    [[HttpRequest shareRequestManager] getSongerListUrl:[NSString stringWithFormat:SongerListUrl,(long)_offset,_area,_sex,_cate] returnData:^(id data,NSError *error){
        if (self.offset==0) {
            [_dataArr removeAllObjects];
            if (data!=[NSNull null]) {
                [_dataArr addObjectsFromArray:data];
            }
            
           
            [_tabeview.header endRefreshing];
        }else{
            if (data!=[NSNull null]) {
                [_dataArr addObjectsFromArray:data];
            }

            [_tabeview.footer endRefreshing];
        }
        [_tabeview reloadData];
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
    SongerCell *cell=[tableView dequeueReusableCellWithIdentifier:@"SOCELL"];
    ArtistModel *m=_dataArr[indexPath.row];
    [cell.img setImageWithURL:[NSURL URLWithString:m.avatar_big]];
    cell.nameLb.text=m.name;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ArtistModel *m=_dataArr[indexPath.row];
    ArtistSongsController *songLists=[[ArtistSongsController alloc] init];
    songLists.ting_uid=m.ting_uid;
    [self.navigationController pushViewController:songLists animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
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
