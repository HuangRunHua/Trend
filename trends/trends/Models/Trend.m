//
//  Trend.m
//  trends
//
//  Created by Runhua Huang on 2024/5/3.
//

#import "Trend.h"

@implementation Trend
+ (JSONKeyMapper *)keyMapper
{
    return [JSONKeyMapper mapperForSnakeCase];
}
@end
