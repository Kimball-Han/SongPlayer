//
//  BaseViewController.m
//  SongPlayer
//
//  Created by qianfeng01 on 15-4-18.
//  Copyright (c) 2015年 qianfeng01. All rights reserved.
//

#import "BaseViewController.h"


@interface BaseViewController ()

@end

@implementation BaseViewController
{
    MusicCenterController *center;
    UIImageView *view1;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=YES;
    view1=[[UIImageView alloc] initWithFrame:CGRectMake(12, self.view.bounds.size.height-58, 50, 50)];
    
    view1.userInteractionEnabled=YES;
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onclick)];
    [view1 addGestureRecognizer:tap];
    [self.view addSubview:view1];
    view1.image=[UIImage imageNamed:@"bg_listen-knowledge_nocover_bg"];
    
      center=[MusicCenterController CenterController];

}
-(void)onclick
{
   
    [self presentViewController:center animated:YES completion:^{
        
    }];
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
