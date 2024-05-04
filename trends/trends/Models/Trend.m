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

//- (instancetype)initWithPosition:(NSUInteger)position
//                             keyword:(NSString *)keyword
//                            showName:(NSString *)showName
//                            wordType:(NSUInteger)wordType
//                                icon:(nullable NSString *)icon
//                               hotID:(NSUInteger)hotID
//                        isCommercial:(NSString *)isCommercial
//                        showLiveIcon: (Boolean) showLiveIcon {
//    self = [super init];
//    if (self) {
//        _position = position;
//        _keyword = keyword;
//        _showName = showName;
//        _wordType = wordType;
//        _icon = icon;
//        _hotID = hotID;
//        _isCommercial = isCommercial;
//        _showLiveIcon = showLiveIcon;
//    }
//    return self;
//}
@end
