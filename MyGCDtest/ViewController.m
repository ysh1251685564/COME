//
//  ViewController.m
//  MyGCDtest
//
//  Created by 袁少华 on 15/8/10.
//  Copyright (c) 2015年 袁少华. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 哈哈哈哈哈哈哈
    ///束手待毙货架上的绝对是就好比很简单
    
    //Grand Central Dispatch,自动合理地利用更多的CPU内核（比如双核、四核），最重要的是它会自动管理线程的生命周期（创建线程、调度任务、销毁线程），完全不需要我们管理，我们只需要告诉干什么就行
    
    //主队列：这是一个特殊的 串行队列。什么是主队列，大家都知道吧，它用于刷新 UI，任何需要刷新 UI 的工作都要在主队列执行，所以一般耗时的任务都要放到别的线程执行。
    dispatch_queue_t main = dispatch_get_main_queue();
    
    //自己创建的队列：其中第一个参数是标识符，用于 DEBUG 的时候标识唯一的队列，可以为空。第二个参数用来表示创建的队列是串行的还是并行的，传入 DISPATCH_QUEUE_SERIAL 或 NULL 表示创建串行队列。传入 DISPATCH_QUEUE_CONCURRENT 表示创建并行队列。
    dispatch_queue_t queu = dispatch_queue_create("the", NULL);
    
    //全局并行队列：这应该是唯一一个并行队列，只要是并行任务一般都加入到这个队列。
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_queue_t q;
    //创建任务
    //同步任务,不会另开线程 (SYNC)    (一般都会出现锁死现象)
//    dispatch_sync( q, ^{
//        NSLog(@"%@", [NSThread currentThread]);
//    });
    //异步任务：会另开线程 (ASYNC)
//    dispatch_async(q, ^{
//        NSLog(@"%@", [NSThread currentThread]);
//    });
    
    //创建队列组
    dispatch_group_t group = dispatch_group_create();
    //创建队列
    dispatch_queue_t qu1 = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //3.多次使用队列组的方法执行任务, 只有异步方法
    //3.1.执行3次循环
    dispatch_group_async(group, qu1, ^{
        for (NSInteger i = 0; i < 3; i++) {
            NSLog(@"group-01 - %@", [NSThread currentThread]);
        }
    });
    
    //3.2.主队列执行8次循环
    dispatch_group_async(group, dispatch_get_main_queue(), ^{
        for (NSInteger i = 0; i < 8; i++) {
            NSLog(@"group-02 - %@", [NSThread currentThread]);
        }
    });
    //3.3.执行5次循环
    dispatch_group_async(group, queue, ^{
        for (NSInteger i = 0; i < 5; i++) {
            NSLog(@"group-03 - %@", [NSThread currentThread]);
        }
    });
    //4.都完成后会自动通知
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"完成 - %@", [NSThread currentThread]);
    });
    
    
    // 创建队列
    dispatch_queue_t qu2 = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    // 设置延时，单位秒
    double delay = 3;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), queue, ^{
        // 3秒后需要执行的任务
    });
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
