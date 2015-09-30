//
//  MusicCenterController.m
//  SongPlayer
//
//  Created by qianfeng01 on 15-4-21.
//  Copyright (c) 2015年 qianfeng01. All rights reserved.
//

#import "MusicCenterController.h"
#import "SongModel.h"
#import "RequestUrl.h"
#import "HttpRequest.h"
#import "SongLrcView.h"
#import "SongImageView.h"
#import <UIImageView+AFNetworking.h>
#import "ListTCell.h"
#import "UMSocial.h"
#import "PlayerCenter.h"
#import <MediaPlayer/MediaPlayer.h>
#import "LocalViewController.h"
#import "FavoriteViewController.h"
#import "MySongListViewController.h"
#import "SongDownloadCenter.h"
#import "SqliteCenter.h"
#import "SongClass.h"
@interface MusicCenterController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate>
{
    
    __weak IBOutlet UIImageView *bgImage;
    __weak IBOutlet UIScrollView *rootScrollView;
    __weak IBOutlet UIPageControl *page;
    __weak IBOutlet UILabel *rightTimeLb;
    __weak IBOutlet UILabel *_leftTimelb;
    __weak IBOutlet UISlider *slider;
    __weak IBOutlet UIButton *playbutton;
    SongLrcView *_lrcView;
    UITableView *_listView;
    SongImageView *_imageview;
    NSThread *playerThread;
    NSInteger cha;
    
}

@end

@implementation MusicCenterController


//分享
- (IBAction)sharetoweibo:(id)sender {
    //分享实现
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"55555d7467e58e80b9000d96"
                                      shareText:[NSString stringWithFormat:@"%@   %@",[PlayerCenter sharePlayerCenter].m.des,[PlayerCenter sharePlayerCenter].m.NetLinkUrl]
                                     shareImage:[UIImage imageNamed:@"35.jpg"]
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToRenren,UMShareToWechatTimeline,nil]
                                       delegate:(id)self];
    
   //分享附加图片
    [[UMSocialData defaultData].urlResource setResourceType:UMSocialUrlResourceTypeImage url:[PlayerCenter sharePlayerCenter].m.imgUrl];
}
//实现回调方法（可选）：
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的微博平台名
        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
    }
}
- (IBAction)dismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
+(MusicCenterController *)CenterController
{
    static dispatch_once_t onceToken;
    static MusicCenterController *MCC=nil;
    dispatch_once(&onceToken, ^{
        MCC=[[MusicCenterController alloc] init];
        
    });
    return MCC;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
       cha=0;
        [PlayerCenter sharePlayerCenter].refrshMusicVC=^(int percentage, NSString *elapsedTime,NSString *timeRemaining,BOOL finished){
            if (percentage>=99) {
                NSLog(@"下一首%ld",cha);
                if (cha==0) {
                    self.curentIndex++;
                    [self nextsong];
                    cha=1;
                }
            }else{
                cha=0;
                _leftTimelb.text=elapsedTime;
                rightTimeLb.text=timeRemaining;
                slider.value=percentage;
            }
        };
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
     [self customUI];
     [self downAndfa];
    
   
}
-(void)customUI
{
    _listView=[[UITableView alloc] initWithFrame:CGRectMake(Screen_Width*0, 0, Screen_Width, Screen_Height-171)];
    _listView.separatorStyle=UITableViewCellSeparatorStyleNone;
     [_listView registerNib:[UINib nibWithNibName:@"ListTCell" bundle:nil] forCellReuseIdentifier:@"CELLLIST"];
    _listView.backgroundColor=[UIColor clearColor];
    _listView.delegate=self;
    _listView.dataSource=self;
     [_listView reloadData];
   _imageview=[[SongImageView alloc] initWithFrame:CGRectMake(Screen_Width*1, 0, Screen_Width, Screen_Height-171)];
    [_imageview loadimage];
    _lrcView=[[SongLrcView alloc] initWithFrame:CGRectMake(Screen_Width*2, 0, Screen_Width, Screen_Height-171)];
    [_lrcView getdata];
    [rootScrollView addSubview:_listView];
    [rootScrollView addSubview:_imageview];
    [rootScrollView addSubview:_lrcView];
    rootScrollView.showsHorizontalScrollIndicator=NO;
    rootScrollView.contentSize=CGSizeMake(Screen_Width*3, Screen_Height-171);
    rootScrollView.pagingEnabled=YES;
    rootScrollView.delegate=self;
   [slider setThumbImage:[UIImage imageNamed:@"sliderThumb_small.png"] forState:UIControlStateNormal];
  [slider setThumbImage:[UIImage imageNamed:@"sliderThumb_small.png"] forState:UIControlStateHighlighted];
    [playbutton setImage:[UIImage imageNamed:@"bt_playpagen_control_pause_button_normal@3x"] forState:UIControlStateSelected];
    [playbutton setImage:[UIImage imageNamed:@"bt_playpagen_control_play_button_normal@3x"] forState:UIControlStateNormal];
    [playbutton setImage:[UIImage imageNamed:@"bt_playpagen_control_play_button_press@3x"] forState:UIControlStateHighlighted];
    slider.continuous=NO;
    [slider addTarget:self action:@selector(sshuaxin) forControlEvents:UIControlEventValueChanged];
    
}
-(void)downAndfa
{
    __weak MusicCenterController *weakself=self;
    _imageview.buttonClick=^(UIButton *sender){
        [weakself more:sender];
    };
    
}


-(void)setDataArr:(NSArray *)dataArr
{
    _dataArr=dataArr;
    [_listView reloadData];
}
- (IBAction)nextstem:(id)sender {
     _curentIndex++;
    [self nextsong];
}
- (IBAction)playAndpause:(id)sender {
    UIButton *button=(UIButton *)sender;
    button.selected=!button.selected;
    
    if (button.selected) {
        [[PlayerCenter sharePlayerCenter] play];
      [button setImage:[UIImage imageNamed:@"bt_playpagen_control_pause_button_press@3x"] forState:UIControlStateHighlighted];
    }else{
         [[PlayerCenter sharePlayerCenter] pause];
      [button setImage:[UIImage imageNamed:@"bt_playpagen_control_play_button_press@3x"] forState:UIControlStateHighlighted];
    }
}
- (IBAction)shangyishou:(id)sender {
    if (_curentIndex==0) {
        _curentIndex=_dataArr.count-(_dataArr.count!=0);
    }else{
     _curentIndex--;
    }
    [self nextsong];
}
- (IBAction)bofangmoshi:(id)sender {
    
}
- (IBAction)tiaozhiqi:(id)sender {
    
}
-(void)more:(UIButton *)sender;
{
    switch (sender.tag) {
        //下载
        case 10:
        {
            [self downloadsong];
        }
            break;
       //mv
        case 11:
        {
            [self playMv];
        }
            break;
        //
        case 12:
        {
            if (![PlayerCenter sharePlayerCenter].m.islocal) {
                [[SqliteCenter shareDataCenter] addPlaySongModel:[PlayerCenter sharePlayerCenter].m];
            }
            
        }
            break;
        default:
            break;
    }
}
-(void)downloadsong
{
    SongModel *model=_dataArr[_curentIndex];
    SongDownloadCenter *songM=[[SongDownloadCenter alloc] init];
    songM.m=model;
    LocalViewController *center=[LocalViewController DownloadCenter];
    [center.dataArr addObject:songM];
    if (!model.isLocal) {
         UIActionSheet *acs=[[UIActionSheet alloc] initWithTitle:@"已加入下载列表" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"查看下载列表" otherButtonTitles: nil];
    [acs showInView:self.view];
    }
   
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {
        LocalViewController *center=[LocalViewController DownloadCenter];
        center.isPresent=YES;
        [self presentViewController:center animated:YES completion:^{
            
        }];
    }
   

}
//播放MV
-(void)playMv
{
    SongModel *model=_dataArr[_curentIndex];
    //链接请求
    [[HttpRequest shareRequestManager] getMvFileUrl:[NSString stringWithFormat:MV_SONG_URL,model.song_id] returnData:^(NSString *str,NSError *error){
        //MV链接获取成功播放；视频
        if(str){
            [[PlayerCenter sharePlayerCenter] pause];
        NSURL *url = [NSURL URLWithString:str];
        //这里应该是MPMoviePlayerViewController,而不是MPMoviePlayerController
        MPMoviePlayerViewController *playerController = [[MPMoviePlayerViewController alloc]init];
            //横屏
        playerController.view.transform=CGAffineTransformMakeRotation( M_PI * 90.0 / 180.0);
         playerController.moviePlayer.movieSourceType = MPMovieSourceTypeStreaming;
            [playerController.moviePlayer setContentURL:url];
            playerController.moviePlayer.allowsAirPlay=YES;
            [playerController.moviePlayer prepareToPlay];
           [playerController.moviePlayer.view setFrame:CGRectMake(0, 0, 320, 480)];
            //进入播放界面
            [self presentViewController:playerController animated:YES completion:nil];
        //在通知中心注册视频播放结束时的事件处理函数
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(onPlayFinished) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
        }
    }];
}

- (void)onPlayFinished
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    [[PlayerCenter sharePlayerCenter] play];
}


- (void)sshuaxin{
  int sencd=  ([[_leftTimelb.text substringToIndex:2] integerValue]*60+[[_leftTimelb.text substringFromIndex:3] integerValue]+[[rightTimeLb.text substringToIndex:2] integerValue]*60+[[rightTimeLb.text substringFromIndex:3] integerValue])*((float)slider.value/100.0);
    [[PlayerCenter sharePlayerCenter] moveToSecond:sencd];
}

-(void)nextsong
{
   
    if (_curentIndex>=_dataArr.count) {
        _curentIndex=0;
    }
    [self playsong];
}

-(void)playsong
{
    playbutton.selected=YES;
    if ([_dataArr[_curentIndex] isKindOfClass:[playeSongMoel class]]) {
        [PlayerCenter sharePlayerCenter].m=_dataArr[_curentIndex];
    }else{
    SongModel *m=_dataArr[_curentIndex];
    if (m.isLocal) {
        playeSongMoel *model=[[playeSongMoel alloc] init];
        model.name=m.titlestr;
        model.author=m.author;
        model.islocal=YES;
        [PlayerCenter sharePlayerCenter].m=model;
    }else{
         [playerThread cancel];
    playerThread=[[NSThread alloc] initWithTarget:self selector:@selector(getlinkUrlAndPlayer:) object:m.song_id];
    [playerThread start];
    }
    }
   
}


-(void)getlinkUrlAndPlayer:(NSString *)songid
{
        [[HttpRequest shareRequestManager] getSOngLinkInfoUrl:[NSString stringWithFormat:getSongLinkUrl,songid] returnData:^(id response,NSError *error){
        }];
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    page.currentPage=scrollView.contentOffset.x/scrollView.bounds.size.width;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
    if ([_dataArr[_curentIndex] isKindOfClass:[SongModel class]]) {
         SongModel *m=_dataArr[indexPath.row];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.backgroundColor=[UIColor clearColor];
    cell.songLb.textColor=[UIColor whiteColor];
    cell.songLb.text=m.titlestr;
    cell.author.text=m.author;
    }else{
        playeSongMoel *m=_dataArr[indexPath.row];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor clearColor];
        cell.songLb.textColor=[UIColor whiteColor];
        cell.songLb.text=m.name;
        cell.author.text=m.author;
    }
       return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _curentIndex=indexPath.row;
    [self playsong];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;

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
