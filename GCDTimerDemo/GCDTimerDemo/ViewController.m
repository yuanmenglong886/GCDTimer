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
    
       // 正常的使用GCD
       // 1. 创建队列
       dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
       // 2. 创建GCD timer
         dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
         //3. 设置timer 的首次执行时间，执行时间间隔，精确度
       dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 2.0*NSEC_PER_SEC, 0.1*NSEC_PER_SEC);
    
        // 4 设置timer执行的时间
       dispatch_source_set_event_handler(timer, ^{
           
       });
       //  5 激活timer
       dispatch_resume(timer);
       //  6  取消timer
       dispatch_source_cancel(timer);
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
