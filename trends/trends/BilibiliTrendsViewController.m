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
#define TABLEVIEW_OFFSET_DISTANCE 50
#define BUTTOM_SAFE_AREA 60
#define DEFAULT_PADDING 40

@interface BilibiliTrendsViewController ()
{
    NSArray *_trends;
}
@property (nonatomic, strong) UITableView *trendsTableView;
@property (nonatomic, strong) UIImageView *coverImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIScrollView *backgroundScrollView;
@property (nonatomic, strong) UITextView *bottomTextView;
@end

@implementation BilibiliTrendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self fetchTrends];
    [self loadScrollView];
    [self loadCoverImageView];
    [self loadTitleLabel];
    [self setupTableView];
    [self loadBottomTextView];
}

- (void)fetchTrends {
    _trends = @[
        [[Trend alloc] initWithPosition:1
                                 keyword:@"BLG送JDG大会员"
                                showName:@"BLG送JDG大会员"
                                wordType:4
                                    icon:@"https://i0.hdslb.com/bfs/activity-plat/static/20221118/eaf2dd702d7cc14d8d9511190245d057/UF7B1wVKT2.png"
                                   hotID:156973
                            isCommercial:@"0"],
        [[Trend alloc] initWithPosition:2
                                 keyword:@"FNC TES"
                                showName:@"TES战胜FNC"
                                wordType:5
                                    icon:@"https://i0.hdslb.com/bfs/activity-plat/static/20221213/eaf2dd702d7cc14d8d9511190245d057/lrx9rnKo24.png"
                                   hotID:156940
                            isCommercial:@"0"],
        [[Trend alloc] initWithPosition:3
                                 keyword:@"嫦娥六号成功发射"
                                showName:@"嫦娥六号成功发射"
                                wordType:5
                                    icon:@"https://i0.hdslb.com/bfs/activity-plat/static/20221213/eaf2dd702d7cc14d8d9511190245d057/lrx9rnKo24.png"
                                   hotID:156958
                            isCommercial:@"0"],
        [[Trend alloc] initWithPosition:4
                                 keyword:@"茶百道回应外卖变白水"
                                showName:@"茶百道回应外卖变白水"
                                wordType:5
                                    icon:@"https://i0.hdslb.com/bfs/activity-plat/static/20221213/eaf2dd702d7cc14d8d9511190245d057/lrx9rnKo24.png"
                                   hotID:156920
                            isCommercial:@"0"],
        [[Trend alloc] initWithPosition:5
                                 keyword:@"骨王最强新反派"
                                showName:@"骨王最强新反派"
                                wordType:4
                                    icon:@"https://i0.hdslb.com/bfs/activity-plat/static/20221118/eaf2dd702d7cc14d8d9511190245d057/UF7B1wVKT2.png"
                                   hotID:156967
                            isCommercial:@"0"],
        [[Trend alloc] initWithPosition:6
                                 keyword:@"新的反派瑞克登场"
                                showName:@"新的反派瑞克登场"
                                wordType:4
                                    icon:@"https://i0.hdslb.com/bfs/activity-plat/static/20221118/eaf2dd702d7cc14d8d9511190245d057/UF7B1wVKT2.png"
                                   hotID:156968
                            isCommercial:@"0"],
        [[Trend alloc] initWithPosition:7
                                 keyword:@"清华教授聊间谍过家家"
                                showName:@"清华教授聊间谍过家家"
                                wordType:8
                                   hotID:156897
                            isCommercial:@"0"],
        [[Trend alloc] initWithPosition:8
                                 keyword:@"牛约堡致歉"
                                showName:@"牛约堡致歉"
                                wordType:8
                                   hotID:156963
                            isCommercial:@"0"],
        [[Trend alloc] initWithPosition:9
                                 keyword:@"1家5口被海浪卷走4人遇难"
                                showName:@"1家5口被海浪卷走4人遇难"
                                wordType:8
                                   hotID:156938
                            isCommercial:@"0"],
        [[Trend alloc] initWithPosition:10
                                 keyword:@"1比1还原约尔"
                                showName:@"1比1还原约尔"
                                wordType:8
                                   hotID:156950
                            isCommercial:@"0"],
        [[Trend alloc] initWithPosition:11
                                 keyword:@"张雨绮代言辣条化妆品"
                                showName:@"张雨绮代言辣条化妆品"
                                wordType:8
                                   hotID:156910
                            isCommercial:@"0"],
        [[Trend alloc] initWithPosition:12
                                 keyword:@"梅大高速下跪拦车的老人"
                                showName:@"梅大高速下跪拦车的老人"
                                wordType:8
                                   hotID:156936
                            isCommercial:@"0"],
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
    
    [self.backgroundScrollView addSubview:self.bottomTextView];
    self.bottomTextView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints: @[
        [self.bottomTextView.topAnchor
            constraintEqualToAnchor:self.coverImageView.bottomAnchor
         constant:_trends.count*50 - DEFAULT_PADDING],
        [self.bottomTextView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor],
        [self.bottomTextView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor],
        [self.bottomTextView.heightAnchor constraintEqualToConstant:60]
    ]];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.backgroundScrollView.contentSize = CGSizeMake(
            UIScreen.mainScreen.bounds.size.width,
            _trends.count*50 + self.coverImageView.frame.size.height + self.bottomTextView.frame.size.height + BUTTOM_SAFE_AREA
    );
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _trends.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    TrendsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[TrendsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    Trend *currentTrend = _trends[indexPath.row];
    cell.rank = currentTrend.position;
    cell.title = currentTrend.showName;
    cell.iconURLString = currentTrend.icon;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

@end
