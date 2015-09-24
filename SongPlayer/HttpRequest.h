//
//  HttpRequest.h
//  SongPlayer
//
//  Created by qianfeng01 on 15-4-18.
//  Copyright (c) 2015年 qianfeng01. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpRequest : NSObject


typedef void(^suc)(id response,NSError *error);

+(HttpRequest *)shareRequestManager;
-(void)getWeatherInfoUrl:(NSString *)strUrl returnData:(suc) resopse;
-(void)getLikeRecommdUrl:(NSString *)strUrl returnData:(suc) resopse;
-(void)getFirstTopUrl:(NSString *)strUrl returnData:(suc) resopse;
-(void)getFirstModUrl:(NSString *)strUrl returnData:(suc) resopse;
-(void)getFirstBotUrl:(NSString *)strUrl returnData:(suc) resopse;

-(void)getSongListUrl:(NSString *)strUrl returnData:(suc) resopse;

-(void)getBangDanUrl:(NSString *)strUrl returnData:(suc) resopse;

-(void)getHotSongerUrl:(NSString *)strUrl returnData:(suc) resopse;

-(void)getSongerListUrl:(NSString *)strUrl returnData:(suc) resopse;


-(void)getArtistInfoUrl:(NSString *)strUrl returnData:(suc) resopse;
-(void)getArtistSongListUrl:(NSString *)strUrl returnData:(suc) resopse;

-(void)getSOngLinkInfoUrl:(NSString *)strUrl returnData:(suc) resopse;

-(void)downloadFileURL:(NSString*)aUrl savePath:(NSString*)aSavePath fileName:(NSString*)aFileName  succuss:(suc)suc;
-(void)getBangSongsUrl:(NSString *)strUrl returnData:(suc) resopse;
-(void)getListSongsongUrl:(NSString *)strUrl returnData:(suc) resopse;
//获得专辑歌曲列表
-(void)getAlubumSongsByurl:(NSString *)strUrl returnData:(suc) res;

//获取更多新碟
-(void)getMoreAlbumsByUrl:(NSString *)strUrl returnData:(suc) res;
-(void)getSliderSongsByUrl:(NSString *)strUrl returnData:(suc) res;
//搜索
-(void)searchWorksByUrl:(NSString *)strUlrl returnData:(suc) res;
//获取下载歌曲连接
-(void)GETSongDownloadLink:(NSString *)song_id sreturnData:(suc)res;
-(void)downloadSongURL:(NSString *)aUrl savePath:(NSString *)aSavePath fileName:(NSString *)aFileName returnData:(suc)res;
//MV
-(void)getMvFileUrl:(NSString *)strUrl returnData:(suc) res;

@end
