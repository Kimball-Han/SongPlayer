//
//  SqliteCenter.m
//  SongPlayer
//
//  Created by HAN on 15/5/24.
//  Copyright (c) 2015年 qianfeng01. All rights reserved.
//

#import "SqliteCenter.h"
#import <FMDatabase.h>
@implementation SqliteCenter
{
    FMDatabase* _dbManager;
}

+(SqliteCenter *)shareDataCenter
{
    static dispatch_once_t once;
    static SqliteCenter*manager=nil;
    dispatch_once(&once, ^{
        manager=[[SqliteCenter alloc] init];
    });
    return manager;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        NSString *path=[NSString stringWithFormat:@"%@/Documents/data.db",NSHomeDirectory()];
        _dbManager=[[FMDatabase alloc] initWithPath:path];
        BOOL ret=[_dbManager open];
        if (ret) {
            NSLog(@"数据库打开成功");
        }else{
            NSLog(@"数据库打开失败");
        }
        ret=[_dbManager executeUpdate:@"create table if not exists LocalSong(uid integer primary key autoincrement,name,author)"];
        if (ret) {
            NSLog(@"数据库创建本地歌曲表格成功");
        }else{
            NSLog(@"数据库创建本地歌曲表格失败");
        }
        ret=[_dbManager executeUpdate:@"create table if not exists FaSong(uid integer primary key autoincrement,name,author,songImg,songLink,songLrc)"];
        if (ret) {
            NSLog(@"数据库创建收藏表格成功");
        }else{
            NSLog(@"数据库创建收藏表格失败");
        }
    
    
    }
    return self;
}
-(void)ScanningTheLocalSongs
{
    NSFileManager *manager=[NSFileManager defaultManager];
    NSArray *array=[manager subpathsOfDirectoryAtPath:[NSString stringWithFormat:@"%@/Documents/MySong",NSHomeDirectory()] error:nil];
    for (NSString *str in array) {
        if([[str pathExtension]isEqualToString:@"mp3" ]){
            //NSString *str1=[str stringByDeletingPathExtension];
        
        }
    }
}
-(BOOL)addDownloadSong:(SongModel *)model
{
    if (![_dbManager open]) {
        return NO;
    }
    if ([self isTheSameDataFromLocalSong:model]) {
        return NO;
    }
    NSString *sql = @"insert into LocalSong(name,author) values(?,?)";
    BOOL ret=[_dbManager executeUpdate:sql,model.titlestr,model.author];
    if (ret) {
        NSLog(@"LocalSong成功插入一条数据");
    }
    [_dbManager close];
    return ret;
}
-(BOOL)addPlaySongModel:(playeSongMoel *)model
{
    if (![_dbManager open]) {
        return NO;
    }
    if ([self isTheSameDataLocalSong:model]) {
        return NO;
    }
    NSString *sql = @"insert into FaSong(name,author,songImg,songLink,songLrc) values(?,?,?,?,?)";
    BOOL ret=[_dbManager executeUpdate:sql,model.name,model.author,model.imgUrl,model.NetLinkUrl,model.lrclink];
    if (ret) {
        NSLog(@"FaSong成功插入一条数据");
    }
    [_dbManager close];
    return ret;
}
-(NSMutableArray*)readFaSongsFromSqlite
{
    if (![_dbManager open]) {
        return nil;
    }
    NSString *sql=@"select * from FaSong";
    FMResultSet *set=[_dbManager executeQuery:sql];
    NSMutableArray *arr=[[NSMutableArray alloc] init];
    while ([set next]) {
        playeSongMoel *m=[[playeSongMoel alloc] init];
        m.name=[set stringForColumn:@"name"];
        m.author=[set stringForColumn:@"author"];
        m.NetLinkUrl=[set stringForColumn:@"songLink"];
        m.imgUrl=[set stringForColumn:@"songImg"];
        m.lrclink=[set stringForColumn:@"songLrc"];
        [arr addObject:m];
    }
   
    return arr;
    }

-(NSMutableArray *)readLocalSongsFromSqlite
{if (![_dbManager open]) {
    return nil;
}
    NSString *sql=@"select * from LocalSong";
    FMResultSet *set=[_dbManager executeQuery:sql];
    NSMutableArray *arr=[[NSMutableArray alloc] init];
    while ([set next]) {
        SongModel *m=[[SongModel alloc] init];
        m.titlestr=[set stringForColumn:@"name"];
        m.author=[set stringForColumn:@"author"];
        m.isLocal=YES;
        [arr addObject:m];
    }
    return arr;
    
}

-(BOOL)isTheSameDataFromLocalSong:(SongModel *)m
{
    if (![_dbManager open]) {
        return NO;
    }
    NSString * sql = [NSString stringWithFormat:@"select * from LocalSong where name='%@' and author='%@'",m.titlestr,m.author];
    FMResultSet* setet= [_dbManager executeQuery:sql];
    if ([setet next]) {
        return YES;
    }else{
        return NO;
    }
    
}
-(BOOL)isTheSameDataLocalSong:(playeSongMoel *)m
{
    if (![_dbManager open]) {
        return NO;
    }
    NSString * sql = [NSString stringWithFormat:@"select * from FaSong where name='%@' and author='%@'",m.name,m.author];
    FMResultSet* setet= [_dbManager executeQuery:sql];
    if ([setet next]) {
        return YES;
    }else{
        return NO;
    }
    
}
@end
