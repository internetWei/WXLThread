//
//  WXLThread.m
//  UndeadThread
//
//  Created by LL on 2024/5/29.
//

#import "WXLThread.h"

@interface WXLRealizeThread : NSThread @end

@implementation WXLRealizeThread @end


@interface WXLThread ()

@property (nonatomic, assign, getter=isStopped) BOOL stopped;

@property (nonatomic, unsafe_unretained) WXLRealizeThread *thread;

@end

@implementation WXLThread

- (instancetype)init {
    if (self = [super init]) {
        [self p_initialize];
    }
    
    return self;
}


- (void)p_initialize {
    __weak typeof(self) weakSelf = self;
    
    WXLRealizeThread *thread = [[WXLRealizeThread alloc] initWithBlock:^{
        NSRunLoop *loop = [NSRunLoop currentRunLoop];
        [loop addPort:[NSPort port] forMode:NSDefaultRunLoopMode];
        
        while (weakSelf && !weakSelf.isStopped) {
            [loop runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        }
    }];
    
    self.thread = thread;
    
    [thread start];
}


- (void)runTask:(void(^)(void))block {
    if (!block) return;
    [self performSelector:@selector(p_runTask:) onThread:self.thread withObject:block waitUntilDone:NO];
}


- (void)p_runTask:(void(^)(void))block {
    !block ?: block();
}


- (void)p_stop {
    CFRunLoopStop(CFRunLoopGetCurrent());
}

- (void)dealloc {
    _stopped = YES;
    [self performSelector:@selector(p_stop) onThread:self.thread withObject:nil waitUntilDone:YES];
}

@end
