//
//  AppDelegate.h
//  GCDTimerDemo
//
//  Created by 58 on 17/3/9.
//  Copyright © 2017年 yuanmenglong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

