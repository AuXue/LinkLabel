//
//  ViewController.m
//  AuXue_LinkLabel
//
//  Created by yangqijia on 2017/10/23.
//  Copyright © 2017年 AuXue. All rights reserved.
//

#import "ViewController.h"
#import "WYWebController.h"
#import "LinkLabel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    LinkLabel *titleLabel = [[LinkLabel alloc]initWithFrame: CGRectMake(0, 100, CGRectGetWidth(self.view.frame), 40)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.title = @"这只是一个标题";
    [self.view addSubview:titleLabel];

    LinkLabel *linkLabel = [[LinkLabel alloc]initWithFrame:CGRectMake(0, 200, CGRectGetWidth(self.view.frame), 40)];
    linkLabel.textAlignment = NSTextAlignmentCenter;
    [linkLabel setUrlWithTitle:@"百度一下" url:@"https://www.baidu.com"];
    linkLabel.linkBlack = ^(TextType type, NSString *text, NSURL *url) {
        if (type == LINK_TYPE){
            WYWebController *webVC = [[WYWebController alloc]init];
            webVC.url = [NSString stringWithFormat:@"%@",url];
            [self.navigationController pushViewController:webVC animated:YES];
        }
    };
    [self.view addSubview:linkLabel];
    
    LinkLabel *telLabel = [[LinkLabel alloc]initWithFrame:CGRectMake(0, 300, CGRectGetWidth(self.view.frame), 40)];
    telLabel.textAlignment = NSTextAlignmentCenter;
    telLabel.title = @"18612341234";
    telLabel.linkBlack = ^(TextType type, NSString *text, NSURL *url) {
        if (type == TEL_TYPE) {
            NSLog(@"手机号：%@",text);
            //调用系统方法拨号
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                if (@available(iOS 10.0, *)) {
                    [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
                } else {
                    [[UIApplication sharedApplication] openURL:url];
                }
            });
        }
    };
    [self.view addSubview:telLabel];
    
    LinkLabel *emailLabel = [[LinkLabel alloc]initWithFrame: CGRectMake(0, 400, CGRectGetWidth(self.view.frame), 40)];
    emailLabel.textAlignment = NSTextAlignmentCenter;
    emailLabel.title = @"18612341234@qq.com";
    emailLabel.linkBlack = ^(TextType type, NSString *text, NSURL *url) {
        if (type == EMAIL_TYPE) {
            NSLog(@"手机号：%@",text);
            //调用系统方法拨号
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                if (@available(iOS 10.0, *)) {
                    [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
                } else {
                    [[UIApplication sharedApplication] openURL:url];
                }
            });
        }
    };
    [self.view addSubview:emailLabel];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
