//
//  ResponseData.h
//  trends
//
//  Created by Runhua Huang on 2024/5/4.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>
#import "ResponsedTrendsData.h"

NS_ASSUME_NONNULL_BEGIN
@interface ResponseData : JSONModel

@property(nonatomic, assign) NSUInteger code;
@property(nonatomic, copy) NSString *message;
@property(nonatomic, assign) NSUInteger ttl;
@property(nonatomic, copy) ResponsedTrendsData *data;

@end

NS_ASSUME_NONNULL_END
