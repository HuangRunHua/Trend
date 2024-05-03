//
//  TrendsTableViewCell.h
//  trends
//
//  Created by Runhua Huang on 2024/5/3.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TrendsTableViewCell : UITableViewCell
@property NSUInteger rank;
@property(nonatomic, strong) UILabel *rankLabel;
@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UIImageView *iconImageView;
@end

NS_ASSUME_NONNULL_END
