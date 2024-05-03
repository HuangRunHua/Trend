//
//  BilibiliTrendsViewController.m
//  trends
//
//  Created by Runhua Huang on 2024/5/2.
//  https://app.bilibili.com/x/v2/search/trending/ranking
//

#import "BilibiliTrendsViewController.h"
#import "TrendsTableViewCell.h"
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
        @"央视专访中国首位手语律师央视专访中国首位手语律师央视专访中国首位手语律师",
        @"韩国大力发展主机游戏",
        @"国际快递被海盗抢了",
        @"大唐不夜城被六国游客攻陷",
        @"Epic喜加二",
        @"五一档黑马口碑炸裂",
        @"成龙当场质疑签名书数量",
        @"梅大高速塌方已致48人死亡",
        @"TES零封LLL",
        @"EDG零封AG",
        @"梅大高速塌方一家5口遇难",
        @"G2俱乐部竞聘海底捞",
        @"JDG官宣战马加入",
        @"九龙城寨真实历史揭秘",
        @"夏奥会或改为秋奥会",
        @"这次领先世界的是我们",
        @"YOASOBI演唱物语新OP",
        @"男演员骗88人到柬埔寨电诈",
        @"FNC想起被TES让2追3",
        @"明日TES和T1都有比赛",
        @"特朗普违反禁言令被罚",
        @"Ale AL",
        @"哥伦比亚称将与以色列断交",
        @"GAM中单被杀到Emo",
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
    cell.rank = indexPath.row + 1;
    cell.title = _trends[indexPath.row];
//    cell.rankLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)indexPath.row + 1];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

@end
