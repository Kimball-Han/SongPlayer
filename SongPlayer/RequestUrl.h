//
//  RequestUrl.h
//  SongPlayer
//
//  Created by qianfeng01 on 15-4-18.
//  Copyright (c) 2015年 qianfeng01. All rights reserved.
//

#ifndef SongPlayer_RequestUrl_h
#define SongPlayer_RequestUrl_h
#define WeatherUrl @"http://wanapi.damai.cn/weather.json?cityname=%@&source=10345&useCash=false"
#define guessYourlikeUrl @"http://tingapi.ting.baidu.com/v1/restserver/ting?method=baidu.ting.song.userRecSongList&from=ios&bduss=25lQzlrTm5adDZ-V0lVa2t6SExNTnZIOWU3dk1wSTZNb3J0WnFkb0R-S0habGRWQVFBQUFBJCQAAAAAAAAAAAEAAADdUwg-uq52dna35wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIfZL1WH2S9VU&version=5.5.0"
#define firstUpUrl @"http://tingapi.ting.baidu.com/v1/restserver/ting?method=baidu.ting.plaza.getFocusPic&format=json"
#define firstMobUrl @"http://tingapi.ting.baidu.com/v1/restserver/ting?method=baidu.ting.diy.getHotGeDanAndOfficial&num=6"
#define firstBotUrl @"http://tingapi.ting.baidu.com/v1/restserver/ting?method=baidu.ting.plaza.getRecommendAlbum&format=json&offset=0&limit=4&type=2"


#define SongListUrl @"http://tingapi.ting.baidu.com/v1/restserver/ting?method=baidu.ting.diy.gedan&page_no=%ld&page_size=30"

#define BangDanUrl @"http://tingapi.ting.baidu.com/v1/restserver/ting?method=baidu.ting.billboard.billCategory&format=json"
#define HotSongerUrl @"http://tingapi.ting.baidu.com/v1/restserver/ting?method=baidu.ting.artist.getList&format=json&order=1&limit=12&offset=0&area=0&sex=0&abc="
#define SongerListUrl @"http://tingapi.ting.baidu.com/v1/restserver/ting?method=baidu.ting.artist.getList&format=json&order=1&limit=50&offset=%ld&area=%@&sex=%@&abc=%@"

#define ArtistInfoUrl @"http://tingapi.ting.baidu.com/v1/restserver/ting?method=baidu.ting.artist.getinfo&format=json&tinguid=%@"
#define ArtistSongListUrl @"http://tingapi.ting.baidu.com/v1/restserver/ting?method=baidu.ting.artist.getSongList&format=json&tinguid=%@&artistid=(null)&limits=50&order=2&offset=%ld&version=5.2.1&from=ios&channel=appstore"
#define getSongLinkUrl @"http://tingapi.ting.baidu.com/v1/restserver/ting?method=baidu.ting.song.getInfos&ts=%@&songid=%@&nw=2&l2p=344.1&lpb=320000&ext=MP3&format=json&from=ios&usup=1&lebo=0&aac=0&ucf=4&vid=&res=1&e=%@&from=ios&channel=appstore"
#define e @"ICHuBtnuCWad2K9%2ByVphNeAny5QQPf30AVanMmswkxo%3D&version=5.5.0"

#define getBangSongsListUrl @"http://tingapi.ting.baidu.com/v1/restserver/ting?from=webapp_music&method=baidu.ting.billboard.billList&format=json&callback=&type=%ld&size=100&offset=0"
#define getListSongsUrl @"http://tingapi.ting.baidu.com/v1/restserver/ting?method=baidu.ting.diy.gedanInfo&from=ios&listid=%@"
//专辑歌曲
#define getAlblumSongsURL @"http://tingapi.ting.baidu.com/v1/restserver/ting?method=baidu.ting.album.getAlbumInfo&album_id=%@&format=json&from=ios&version=5.2.1&from=ios&channel=appstore"
//更多新碟
#define getMoreAlbumsUrl @"http://tingapi.ting.baidu.com/v1/restserver/ting?method=baidu.ting.plaza.getRecommendAlbum&format=json&offset=%ld&limit=50&type=2"
#define SliderType3Url @"http://tingapi.ting.baidu.com/v1/restserver/ting?method=baidu.ting.diy.getSongFromOfficalList&format=json&code=%@&ver=2"
//搜索
#define SEARCH_URL @"http://tingapi.ting.baidu.com/v1/restserver/ting?from=webapp_music&method=baidu.ting.search.catalogSug&format=json&callback=&query=%@&_=%@"

#define SONG_DOWNLOAD_URL @"http://tingapi.ting.baidu.com/v1/restserver/ting?from=webapp_music&method=baidu.ting.song.downWeb&format=json&callback=&songid=%@&bit=128&_t=%@"
#define MV_SONG_URL @"http://tingapi.ting.baidu.com/v1/restserver/ting?method=baidu.ting.mv.playMV&mv_id=&song_id=%@&definition=51"
#endif
