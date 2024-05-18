//
//  BilibiliTrendsViewController.m
//  trends
//
//  Created by Runhua Huang on 2024/5/2.
//  https://app.bilibili.com/x/v2/search/trending/ranking
//

#import "BilibiliTrendsViewController.h"
#import "TrendsTableViewCell.h"
#import "Models/Trend.h"
#import "ViewModel/TrendsFetcher.h"
#define TABLEVIEW_OFFSET_DISTANCE 50
#define BUTTOM_SAFE_AREA 60
#define DEFAULT_PADDING 40

@interface BilibiliTrendsViewController ()
@property (nonatomic, strong) UITableView *trendsTableView;
@property (nonatomic, strong) UIImageView *coverImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIScrollView *backgroundScrollView;
@property (nonatomic, strong) UITextView *bottomTextView;
@property (nonatomic, strong) TrendsFetcher *trendsFetcher;
@end

@implementation BilibiliTrendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self fetchTrends];
    [self updateUI];
}

- (void)dealloc {
    [[TrendsFetcher defaultFetcher] removeObserver:self forKeyPath:@"trends"];
}

+ (NSString *)bilibiliTrendsURLString {
    return @"https://app.bilibili.com/x/v2/search/trending/ranking";
}

- (void)updateUI {
    [self loadScrollView];
    [self loadCoverImageView];
    [self loadTitleLabel];
    [self setupTableView];
    [self loadBottomTextView];
}

- (void)fetchTrends {
    _trendsFetcher = [[TrendsFetcher alloc] init];
    [_trendsFetcher fetchTrendsFromURLString:[BilibiliTrendsViewController bilibiliTrendsURLString]];
    [[TrendsFetcher defaultFetcher] addObserver: self
                                     forKeyPath:@"trends"
                                        options:NSKeyValueObservingOptionNew
                                        context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                       context:(void *)context {
    if ([keyPath isEqualToString:@"trends"] && object == [TrendsFetcher defaultFetcher]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self updateUI];
        });
    }
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
    // TODO: 设置translatesAutoresizingMaskIntoConstraints后ScrollView无法滚动
//    self.coverImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.backgroundScrollView addSubview:self.coverImageView];
    self.coverImageView.image = [UIImage imageNamed:@"bilibili_trends"];
    self.coverImageView.contentMode = UIViewContentModeScaleAspectFit;
    // TODO: 约束可能有冲突
    [NSLayoutConstraint activateConstraints: @[
        [self.coverImageView.topAnchor constraintEqualToAnchor:self.view.topAnchor],
        [self.coverImageView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor],
        [self.coverImageView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor],
        [self.coverImageView.heightAnchor constraintEqualToAnchor:self.coverImageView.widthAnchor multiplier:9.0/16.0]
    ]];
}

- (void)loadTitleLabel {
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.titleLabel.text = @"bilibili 热搜";
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
        [self.trendsTableView.heightAnchor constraintEqualToConstant:[TrendsFetcher defaultFetcher].trends.count*50]
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

- (void) loadBottomTextView {
    self.bottomTextView = [[UITextView alloc] init];
    self.bottomTextView.backgroundColor = [UIColor clearColor];
    self.bottomTextView.editable = NO;
    /// 自动检测链接
    self.bottomTextView.dataDetectorTypes = UIDataDetectorTypeLink;
    
    /// 创建富文本字符串
    NSString *text = @"已经达到热搜榜单尽头惹，关于热搜榜 >";
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:NSMakeRange(0, text.length)];
    /// 设置链接部分的字体颜色和下划线
    NSRange linkRange = [text rangeOfString:@"关于热搜榜 >"];
    [attributedString addAttribute:NSLinkAttributeName value:@"https://apple.com" range:linkRange];
    self.bottomTextView.attributedText = attributedString;
    self.bottomTextView.textAlignment = NSTextAlignmentCenter;
    self.bottomTextView.linkTextAttributes = @{
        NSForegroundColorAttributeName: [UIColor systemPinkColor]
    };
    self.bottomTextView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.backgroundScrollView addSubview:self.bottomTextView];
    [NSLayoutConstraint activateConstraints: @[
        [self.bottomTextView.topAnchor
            constraintEqualToAnchor:self.coverImageView.bottomAnchor
         constant:[TrendsFetcher defaultFetcher].trends.count*50 - DEFAULT_PADDING],
        [self.bottomTextView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor],
        [self.bottomTextView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor],
        [self.bottomTextView.heightAnchor constraintEqualToConstant:60]
    ]];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.backgroundScrollView.contentSize = CGSizeMake(
            UIScreen.mainScreen.bounds.size.width,self.trendsTableView.contentSize.height + self.coverImageView.frame.size.height + self.bottomTextView.contentSize.height + BUTTOM_SAFE_AREA - TABLEVIEW_OFFSET_DISTANCE
    );
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [TrendsFetcher defaultFetcher].trends.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    TrendsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[TrendsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    if ([TrendsFetcher defaultFetcher].trends.count > 0) {
        Trend *currentTrend = [TrendsFetcher defaultFetcher].trends[indexPath.row];
        if ([currentTrend isKindOfClass:[Trend class]]) {
            cell.rank = currentTrend.position;
            cell.title = currentTrend.showName;
            cell.iconURLString = currentTrend.icon;
            cell.showLiveIcon = currentTrend.showLiveIcon;
        } else {
            NSLog(@"Error: Expected a Trend object, but received: %@", [currentTrend class]);
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

@end
