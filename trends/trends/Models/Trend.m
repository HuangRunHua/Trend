//
//  Trend.m
//  trends
//
//  Created by Runhua Huang on 2024/5/3.
//

#import "Trend.h"

@implementation Trend
@synthesize position, keyword, showName, wordType, icon, hotID, isCommercial;

- (instancetype)initWithPosition:(NSUInteger)position 
                             keyword:(NSString *)keyword
                            showName:(NSString *)showName
                            wordType:(NSUInteger)wordType
                                icon:(nullable NSString *)icon
                               hotID:(NSUInteger)hotID
                        isCommercial:(NSString *)isCommercial {
    self = [super init];
    if (self) {
        self.position = position;
        self.keyword = keyword;
        self.showName = showName;
        self.wordType = wordType;
        self.icon = icon;
        self.hotID = hotID;
        self.isCommercial = isCommercial;
    }
    return self;
}

- (nonnull instancetype)initWithPosition:(NSUInteger)position 
                                 keyword:(NSString *)keyword
                                showName:(NSString *)showName
                                wordType:(NSUInteger)wordType
                                   hotID:(NSUInteger)hotID
                            isCommercial:(NSString *)isCommercial {
    self = [super init];
    if (self) {
        self.position = position;
        self.keyword = keyword;
        self.showName = showName;
        self.wordType = wordType;
        self.hotID = hotID;
        self.isCommercial = isCommercial;
    }
    return self;
}

@end
