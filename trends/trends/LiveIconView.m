//
//  LiveIconView.m
//  trends
//
//  Created by Runhua Huang on 2024/5/18.
//

#import "LiveIconView.h"
#define TEXT_PADDING 3

@interface LiveIconView ()
@property(nonatomic, strong) UIView *roundRectangleView;
@property(nonatomic, strong) UILabel *titleLabel;
@end

@implementation LiveIconView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupRoundRectangleView];
        [self setupTitleLabel];
    }
    return self;
}

- (void)setupRoundRectangleView
{
    self.roundRectangleView = [[UIView alloc] init];
    self.roundRectangleView.translatesAutoresizingMaskIntoConstraints = NO;
    self.roundRectangleView.backgroundColor = [UIColor colorNamed:@"liveIconBackgroundColor"];
    self.roundRectangleView.layer.cornerRadius = 3;
    self.roundRectangleView.layer.masksToBounds = YES;
    [self addSubview: self.roundRectangleView];
    
    [NSLayoutConstraint activateConstraints: @[
        [self.roundRectangleView.topAnchor constraintEqualToAnchor:self.topAnchor],
        [self.roundRectangleView.leftAnchor constraintEqualToAnchor:self.leftAnchor],
        [self.roundRectangleView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor],
        [self.roundRectangleView.rightAnchor constraintEqualToAnchor:self.rightAnchor]
    ]];
}

- (void)setupTitleLabel
{
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.text = @"直播中";
    self.titleLabel.font = [UIFont systemFontOfSize:11];
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.titleLabel.textColor = [UIColor whiteColor];
    [self.roundRectangleView addSubview:self.titleLabel];
    
    [NSLayoutConstraint activateConstraints: @[
        [self.titleLabel.topAnchor constraintEqualToAnchor:self.roundRectangleView.topAnchor constant:TEXT_PADDING],
        [self.titleLabel.leftAnchor constraintEqualToAnchor:self.roundRectangleView.leftAnchor constant:TEXT_PADDING],
        [self.titleLabel.bottomAnchor constraintEqualToAnchor:self.roundRectangleView.bottomAnchor constant:-TEXT_PADDING],
        [self.titleLabel.rightAnchor constraintEqualToAnchor:self.roundRectangleView.rightAnchor constant:-TEXT_PADDING]
    ]];
}



@end
