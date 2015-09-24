//
//  HttpRequest.m
//  SongPlayer
//
//  Created by qianfeng01 on 15-4-18.
//  Copyright (c) 2015年 qianfeng01. All rights reserved.
//

#import "HttpRequest.h"
#import <AFNetworking.h>
#import "SongModel.h"
#import "AlbumModel.h"
#import "ListModel.h"
#import "BangModel.h"
#import "ArtistModel.h"
#import "playeSongMoel.h"
#import "PlayerCenter.h"
#import "RequestUrl.h"
@implementation HttpRequest

{
    AFHTTPRequestOperationManager *_manager;
}

+(HttpRequest *)shareRequestManager;
{
    static dispatch_once_t onceToken;
    static HttpRequest *manager=nil;
    dispatch_once(&onceToken, ^{
        manager=[[HttpRequest alloc] init];
    });
    return manager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _manager=[AFHTTPRequestOperationManager manager];
        _manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    }
    return self;
}
-(void)getWeatherInfoUrl:(NSString *)strUrl returnData:(suc)resopse
{
    
    
    NSString *url=[strUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [_manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation,id response){
        
        
        NSDictionary *d=[NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableContainers error:nil];
        if (!d[@"data"]) {
            return ;
        }
        NSData *data=[d[@"data"] dataUsingEncoding:NSUTF8StringEncoding];
        
        NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        NSDictionary *returnData=dict[@"retData"];
        if (response) {
            resopse(returnData,nil);
        }
        
    }failure:^(AFHTTPRequestOperation *operation,NSError *error){
        
        
    }];
}
-(void)getLikeRecommdUrl:(NSString *)strUrl returnData:(suc)resopse
{
    NSString *url=[strUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [_manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation,id response){
        
        
        NSDictionary *d=[NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableContainers error:nil];
        NSMutableArray *dataArr=[[NSMutableArray alloc] init];
        NSDictionary *dic=d[@"result"];
        for (NSDictionary *subDic in dic[@"list"]) {
            SongModel *m=[[SongModel alloc] init];
            [m setValuesForKeysWithDictionary:subDic];
            m.titlestr=subDic[@"title"];
            [dataArr addObject:m];
        }
        if (response) {
            resopse(dataArr,nil);
        }
        
    }failure:^(AFHTTPRequestOperation *operation,NSError *error){
        
        
    }];
}
-(void)getFirstTopUrl:(NSString *)strUrl returnData:(suc)resopse
{
    [_manager GET:strUrl parameters:self success:^(AFHTTPRequestOperation *opreation,id response){
        NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableContainers error:nil];
        NSArray *arr=dic[@"pic"];
        if (resopse) {
            resopse(arr,nil);
        }

        
    }failure:^(AFHTTPRequestOperation *opreation,NSError *error){
        
    }];
    
}
-(void)getFirstModUrl:(NSString *)strUrl returnData:(suc)resopse
{
    [_manager GET:strUrl parameters:self success:^(AFHTTPRequestOperation *opreation,id response){
        NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableContainers error:nil];
        NSArray *arr=dic[@"content"][@"list"];
        if (resopse) {
            resopse(arr,nil);
        }
        

    }failure:^(AFHTTPRequestOperation *opreation,NSError *error){
        
    }];

}

-(void)getFirstBotUrl:(NSString *)strUrl returnData:(suc)resopse
{
    [_manager GET:strUrl parameters:self success:^(AFHTTPRequestOperation *opreation,id response){
        NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableContainers error:nil];
        NSArray *arr=dic[@"plaze_album_list"][@"RM"][@"album_list"][@"list"];
        NSMutableArray *dataArr=[[NSMutableArray alloc] init];
        for (NSDictionary *subdic in arr) {
            AlbumModel *m=[[AlbumModel alloc] init];
            [m setValuesForKeysWithDictionary:subdic];
            m.titlestr=subdic[@"title"];
            [dataArr addObject:m];
        }
        if (resopse) {
            resopse(dataArr,nil);
        }
        

    }failure:^(AFHTTPRequestOperation *opreation,NSError *error){
        
    }];

}
-(void)getSongListUrl:(NSString *)strUrl returnData:(suc)resopse
{
    [_manager GET:strUrl parameters:self success:^(AFHTTPRequestOperation *opreation,id response){
        NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableContainers error:nil];
        NSArray *arr=dic[@"content"];
        if (dic[@"content"]!=[NSNull null]) {
            NSMutableArray *dataArr=[NSMutableArray array];
            for (NSDictionary *subdic in arr) {
                ListModel *m=[[ListModel alloc] init];
                m.titlestr=subdic[@"title"];
                [m setValuesForKeysWithDictionary:subdic];
                [dataArr addObject:m];
            }
            if (resopse) {
                resopse(dataArr,nil);
            }
 
        }else{
            if (resopse) {
                resopse(nil,nil);
            }
            

        }
        
        
        
    }failure:^(AFHTTPRequestOperation *opreation,NSError *error){
        
    }];

}
-(void)getBangDanUrl:(NSString *)strUrl returnData:(suc)resopse
{
    [_manager GET:strUrl parameters:self success:^(AFHTTPRequestOperation *opreation,id response){
        NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableContainers error:nil];
        NSArray *arr=dic[@"content"];
        NSMutableArray *dataArr=[NSMutableArray array];
        for (NSDictionary *subdic in arr) {
            BangModel *m=[[BangModel alloc] init];
            
            [m setValuesForKeysWithDictionary:subdic];
            m.song1=subdic[@"content"][0][@"title"];
             m.song2=subdic[@"content"][1][@"title"];
             m.song3=subdic[@"content"][2][@"title"];
            m.song1au=subdic[@"content"][0][@"author"];
            m.song2au=subdic[@"content"][1][@"author"];
            m.song3au=subdic[@"content"][2][@"author"];
            [dataArr addObject:m];
        }
        if (resopse) {
            resopse(dataArr,nil);
        }
        
        
        
    }failure:^(AFHTTPRequestOperation *opreation,NSError *error){
        
    }];

}
-(void)getHotSongerUrl:(NSString *)strUrl returnData:(suc)resopse
{
    [_manager GET:strUrl parameters:self success:^(AFHTTPRequestOperation *opreation,id response){
      
        NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableContainers error:nil];
     
        NSArray *arr=dic[@"artist"];
        if (dic[@"artist"] !=[NSNull null]) {
            NSMutableArray *dataArr=[[NSMutableArray alloc] init];
            
            for (NSDictionary *subdic in arr) {
                ArtistModel *m=[[ArtistModel alloc] init];
                
                [m setValuesForKeysWithDictionary:subdic];
                [dataArr addObject:m];
            }
            
            if (resopse) {
                resopse(dataArr,nil);
            }

        }else{
        if (resopse) {
            resopse(nil,nil);
        }
        }

        
        
        
        
    }failure:^(AFHTTPRequestOperation *opreation,NSError *error){
        
    }];

}
-(void)getSongerListUrl:(NSString *)strUrl returnData:(suc)resopse
{
    NSString *url=[strUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [_manager GET:url parameters:self success:^(AFHTTPRequestOperation *opreation,id response){
        NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableContainers error:nil];
        NSArray *arr=dic[@"artist"];
        if (dic[@"artist"] !=[NSNull null]) {
        NSMutableArray *dataArr=[NSMutableArray array];
        for (NSDictionary *subdic in arr) {
            ArtistModel *m=[[ArtistModel alloc] init];
            
            [m setValuesForKeysWithDictionary:subdic];
            [dataArr addObject:m];
        }
        if (resopse) {
            resopse(dataArr,nil);
        }
        }else{
            if (resopse) {
                resopse(nil,nil);
            }
 
        }
    }failure:^(AFHTTPRequestOperation *opreation,NSError *error){
        
    }];


}
#pragma mark- 歌手歌曲信息和歌单
-(void)getArtistInfoUrl:(NSString *)strUrl returnData:(suc)resopse
{
    [_manager GET:strUrl parameters:self success:^(AFHTTPRequestOperation *opreation,id response){
        NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableContainers error:nil];
    
        ArtistModel *m=[[ArtistModel alloc] init];
        [m setValuesForKeysWithDictionary:dic];
     
        if (resopse) {
            resopse(m,nil);
        }
            
    }failure:^(AFHTTPRequestOperation *opreation,NSError *error){
        
    }];
    

}
-(void)getArtistSongListUrl:(NSString *)strUrl returnData:(suc)resopse
{
    [_manager GET:strUrl parameters:self success:^(AFHTTPRequestOperation *opreation,id response){
        NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableContainers error:nil];
        NSArray *arr=dic[@"songlist"];
        if (dic[@"songlist"] !=[NSNull null]) {
            NSMutableArray *dataArr=[NSMutableArray array];
            for (NSDictionary *subdic in arr) {
                SongModel *m=[[SongModel alloc] init];
                m.titlestr=subdic[@"title"];
                [m setValuesForKeysWithDictionary:subdic];
                [dataArr addObject:m];
            }
            if (resopse) {
                resopse(dataArr,nil);
            }
        }else{
            if (resopse) {
                resopse(nil,nil);
            }
            
        }
    }failure:^(AFHTTPRequestOperation *opreation,NSError *error){
        
    }];

}
//播放链接
-(void)getSOngLinkInfoUrl:(NSString *)strUrl returnData:(suc)resopse
{
    //NSLog(@"%@",strUrl);
    [_manager GET:strUrl parameters:self success:^(AFHTTPRequestOperation *opreation,id response){
        NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *subDic=dic[@"bitrate"];
        if (dic[@"bitrate"] !=[NSNull null]) {
           
            playeSongMoel *m=[[playeSongMoel alloc] init];
            m.islocal=NO;
            m.author=dic[@"songinfo"][@"author"];
            m.name=dic[@"songinfo"][@"title"];
            m.NetLinkUrl=subDic[@"file_link"];
            m.lrclink=dic[@"songinfo"][@"lrclink"];
            m.imgUrl=dic[@"songinfo"][@"pic_huge"];
            m.des=[NSString stringWithFormat:@"%@-%@ ",m.name,m.author];
            dispatch_queue_t main=dispatch_get_main_queue();
            dispatch_async(main, ^{
                  [PlayerCenter sharePlayerCenter].m=m;
            });
          
        }
        
    }failure:^(AFHTTPRequestOperation *opreation,NSError *error){
        
    }];

}
-(void)downloadFileURL:(NSString*)aUrl savePath:(NSString*)aSavePath fileName:(NSString*)aFileName  succuss:(suc)suc
{
    if (aUrl==nil) {
        return;
    }
    
    NSString *fileName=[NSString stringWithFormat:@"%@/%@.lrc",aSavePath,aFileName];
    
    if (!aUrl) {
        return;
    }
    NSURL *url = [[NSURL alloc] initWithString:aUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
   
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.inputStream   = [NSInputStream inputStreamWithURL:url];
    
    operation.outputStream  = [NSOutputStream outputStreamToFileAtPath:fileName append:NO];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //设置下载数据到res字典对象中并用代理返回下载数据NSData
        
        if (suc) {
            suc(@"yes",nil);
            NSLog(@"歌词下载成功");
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@",error);
        //下载失败
        
    }];
    [operation start];
}
-(void)getBangSongsUrl:(NSString *)strUrl returnData:(suc)resopse
{
    [_manager GET:strUrl parameters:self success:^(AFHTTPRequestOperation*opreation,id data){
        NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        if (resopse) {
            resopse(dic, nil);
        }
        
    }failure:^(AFHTTPRequestOperation*opreation,NSError *error){
        
    }];
}
-(void)getListSongsongUrl:(NSString *)strUrl returnData:(suc)resopse
{
    [_manager GET:strUrl parameters:self success:^(AFHTTPRequestOperation*opreation,id data){
        NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        if (resopse) {
            resopse(dic, nil);
        }
        
    }failure:^(AFHTTPRequestOperation*opreation,NSError *error){
        
    }];
}
#pragma mark -专辑歌曲列表请求
-(void)getAlubumSongsByurl:(NSString *)strUrl returnData:(suc)res
{
    [_manager GET:strUrl parameters:self success:^(AFHTTPRequestOperation*opreation,id data){
        NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        if (res) {
            res(dic, nil);
        }
        
    }failure:^(AFHTTPRequestOperation*opreation,NSError *error){
        
    }];

}
#pragma mark -获取更多新碟
-(void)getMoreAlbumsByUrl:(NSString *)strUrl returnData:(suc)res
{
    
    [_manager GET:strUrl parameters:self success:^(AFHTTPRequestOperation *opreation,id response){
        NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableContainers error:nil];
        NSArray *arr=dic[@"plaze_album_list"][@"RM"][@"album_list"][@"list"];
       
        NSMutableArray *dataArr=[[NSMutableArray alloc] init];
        for (NSDictionary *subdic in arr) {
            AlbumModel *m=[[AlbumModel alloc] init];
            [m setValuesForKeysWithDictionary:subdic];
            m.titlestr=subdic[@"title"];
            [dataArr addObject:m];
        }
        if (res) {
            res(dataArr,nil);
        }
        
        
    }failure:^(AFHTTPRequestOperation *opreation,NSError *error){
        
    }];

}
-(void)getSliderSongsByUrl:(NSString *)strUrl returnData:(suc)res
{
    [_manager GET:strUrl parameters:self success:^(AFHTTPRequestOperation *opreation,id response){
        NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableContainers error:nil];
       
        if (res) {
            res(dic,nil);
        }
        
        
    }failure:^(AFHTTPRequestOperation *opreation,NSError *error){
        
    }];

}
#pragma mark -搜索

-(void)searchWorksByUrl:(NSString *)strUlrl returnData:(suc)res
{
    //转码
    NSString *str=[strUlrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
   // 数据请求
    [_manager GET:str parameters:self success:^(AFHTTPRequestOperation *operation,id responseObject){
        //数据请求成功
        //数据处理
        NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        //存入字典
        NSMutableDictionary *modelDic=[[NSMutableDictionary alloc] init];
        NSMutableArray *songArray=[NSMutableArray array];
        NSMutableArray *artistArr=[NSMutableArray array];
        NSMutableArray *albumArr=[NSMutableArray array ];
        //歌曲列表
        if (dic[@"song"]!=[NSNull null]) {
            for (NSDictionary *songdic in dic[@"song"]) {
                SongModel *m=[[SongModel alloc] init];
                m.song_id=songdic[@"songid"];
                m.titlestr=songdic[@"songname"];
                m.has_mv=songdic[@"has_mv"];
                m.author=songdic[@"artistname"];
                [songArray addObject:m];
            }
            [modelDic setObject:songArray forKey:@"songs"];
        }
        //歌手列表
        if (dic[@"artist"]!=[NSNull null]) {
            for (NSDictionary *arDic in dic[@"artist"]) {
                ArtistModel *m=[[ArtistModel alloc] init];
                m.ting_uid=arDic[@"artistid"];
                m.avatar_s500=arDic[@"artistpic"];
                m.name=arDic[@"artistname"];
                [artistArr addObject:m];
            }
            [modelDic setObject:artistArr forKey:@"artist"];
        }
        //专辑列表
        if (dic[@"album"]!=[NSNull null]) {
            for (NSDictionary *aldic in dic[@"album"]) {
                AlbumModel *m=[[AlbumModel alloc] init];
                m.album_id=aldic[@"albumid"];
                m.titlestr=aldic[@"albumname"];
                m.pic_big=aldic[@"artistpic"];
                m.author=aldic[@"artistname"];
                [albumArr addObject:m];
            }
            [modelDic setObject:albumArr forKey:@"album"];
        }
        //数据返回
        if (res) {
           res(modelDic,nil);
        }
        //数据请求失败
    }failure:^(AFHTTPRequestOperation *opration ,NSError *error){
        
        NSLog(@"搜索数据失败");
    }];

}

//获取歌曲下载路径
-(void)GETSongDownloadLink:(NSString *)song_id sreturnData:(suc)res
{
    //时间戳
    NSDate *datenow = [NSDate date];
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
    //请求
    [_manager GET:[NSString stringWithFormat:SONG_DOWNLOAD_URL,song_id,timeSp] parameters:self success:^(AFHTTPRequestOperation *operation,id responseObject){
        //数据处理
        NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        //安全判断
        if(dic[@"bitrate"] == [NSNull null])
        {
            return ;
        }
        NSDictionary *subDic=dic[@"bitrate"][0];
        if (res) {
            //返回下载链接
            res(subDic[@"show_link"],nil);
        }
       //链接请求失败
    }failure:^(AFHTTPRequestOperation *operation ,NSError *error){
        
    }];
    
    
}
-(void)downloadSongURL:(NSString *)aUrl savePath:(NSString *)aSavePath fileName:(NSString *)aFileName returnData:(suc)res
{
   //文件存储路径
    NSString *fileName=[NSString stringWithFormat:@"%@/%@.mp3",aSavePath,aFileName];
    //请求URL
    NSURL *url = [[NSURL alloc] initWithString:aUrl];
    //请求
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.inputStream   = [NSInputStream inputStreamWithURL:url];
    operation.outputStream  = [NSOutputStream outputStreamToFileAtPath:fileName append:NO];
    //
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (res) {
            res(@"YES",nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"歌曲下载失败");
        //下载失败
    }];
    //下载进度回调
    [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead){
        float progress = ((float)totalBytesRead/(totalBytesExpectedToRead));
        //下载进度
        if (res) {
            res([NSString stringWithFormat:@"%f",progress],nil);
        }
    }];
    //开始下载
    [operation start];
}
//获取MV的链接
-(void)getMvFileUrl:(NSString *)strUrl returnData:(suc) res
{
    //数据请求
    [_manager GET:strUrl parameters:self success:^(AFHTTPRequestOperation *operation ,id jectdata){
        NSDictionary *dict= [NSJSONSerialization JSONObjectWithData:jectdata options:NSJSONReadingMutableContainers error:nil];
        //数据判断
        if ([dict[@"result"] isKindOfClass:[NSString class]]) {
            return ;
        }
        //解析链接
        NSString *str=dict[@"result"][@"files"][@"31"][@"file_link"];
        if (res) {
            res(str,nil);
        }
        //请求失败
    }failure:^(AFHTTPRequestOperation *opreration ,NSError *error){
        
    }];
}


@end
