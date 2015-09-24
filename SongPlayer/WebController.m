//
//  WebController.m
//  SongPlayer
//
//  Created by qianfeng01 on 15-4-27.
//  Copyright (c) 2015年 qianfeng01. All rights reserved.
//

#import "WebController.h"

@interface WebController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLb;
@property (weak, nonatomic) IBOutlet UIView *topview;
@property (weak, nonatomic) IBOutlet UIWebView *_web;

@end

@implementation WebController
- (IBAction)pop:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
   
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets=NO;
    NSURLRequest *request=[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:self.strUrl]];
    [__web loadRequest:request];
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
