//
//  TrendsTableViewCell.h
//  trends
//
//  Created by Runhua Huang on 2024/5/3.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TrendsTableViewCell : UITableViewCell
@property(nonatomic, assign) NSUInteger rank;
@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy, nullable) NSString *iconURLString;
@end

NS_ASSUME_NONNULL_END
