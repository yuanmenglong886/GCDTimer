//
//  ViewController.m
//  GCDTimerDemo
//
//  Created by 58 on 17/3/9.
//  Copyright © 2017年 yuanmenglong. All rights reserved.
//

#import "ViewController.h"
#import "GCDTimer.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     __block  int  yuanmenglong = 0;
     [GCDTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(GCDTimer *timer) {
          NSLog(@"yuanmenglongTimer:%d",yuanmenglong++);
     }];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
