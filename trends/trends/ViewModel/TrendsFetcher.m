//
//  TrendsFetcher.m
//  trends
//
//  Created by Runhua Huang on 2024/5/4.
//

#import "TrendsFetcher.h"
#import "../Models/ResponseData.h"

@implementation TrendsFetcher

+ (instancetype)defaultFetcher {
    static TrendsFetcher *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[TrendsFetcher alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _trends = @[];
    }
    return self;
}

- (void)fetchTrendsFromURLString:(nonnull NSString *)urlString {
    [self fetchContentFromURLString:urlString completion:^(NSString *content, NSError *error) {
        if (!error) {
            [self parseResponseDataWithContent:content];
        }
    }];
}

- (void)fetchContentFromURLString:(NSString *)urlString
                 completion:(void (^)(NSString * __strong, NSError * __strong))completion {
    NSURL *url = [NSURL URLWithString:urlString];
    if (!url) {
        NSLog(@"Invalid URL string.");
        if (completion) {
            NSError *error = [NSError errorWithDomain:@"TrendsFetcherError" code:1001 userInfo:@{NSLocalizedDescriptionKey: @"Invalid URL format."}];
            completion(nil, error);
        }
        return;
    }

    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            NSLog(@"Failed to fetch data: %@", error.localizedDescription);
            if (completion) {
                completion(nil, error);
            }
        } else {
            NSString *content = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            if (content) {
                if (completion) {
                    completion(content, nil);
                }
            } else {
                NSLog(@"Failed to decode data to string.");
                if (completion) {
                    NSError *decodeError = [NSError errorWithDomain:@"TrendsFetcherError" code:1002 userInfo:@{NSLocalizedDescriptionKey: @"Failed to decode data."}];
                    completion(nil, decodeError);
                }
            }
        }
    }];
    [task resume];
}

- (void) parseResponseDataWithContent: (NSString *) content {
    NSError *error;
    ResponseData *responseData = [[ResponseData alloc] initWithString: content error:&error];
    if (error) {
        NSLog(@"Error occured when parsing response data: %@", error.localizedDescription);
        dispatch_async(dispatch_get_main_queue(), ^{
            [TrendsFetcher defaultFetcher].trends = @[];
        });
    } else if (responseData == nil) {
        NSLog(@"Failed to parse response data.");
        dispatch_async(dispatch_get_main_queue(), ^{
            [TrendsFetcher defaultFetcher].trends = @[];
        });
    }  else {
        // 将NSDictionary对象转换为Trend对象
        NSMutableArray<Trend *> *trends = [NSMutableArray array];
        for (NSDictionary *dict in responseData.data.list) {
            Trend *trend = [[Trend alloc] init];
            trend.position = [dict[@"position"] integerValue];
            trend.keyword = dict[@"keyword"];
            trend.showName = dict[@"show_name"];
            trend.wordType = [dict[@"word_type"] integerValue];
            NSString *iconURL = [dict[@"icon"] stringByReplacingOccurrencesOfString:@"http://" withString:@"https://"];
            trend.icon = iconURL;
            trend.hotId = [dict[@"hot_id"] integerValue];
            trend.isCommercial = dict[@"is_commercial"];
            trend.showLiveIcon = dict[@"show_live_icon"] ? [dict[@"show_live_icon"] boolValue] : NO;
            [trends addObject:trend];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [TrendsFetcher defaultFetcher].trends = trends;
        });
    }
}

@end
