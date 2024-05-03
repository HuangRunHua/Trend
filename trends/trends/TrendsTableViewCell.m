//
//  TrendsTableViewCell.m
//  trends
//
//  Created by Runhua Huang on 2024/5/3.
//

#import "TrendsTableViewCell.h"
#import <SDWebImage/SDWebImage.h>

@interface TrendsTableViewCell ()
@property(nonatomic, strong) UILabel *rankLabel;
@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UIImageView *iconImageView;
@end

@implementation TrendsTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self loadRankLabel];
        [self loadTitleLabel];
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

- (void)setRank:(NSUInteger)newRank {
    if (newRank != self.rank) {
        _rank = newRank;
        self.rankLabel.text = [NSString stringWithFormat:@"%lu", newRank];
        if (newRank == 1) {
            self.rankLabel.textColor = [UIColor colorNamed:@"firstRankColor"];
        } else if (newRank == 2) {
            self.rankLabel.textColor = [UIColor colorNamed:@"secondRankColor"];
        } else if (newRank == 3) {
            self.rankLabel.textColor = [UIColor colorNamed:@"thirdRankColor"];
        } else {
            self.rankLabel.textColor = [UIColor grayColor];
        }
    }
}

- (void)setTitle:(NSString *)newTitle {
    if (![self.title isEqual:newTitle]) {
        _title = [newTitle copy];
        self.titleLabel.text = newTitle;
    }
}

- (void)setIconURLString:(NSString *)newIconURLString {
    if (![self.iconURLString isEqual: newIconURLString]) {
        _iconURLString = [newIconURLString copy];
        [self.iconImageView sd_setImageWithURL: [NSURL URLWithString: newIconURLString] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            CGFloat iconImageWidth = image.size.width;
            CGFloat iconImageHeight = image.size.height;
            [NSLayoutConstraint activateConstraints: @[
                [self.iconImageView.widthAnchor constraintEqualToAnchor:self.iconImageView.heightAnchor multiplier:(iconImageWidth / iconImageHeight)]
            ]];
        }];
    }
}
@end
