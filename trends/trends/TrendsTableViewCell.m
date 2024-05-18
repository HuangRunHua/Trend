//
//  TrendsTableViewCell.m
//  trends
//
//  Created by Runhua Huang on 2024/5/3.
//

#import "TrendsTableViewCell.h"
#import "LiveIconView.h"
#import <SDWebImage/SDWebImage.h>

@interface TrendsTableViewCell ()
@property(nonatomic, strong) UILabel *rankLabel;
@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UIImageView *iconImageView;
@property(nonatomic, strong) LiveIconView *liveIconView;
@end

@implementation TrendsTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style 
              reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _showLiveIcon = NO;
        [self loadRankLabel];
        [self loadTitleLabel];
        [self loadLiveIconView];
        [self loadIconImageView];
    }
    return self;
}

- (void)loadRankLabel {
    self.rankLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.rankLabel];
    self.rankLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.rankLabel.font = [UIFont fontWithName:@"Helvetica-BoldOblique" size:20.0];
    self.rankLabel.textAlignment = NSTextAlignmentCenter;
    [NSLayoutConstraint activateConstraints: @[
        [self.rankLabel.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:14],
        [self.rankLabel.leftAnchor constraintEqualToAnchor:self.contentView.leftAnchor constant:14],
        [self.rankLabel.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant:-14],
        [self.rankLabel.widthAnchor constraintEqualToConstant:30]
    ]];
}

- (void)loadTitleLabel {
    self.titleLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.titleLabel];
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.titleLabel.font = [UIFont systemFontOfSize: 17];
    [NSLayoutConstraint activateConstraints: @[
        [self.titleLabel.topAnchor constraintEqualToAnchor:self.rankLabel.topAnchor],
        [self.titleLabel.leftAnchor constraintEqualToAnchor:self.rankLabel.rightAnchor constant:14],
        [self.titleLabel.bottomAnchor constraintEqualToAnchor:self.rankLabel.bottomAnchor],
    ]];
}

- (void)loadIconImageView {
    self.iconImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.iconImageView];
    self.iconImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.iconImageView.contentMode = UIViewContentModeScaleAspectFit;
    [NSLayoutConstraint activateConstraints: @[
        [self.iconImageView.topAnchor constraintEqualToAnchor:self.rankLabel.topAnchor constant:2],
        [self.iconImageView.bottomAnchor constraintEqualToAnchor:self.rankLabel.bottomAnchor constant:-2],
        [self.iconImageView.leftAnchor constraintEqualToAnchor:self.titleLabel.rightAnchor constant:7],
        [self.iconImageView.rightAnchor constraintLessThanOrEqualToAnchor: self.contentView.rightAnchor constant:-14],
    ]];
}

- (void)loadLiveIconView {
    self.liveIconView = [[LiveIconView alloc] init];
    [self.contentView addSubview:self.liveIconView];
    self.liveIconView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints: @[
        [self.liveIconView.topAnchor constraintEqualToAnchor:self.rankLabel.topAnchor constant:2],
        [self.liveIconView.bottomAnchor constraintEqualToAnchor:self.rankLabel.bottomAnchor constant:-2],
        [self.liveIconView.leftAnchor constraintEqualToAnchor:self.titleLabel.rightAnchor constant:7],
        [self.liveIconView.widthAnchor constraintEqualToConstant:40],
        [self.liveIconView.rightAnchor constraintLessThanOrEqualToAnchor: self.contentView.rightAnchor constant:-14],
    ]];
}

- (void)setRank:(NSUInteger)newRank {
    if (newRank != self.rank) {
        _rank = newRank;
        self.rankLabel.text = [NSString stringWithFormat:@"%lu", newRank];
        switch (newRank) {
            case 1:
                self.rankLabel.textColor = [UIColor colorNamed:@"firstRankColor"];
                break;
            case 2:
                self.rankLabel.textColor = [UIColor colorNamed:@"secondRankColor"];
                break;
            case 3:
                self.rankLabel.textColor = [UIColor colorNamed:@"thirdRankColor"];
                break;
            default:
                self.rankLabel.textColor = [UIColor colorNamed:@"defaultRankColor"];
                break;
        }
    }
}

- (void)setTitle:(NSString *)newTitle {
    if (![self.title isEqual:newTitle]) {
        _title = [newTitle copy];
        self.titleLabel.text = newTitle;
    }
}

- (void)setShowLiveIcon:(Boolean)newShowLiveIcon 
{
    _showLiveIcon = newShowLiveIcon;
    if (_showLiveIcon) {
        [self.contentView addSubview:self.liveIconView];
        [NSLayoutConstraint activateConstraints: @[
            [self.titleLabel.rightAnchor constraintEqualToAnchor: self.liveIconView.leftAnchor constant:-7]
        ]];
    } else {
        [self.liveIconView removeFromSuperview];
        [NSLayoutConstraint activateConstraints:@[
            [self.titleLabel.rightAnchor constraintLessThanOrEqualToAnchor: self.contentView.rightAnchor constant:-14]
        ]];
    }
}

- (void)setIconURLString:(NSString *)newIconURLString {
    if (![self.iconURLString isEqual: newIconURLString]) {
        _iconURLString = [newIconURLString copy];
        [self.iconImageView sd_setImageWithURL: [NSURL URLWithString: newIconURLString] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            if (!error) {
                CGFloat iconImageWidth = image.size.width;
                CGFloat iconImageHeight = image.size.height;
                [NSLayoutConstraint activateConstraints: @[
                    [self.iconImageView.widthAnchor constraintEqualToAnchor:self.iconImageView.heightAnchor multiplier:(iconImageWidth / iconImageHeight)],
                    [self.titleLabel.rightAnchor constraintEqualToAnchor: self.iconImageView.leftAnchor constant:-7]
                ]];
                [self.contentView addSubview: self.iconImageView];
            } else {
                /// 热度图片加载失败时移除`iconImageView`
                [self.iconImageView removeFromSuperview];
                /// 当没有热度视图的时候，标签的最右侧与cell的最右侧始终有至少14dp的间隔
                [NSLayoutConstraint activateConstraints:@[
                    [self.titleLabel.rightAnchor constraintLessThanOrEqualToAnchor: self.contentView.rightAnchor constant:-14]
                ]];
            }
        }];
    }
}
@end
