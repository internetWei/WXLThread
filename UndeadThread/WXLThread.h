//
//  WXLThread.h
//  UndeadThread
//
//  Created by LL on 2024/5/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WXLThread : NSObject

- (void)runTask:(void(^)(void))block;

@end

NS_ASSUME_NONNULL_END
