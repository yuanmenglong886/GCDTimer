//
//  GCDTimer.h
//  20170305Utills
//
//  Created by 58 on 17/3/8.
//  Copyright © 2017年 yuanmenglong. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *     基于 Dispatch  创建的定时器  屏弃了 气系统的NSTimer 本身所存在的问题
 *     在GCDTimer 作为一个对象的属性时,必须使用weak的属性， 在创建后，系统会自动持有它， 否则的话容易造成循环引用
 *     内存泄漏
 */

@interface GCDTimer : NSObject

/**
 *   定时器无效 ，删除定时器
 *  <#paraments statement#>
 *  <#returnvalue statements#>
 */
- (void)invalidate;
/**
 *   基于block 封装的定时器  API和系统类似
 *   interval  间隔执行的时间
 *   repeats   BOOL
 *   block    callback 回调
 *   无返回值
 */
+ (void)scheduledTimerWithTimeInterval:(NSTimeInterval) interval repeats:(BOOL )repeats block:(void(^)(GCDTimer *timer)) block;
/**
 *   基于block 封装的定时器  API和系统类似
 *   interval  间隔执行的时间
 *   queue   timer 在那个队列之行  为nil  默认在全局队列，主线程
 *   repeats   BOOL
 *   block    callback 回调
 *   无返回值
 */
+ (void)scheduledTimerWithTimeInterval:(NSTimeInterval) interval  queue:(dispatch_queue_t)queue repeats:(BOOL )repeats block:(void(^)(GCDTimer *timer)) block;

/**
 *   基于target action 封装的定时器  API和系统类似
 *   interval  间隔执行的时间
 *   repeats   BOOL
 *   target    对象
 *   action    对象对应的方法
 *   无返回值
 */
+ (GCDTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval) interval repeats:(BOOL )repeats Target:(id )target action:(SEL)action;
/**
 *   基于target action 封装的定时器  API和系统类似
 *   interval  间隔执行的时间
 *   queue    timer 在那个队列之行  为nil  默认在全局队列，主线程
 *   repeats   BOOL
 *   target    对象
 *   action    对象对应的方法
 *   无返回值
 */
+ (GCDTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval) interval  queue:(dispatch_queue_t)queue repeats:(BOOL )repeats Target:(id )target action:(SEL)action;

@end
