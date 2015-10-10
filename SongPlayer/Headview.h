//
//  Headview.h
//  SongPlayer
//
//  Created by qianfeng01 on 15-4-18.
//  Copyright (c) 2015年 qianfeng01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
@interface Headview : UIView<UITextFieldDelegate,CLLocationManagerDelegate>
-(void)startloaction;
@property(nonatomic,strong)CLLocationManager *locationManager;

@end
