//
//  SMRootViewController.m
//  GCDFetchFeed
//
//  Created by DaiMing on 16/1/19.
//  Copyright © 2016年 Starming. All rights reserved.
//

#import "SMRootViewController.h"
#import "SMNetManager.h"
#import "Ono.h"
#import "Masonry.h"
#import "SMNotificationConst.h"

#import "SMFeedStore.h"
#import "SMRootDataSource.h"
#import "SMRootCell.h"

static NSString *rootViewControllerIdentifier = @"SMRootViewControllerCell";

@interface SMRootViewController()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *feeds;
@property (nonatomic, strong) SMFeedStore *feedStore;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) SMRootDataSource *dataSource;

@end

@implementation SMRootViewController

#pragma mark - Life Cycle
- (instancetype)init {
    self = [super init];
    if (self) {
        //
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //Notification
    [self buildNotificationObserver];
    //UI
    self.title = @"GCDFetchFeed";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:rootViewControllerIdentifier];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_topLayoutGuideTop);
        make.left.right.bottom.equalTo(self.view);
    }];
    [self.tableView reloadData];
    
    //空判断
    if (self.feeds.count > 0) {
        //
    } else {
        return;
    }
    [[SMNetManager shareInstance] fetchAllFeedWithModelArray:self.feeds];

}
//Notification
- (void)buildNotificationObserver {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fetchedOneFeed:) name:NetworkingFetchOneFeedCompleteNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fetchedAllFeeds:) name:NetworkingFetchAllFeedsCompleteNotification object:nil];
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - private
//抓完一个
- (void)fetchedOneFeed:(NSNotification *)notification {
    NSString *indexString = [notification.userInfo objectForKey:@"index"];
    NSUInteger index = [indexString integerValue];
    self.feeds[index] = [SMNetManager shareInstance].feeds[index];
    [self.tableView reloadData];
}
//抓完所有的feeds
- (void)fetchedAllFeeds:(NSNotification *)notification {
    NSLog(@"fetch complete");
}

#pragma mark - Delegate
#pragma mark - TableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.feeds count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:rootViewControllerIdentifier];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.contentView.backgroundColor = [UIColor clearColor];
    
    SMRootCell *v = (SMRootCell *)[cell viewWithTag:123432];
    
    if (!v) {
        v = [[SMRootCell alloc] init];
        v.frame = CGRectMake(0, 0, self.view.bounds.size.width, 70);
        v.tag = 123432;
        [cell.contentView addSubview:v];
    }
    
    SMFeedModel *model = self.feeds[indexPath.row];
    SMRootCellViewModel *viewModel = [[SMRootCellViewModel alloc] init];
    viewModel.titleString = model.title;
    viewModel.contentString = model.des;
    viewModel.iconUrl = model.imageUrl;
    NSUInteger itemsCount = model.items.count;
    viewModel.highlightString = [NSString stringWithFormat:@"%lu条",(unsigned long)itemsCount];
    [v updateWithViewModel:viewModel];
    
    return cell;
}

#pragma mark - Getter
- (SMRootDataSource *)dataSource {
    if (!_dataSource) {
        _dataSource = [[SMRootDataSource alloc] init];
    }
    return _dataSource;
}
- (SMFeedStore *)feedStore {
    if (!_feedStore) {
        _feedStore = [[SMFeedStore alloc] init];
    }
    return _feedStore;
}
- (NSMutableArray *)feeds {
    if (!_feeds) {
        NSMutableArray *mArr = [NSMutableArray array];
        SMFeedModel *starmingFeed = [[SMFeedModel alloc] init];
        starmingFeed.title = @"Starming星光社最新更新";
        starmingFeed.feedUrl = @"http://www.starming.com/index.php?v=index&rss=all";
        starmingFeed.imageUrl = @"";
        [mArr addObject:starmingFeed];
        
        SMFeedModel *cnbetaFeed = [[SMFeedModel alloc] init];
        cnbetaFeed.title = @"cnBeta.COM业界咨询";
        cnbetaFeed.feedUrl = @"http://www.cnbeta.com/backend.php";
        cnbetaFeed.imageUrl = @"http://tp4.sinaimg.cn/2769378403/180/5726899232/1";
        [mArr addObject:cnbetaFeed];
        
        SMFeedModel *kr36Feed = [[SMFeedModel alloc] init];
        kr36Feed.title = @"36氪";
        kr36Feed.feedUrl = @"http://www.36kr.com/feed";
        kr36Feed.imageUrl = @"http://krplus-cdn.b0.upaiyun.com/common-module/common-header/images/logo.png";
        [mArr addObject:kr36Feed];
        
        SMFeedModel *dgtleFeed = [[SMFeedModel alloc] init];
        dgtleFeed.title = @"数字尾巴-分享美好数字生活";
        dgtleFeed.feedUrl = @"http://www.dgtle.com/rss/dgtle.xml";
        dgtleFeed.imageUrl = @"http://tp1.sinaimg.cn/1726544024/180/5630520790/1";
        [mArr addObject:dgtleFeed];
        
        SMFeedModel *ifanrFeed = [[SMFeedModel alloc] init];
        ifanrFeed.title = @"爱范儿";
        ifanrFeed.feedUrl = @"http://www.ifanr.com/feed";
        ifanrFeed.imageUrl = @"http://tp1.sinaimg.cn/1642720480/180/5742721759/1";
        [mArr addObject:ifanrFeed];
        
        SMFeedModel *songshuhuiFeed = [[SMFeedModel alloc] init];
        songshuhuiFeed.title = @"科学松鼠会";
        songshuhuiFeed.feedUrl = @"http://songshuhui.net/feed";
        songshuhuiFeed.imageUrl = @"http://tp3.sinaimg.cn/1529573474/180/5676965583/0";
        [mArr addObject:songshuhuiFeed];
        
        _feeds = [NSMutableArray arrayWithArray:mArr];
    }
    return _feeds;
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.showsVerticalScrollIndicator = false;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}



@end
