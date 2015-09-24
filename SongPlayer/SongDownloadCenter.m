//
//  SongDownloadCenter.m
//  SongPlayer
//
//  Created by HAN on 15/5/23.
//  Copyright (c) 2015年 qianfeng01. All rights reserved.
//

#import "SongDownloadCenter.h"
#import "RequestUrl.h"
#import "HttpRequest.h"
@implementation SongDownloadCenter
-(void)setM:(SongModel *)m
{
    _m=m;
    [NSThread detachNewThreadSelector:@selector(downloadSongByUrl) toTarget:self withObject:nil];
}
-(void)downloadSongByUrl
{
    [[HttpRequest shareRequestManager] GETSongDownloadLink:_m.song_id sreturnData:^(NSString *str1,NSError *error){
        if (str1==nil) {
            NSLog(@"歌曲下载链接出错..");
            return;
        }
            NSString *str=@"/Documents/MySong";
            //拼路径
            NSString * path = [NSHomeDirectory() stringByAppendingString:str];
            NSFileManager * manager = [NSFileManager defaultManager];
            //创建文件夹
            if(![manager fileExistsAtPath:path]) {
                
                [manager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
            }
        
        [[HttpRequest shareRequestManager] downloadSongURL:str1 savePath:path fileName:_m.titlestr returnData:^(NSString *pro,NSError *error){
            self.progress=pro;
        }];
    }];

}
-(void)setProgress:(NSString *)progress
{
    _progress=progress;
    if (self.prob) {
        self.prob(progress);
    }
}
@end
