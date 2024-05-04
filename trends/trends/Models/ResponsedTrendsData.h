//
//  ResponsedTrendsData.h
//  trends
//
//  Created by Runhua Huang on 2024/5/4.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>
#import "Trend.h"

NS_ASSUME_NONNULL_BEGIN

@interface ResponsedTrendsData : JSONModel
@property(nonatomic, copy) NSString *trackid;
@property(nonatomic, copy) NSArray <Trend *> *list;
@property(nonatomic, copy) NSArray *topList;
@property(nonatomic, copy) NSString *hotwordEggInfo;
@end

NS_ASSUME_NONNULL_END
