//
//  MusicViewController.m
//  SongPlayer
//
//  Created by qianfeng01 on 15-4-18.
//  Copyright (c) 2015年 qianfeng01. All rights reserved.
//

#import "MusicViewController.h"
#import "InitView.h"
#import "ListView.h"
#import "BangdanView.h"
#import "SongersView.h"
#import "MessageCenter.h"
#import "ArtistViewController.h"
#import "ArtistSongsController.h"
#import "BangViewController.h"
#import "ListSongsController.h"
#import "ViewController.h"
#import "AlbumSongsController.h"
#import "SliderType3.h"
#import "WebController.h"

@interface MusicViewController ()<UIScrollViewDelegate>
{
    
    __weak IBOutlet UIView *line;
    __weak IBOutlet UIButton *first;
    __weak IBOutlet UIButton *songlist;
    __weak IBOutlet UIButton *bangdan;
    __weak IBOutlet UIButton *songer;
    __weak IBOutlet UIScrollView *rootScrollView;
}

@end

@implementation MusicViewController
- (IBAction)pop:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (IBAction)buttons:(id)sender {
    UIButton *button=(UIButton *)sender;
    [UIView animateWithDuration:0.5 animations:^(){
         [rootScrollView setContentOffset:CGPointMake(Screen_Width*(button.tag-10), 0)];
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    rootScrollView.delegate=self;
    rootScrollView.contentSize=CGSizeMake(Screen_Width*4, Screen_Height-100);
    rootScrollView.showsHorizontalScrollIndicator=NO;
    rootScrollView.showsVerticalScrollIndicator=NO;
    [self message];
    [self customUI];
    
}
-(void)message
{
    MessageCenter *center=[MessageCenter MessageManager];
    __weak MusicViewController * weakself=self;
    center.toPushArtistView=^(id data){
        ArtistViewController *arvc=[[ArtistViewController alloc] init];
        arvc.name=data[@"name"];
        arvc.area=data[@"area"];
        arvc.sex=data[@"sex"];
        arvc.cate=@"热门";
        arvc.offset=0;
        [weakself.navigationController pushViewController:arvc animated:YES];
    };
    center.toPushArtistSongView=^(id ting_id){
        ArtistSongsController *svc=[[ArtistSongsController alloc] init];
        svc.ting_uid=ting_id;
        [weakself.navigationController pushViewController:svc animated:YES ];
    };
    center.ToPushBangView=^(id type){
        BangViewController *bangView=[[BangViewController alloc] init];
        bangView.type=type;
        [weakself.navigationController pushViewController:bangView animated:YES ];
    };
    center.toPushLISTSONGView=^(id listid){
        ListSongsController *list=[[ListSongsController alloc] init];
        list.list=listid;
        [weakself.navigationController pushViewController:list animated:YES];
    };
    center.topushListSongView2=^(id listid){
        ListSongsController *list=[[ListSongsController alloc] init];
        list.list=listid;
        [weakself.navigationController pushViewController:list animated:YES];
    };
    center.toPushAlbumsView=^(id alb){
        AlbumSongsController *vc=[[AlbumSongsController alloc] init];
        [weakself.navigationController pushViewController:vc animated:YES];
    };
    center.toPushAlbumSongsview2=^(id alid){
        ViewController *vie=[[ViewController alloc] init];
        vie.ablum_id=alid;
        [weakself.navigationController pushViewController:vie animated:YES ];
    };
    center.sliderInfo=^(id dic){
        switch ([dic[@"type"] integerValue]) {
            case 7:
            {
                ListSongsController *list=[[ListSongsController alloc] init];
                list.list=dic[@"code"];
                [weakself.navigationController pushViewController:list animated:YES];
            }
                break;
            case 6:
            {
                WebController *wvc=[[WebController alloc] init];
                wvc.strUrl=dic[@"code"];

                [self.navigationController pushViewController:wvc animated:YES];
            }
                break;
            case 3:
            {
                SliderType3 *slide=[[SliderType3 alloc] init];
                slide.code=dic[@"code"];
                [self.navigationController pushViewController:slide animated:YES];
            }
                break;
            case 2:
            {
                ViewController *vie=[[ViewController alloc] init];
                vie.ablum_id=dic[@"code"];
                [weakself.navigationController pushViewController:vie animated:YES ];

            }
                break;
                
            default:
                break;
        }
    };
    
    
}
//音乐库的UI排版
-(void)customUI
{
    //scrollView的初始偏移量
    rootScrollView.contentOffset=CGPointMake(0, 0);
    //主页
    InitView *view1=[[InitView alloc] initWithFrame:CGRectMake(Screen_Width*0, 0, Screen_Width, Screen_Height-100) ];
    view1.backgroundColor=[UIColor whiteColor];
    [rootScrollView addSubview:view1];
    //歌单
    ListView *view2=[[ListView alloc] initWithFrame:CGRectMake(Screen_Width*1, 0, Screen_Width, Screen_Height-100)];
    view2.backgroundColor=[UIColor whiteColor];
    [rootScrollView addSubview:view2];
    //榜单
    BangdanView *view3=[[BangdanView alloc] initWithFrame:CGRectMake(Screen_Width*2, 0, Screen_Width, Screen_Height-100)];
    view3.backgroundColor=[UIColor whiteColor];
    [rootScrollView addSubview:view3];
    //歌手
    SongersView *view4=[[SongersView alloc] initWithFrame:CGRectMake(Screen_Width*3, 0, Screen_Width, Screen_Height-100)];
    [rootScrollView addSubview:view4];
    
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
      self.automaticallyAdjustsScrollViewInsets=NO;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    line.frame=CGRectMake(16+scrollView.contentOffset.x/4.0, line.frame.origin.y, line.frame.size.width, line.frame.size.height);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

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
