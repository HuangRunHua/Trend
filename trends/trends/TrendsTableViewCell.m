//
//  TrendsTableViewCell.m
//  trends
//
//  Created by Runhua Huang on 2024/5/3.
//

#import "TrendsTableViewCell.h"

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
        [self.titleLabel.rightAnchor constraintEqualToAnchor: self.iconImageView ? self.iconImageView.leftAnchor : self.contentView.rightAnchor constant:-14],
    ]];
}


- (void)setRank:(NSUInteger)newRank {
    if (newRank != self.rank) {
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
        self.titleLabel.text = newTitle;
    }
}
@end
