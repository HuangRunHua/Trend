//
//  TrendsFetcher.h
//  trends
//
//  Created by Runhua Huang on 2024/5/4.
//

#import <Foundation/Foundation.h>
#import "../Models/Trend.h"

NS_ASSUME_NONNULL_BEGIN

@interface TrendsFetcher : NSObject
@property(nonatomic, copy) NSArray <Trend*> *trends;

+ (instancetype)defaultFetcher;
- (void)fetchTrendsFromURLString:(nonnull NSString *)urlString;
@end

NS_ASSUME_NONNULL_END
