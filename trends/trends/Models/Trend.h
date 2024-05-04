//
//  Trends.h
//  trends
//
//  Created by Runhua Huang on 2024/5/3.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>

NS_ASSUME_NONNULL_BEGIN

@interface Trend : JSONModel
@property(nonatomic, assign) NSUInteger position;
@property(nonatomic, strong) NSString *keyword;
@property(nonatomic, strong) NSString *showName;
@property(nonatomic, assign) NSUInteger wordType;
@property(nonatomic, strong) NSString <Optional> *icon;
@property(nonatomic, assign) NSUInteger hotId;
@property(nonatomic, strong) NSString *isCommercial;
@property(nonatomic, assign) Boolean showLiveIcon;

//- (instancetype)initWithPosition: (NSUInteger) position
//                     keyword: (NSString *) keyword
//                    showName: (NSString *) showName
//                    wordType: (NSUInteger) wordType
//                        icon: (nullable NSString *) icon
//                       hotID: (NSUInteger) hotID
//                isCommercial: (NSString *) isCommercial
//                    showLiveIcon: (Boolean) showLiveIcon;

//- (instancetype)initWithPosition: (NSUInteger) position
//                     keyword: (NSString *) keyword
//                    showName: (NSString *) showName
//                    wordType: (NSUInteger) wordType
//                       hotID: (NSUInteger) hotID
//                isCommercial: (NSString *) isCommercial;
//
//- (instancetype)initWithPosition: (NSUInteger) position
//                     keyword: (NSString *) keyword
//                    showName: (NSString *) showName
//                    wordType: (NSUInteger) wordType
//                        icon: (nullable NSString *) icon
//                       hotID: (NSUInteger) hotID
//                isCommercial: (NSString *) isCommercial;
@end

NS_ASSUME_NONNULL_END
