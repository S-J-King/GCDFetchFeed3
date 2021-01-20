//
//  SMDB.h
//  GCDFetchFeed
//
//  Created by DaiMing on 16/2/23.
//  Copyright © 2016年 Starming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB/FMDB.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <ReactiveCocoa/RACEXTScope.h>
#import "SMFeedModel.h"

#define PATH_OF_APP_HOME    NSHomeDirectory()
#define PATH_OF_TEMP        NSTemporaryDirectory()
#define PATH_OF_DOCUMENT    [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]


@interface SMDB : NSObject
+ (SMDB *)shareInstance;
- (RACSignal *)insertWithFeedModel:(SMFeedModel *)feedModel; //插入feed内容
- (RACSignal *)selectAllFeeds; //读取所有feeds
- (RACSignal *)selectFeedItemsWithPage:(NSUInteger)page fid:(NSUInteger)fid;

@end
