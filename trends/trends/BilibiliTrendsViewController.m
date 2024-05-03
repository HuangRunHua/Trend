//
//  BilibiliTrendsViewController.m
//  trends
//
//  Created by Runhua Huang on 2024/5/2.
//

#import "BilibiliTrendsViewController.h"
#define TABLEVIEW_OFFSET_DISTANCE 50
#define BUTTOM_SAFE_AREA 60

@interface BilibiliTrendsViewController ()
{
    NSArray *_trends;
}
@property (nonatomic, strong) UITableView *trendsTableView;
@property (nonatomic, strong) UIImageView *coverImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIScrollView *backgroundScrollView;
@property (nonatomic, strong) UILabel *bottomLabel;
@end

@implementation BilibiliTrendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self fetchTrends];
    [self loadScrollView];
    [self loadCoverImageView];
    [self loadTitleLabel];
    [self setupTableView];
    [self loadBottomLabel];
}

- (void)fetchTrends {
    _trends = @[
        @"央视专访中国首位手语律师",
        @"韩国大力发展主机游戏",
        @"国际快递被海盗抢了",
        @"大唐不夜城被六国游客攻陷",
        @"Epic喜加二",
        @"五一档黑马口碑炸裂",
    ];
}

- (void)loadScrollView {
    CGRect fullScreenRect = [[UIScreen mainScreen] bounds];
    self.backgroundScrollView = [[UIScrollView alloc] initWithFrame:fullScreenRect];
    self.backgroundScrollView.backgroundColor = [UIColor colorNamed:@"scrollViewDefaultBackgroundColor"];
    [self.view addSubview: self.backgroundScrollView];
    self.backgroundScrollView.showsVerticalScrollIndicator = YES;
    self.backgroundScrollView.translatesAutoresizingMaskIntoConstraints = NO;
    self.backgroundScrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.backgroundScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    [NSLayoutConstraint activateConstraints: @[
        [self.backgroundScrollView.topAnchor constraintEqualToAnchor:self.view.topAnchor],
        [self.backgroundScrollView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor],
        [self.backgroundScrollView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor],
        [self.backgroundScrollView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],
    ]];
}

- (void)loadCoverImageView {
    CGRect coverImageViewBound = CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, 9.0/16.0*UIScreen.mainScreen.bounds.size.width);
    self.coverImageView = [[UIImageView alloc] initWithFrame:coverImageViewBound];
    [self.backgroundScrollView addSubview:self.coverImageView];
    self.coverImageView.image = [UIImage imageNamed:@"bilibili_trends"];
    self.coverImageView.contentMode = UIViewContentModeScaleAspectFit;
    [NSLayoutConstraint activateConstraints: @[
        [self.coverImageView.topAnchor constraintEqualToAnchor:self.view.topAnchor],
        [self.coverImageView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor],
        [self.coverImageView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor],
    ]];
}

- (void)loadTitleLabel {
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.titleLabel.text = @"bilibili热搜";
    self.titleLabel.font = [UIFont fontWithName:@"Optima-Bold" size:55];
    self.titleLabel.textColor = [UIColor whiteColor];
    [self.coverImageView addSubview:self.titleLabel];
    [NSLayoutConstraint activateConstraints: @[
        [self.titleLabel.centerXAnchor constraintEqualToAnchor:self.coverImageView.centerXAnchor],
        [self.titleLabel.centerYAnchor constraintEqualToAnchor:self.coverImageView.centerYAnchor],
    ]];
}

- (void) setupTableView {
    self.trendsTableView = [[UITableView alloc] init];
    
    self.trendsTableView.delegate = self;
    self.trendsTableView.dataSource = self;
    self.trendsTableView.translatesAutoresizingMaskIntoConstraints = NO;
    self.trendsTableView.scrollEnabled = NO;
    
    [self.backgroundScrollView addSubview:self.trendsTableView];
    
    [NSLayoutConstraint activateConstraints: @[
        [self.trendsTableView.topAnchor constraintEqualToAnchor:self.coverImageView.bottomAnchor constant:-TABLEVIEW_OFFSET_DISTANCE],
        [self.trendsTableView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor],
        [self.trendsTableView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor],
        [self.trendsTableView.heightAnchor constraintEqualToConstant:_trends.count*50]
    ]];
    
    /// 设置左上角和右上角为圆角
    [self.trendsTableView layoutIfNeeded];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.trendsTableView.bounds
                                                   byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerTopRight)
                                                         cornerRadii:CGSizeMake(20.0, 20.0)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.trendsTableView.bounds;
    maskLayer.path = maskPath.CGPath;
    self.trendsTableView.layer.mask = maskLayer;
}

- (void) loadBottomLabel {
    self.bottomLabel = [[UILabel alloc] init];
    self.bottomLabel.text = @"已经达到热搜榜单尽头惹，关于热搜榜 >";
    self.bottomLabel.backgroundColor = [UIColor colorNamed:@"scrollViewDefaultBackgroundColor"];;
    self.bottomLabel.font = [UIFont systemFontOfSize:15];
    self.bottomLabel.textColor = [UIColor grayColor];
    self.bottomLabel.textAlignment = NSTextAlignmentCenter;
    [self.backgroundScrollView addSubview:self.bottomLabel];
    self.bottomLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints: @[
        [self.bottomLabel.topAnchor 
            constraintEqualToAnchor:self.coverImageView.bottomAnchor
         constant:_trends.count*50 - TABLEVIEW_OFFSET_DISTANCE],
        [self.bottomLabel.leftAnchor constraintEqualToAnchor:self.view.leftAnchor],
        [self.bottomLabel.rightAnchor constraintEqualToAnchor:self.view.rightAnchor],
        [self.bottomLabel.heightAnchor constraintEqualToConstant:60]
    ]];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

    // 更新backgroundScrollView的contentSize
    self.backgroundScrollView.contentSize = CGSizeMake(
            UIScreen.mainScreen.bounds.size.width,
            _trends.count*50 + self.coverImageView.frame.size.height + self.bottomLabel.frame.size.height - TABLEVIEW_OFFSET_DISTANCE + BUTTOM_SAFE_AREA
    );
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _trends.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = _trends[(long)indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

@end
