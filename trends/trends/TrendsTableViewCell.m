//
//  TrendsTableViewCell.m
//  trends
//
//  Created by Runhua Huang on 2024/5/3.
//

#import "TrendsTableViewCell.h"

@interface TrendsTableViewCell ()
@end

@implementation TrendsTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self loadContentView];
        [self loadRankLabel];
    }
    return self;
}

- (void)loadContentView {
//    self.contentView.backgroundColor = [UIColor redColor];
}

- (void)loadRankLabel {
    self.rankLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.rankLabel];
    self.rankLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.rankLabel.font = [UIFont fontWithName:@"Optima-Bold" size:20];
    self.rankLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)self.rank];
    self.rankLabel.textAlignment = NSTextAlignmentCenter;
    if ([self.rankLabel.text isEqual: @"1"]) {
        self.rankLabel.textColor = [UIColor orangeColor];
    } else if ([self.rankLabel.text isEqual: @"2"]) {
        self.rankLabel.textColor = [UIColor blueColor];
    } else if ([self.rankLabel.text isEqual: @"3"]) {
        self.rankLabel.textColor = [UIColor yellowColor];
    } else {
        self.rankLabel.textColor = [UIColor grayColor];
    }
    
    [NSLayoutConstraint activateConstraints: @[
        [self.rankLabel.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:14],
        [self.rankLabel.leftAnchor constraintEqualToAnchor:self.contentView.leftAnchor constant:14],
        [self.rankLabel.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant:-14],
        [self.rankLabel.widthAnchor constraintEqualToConstant:30]
    ]];
}
@end
