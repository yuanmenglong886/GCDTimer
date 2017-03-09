//
//  GCDTimer.m
//  20170305Utills
//
//  Created by 58 on 17/3/8.
//  Copyright © 2017年 yuanmenglong. All rights reserved.
//

#import "GCDTimer.h"

@interface GCDTimer ()
@property (nonatomic,strong)  dispatch_source_t timer;
@property (nonatomic,strong) dispatch_queue_t  queue;
@property (nonatomic,strong) dispatch_queue_t  runQueue;
@end
@implementation GCDTimer
#pragma mark  Private  method 
- (instancetype)init
{
      return [self initWithQueue:nil];
}
- (instancetype)initWithQueue:(dispatch_queue_t)queue
{
    if(self = [super init])
    {
        if(!queue)
        {
           queue = dispatch_get_main_queue();
        
        }
        self.queue = queue;
        dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
        self.timer = timer;
    }
    return self;
}
- (void)scheduledTimerWithTimeInterval:(NSTimeInterval) interval
{
      dispatch_source_set_timer(self.timer, dispatch_walltime(NULL, 0), interval *NSEC_PER_SEC, 0);
}
- (void)addTarget:(id )target  action:(SEL)action repeats:(BOOL)repeats
{
        typeof(target)weakTarget = target;
        __weak typeof(self)weakSelf =self;
       dispatch_source_set_event_handler(self.timer, ^{
            typeof(weakTarget)strongTarget = weakTarget;
            dispatch_async(self.queue, ^{
            
                     if([strongTarget respondsToSelector:action])
                      {
                         [target performSelector:action];
                         if(!repeats)
                         {
                           [weakSelf invalidate];
                         }
                      }else
                      {
                          [weakSelf invalidate];
                      }
               });

       });
}
/**
 *   启动一个timer 定时器
 *  <#paraments statement#>
 *  <#returnvalue statements#>
 */
- (void)startTimer
{
     dispatch_resume(self.timer);
}

#pragma mark   Public  interface

- (void)invalidate
{
    dispatch_source_cancel(self.timer);
}


+ (GCDTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval) interval repeats:(BOOL )repeats Target:(id )target action:(SEL)action
{
       return [GCDTimer scheduledTimerWithTimeInterval:interval queue:nil repeats:repeats Target:target action:action];
}
+ (GCDTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)interval queue:(dispatch_queue_t)queue repeats:(BOOL)repeats Target:(id)target action:(SEL)action
{
     GCDTimer *timer = [[GCDTimer alloc]initWithQueue:queue];
     [timer scheduledTimerWithTimeInterval:interval];

     [timer addTarget:target action:action repeats:repeats];
     [timer startTimer];
     return timer;
}
+ (void)scheduledTimerWithTimeInterval:(NSTimeInterval) interval repeats:(BOOL )repeats block:(void(^)(GCDTimer *timer)) block
{
       [GCDTimer scheduledTimerWithTimeInterval:interval queue:nil repeats:repeats block:block];
}
+ (void)scheduledTimerWithTimeInterval:(NSTimeInterval) interval queue:(dispatch_queue_t)queue repeats:(BOOL )repeats block:(void(^)(GCDTimer *timer)) block;
{
        GCDTimer *timer = [[GCDTimer alloc]initWithQueue:queue];
        [timer scheduledTimerWithTimeInterval:interval];

             typeof(timer)weakTimer = timer;
           dispatch_source_set_event_handler(timer.timer, ^{
           dispatch_async(timer.queue, ^{
                       typeof(weakTimer)strongTimer = weakTimer;
           
              if(block)
              {
                 block(strongTimer);
                  if(!repeats)
                  {
                      [strongTimer invalidate];
                  }
              }else
              {
                 [strongTimer invalidate];
              }
           });
    
       });
       [timer startTimer];
}



@end
