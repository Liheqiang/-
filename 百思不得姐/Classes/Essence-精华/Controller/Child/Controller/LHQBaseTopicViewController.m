//
//  LHQBaseTopicViewController.m
//  百思不得姐
//
//  Created by HqLee on 16/2/26.
//  Copyright © 2016年 HqLee. All rights reserved.
//

#import "LHQBaseTopicViewController.h"
#import "LHQBaseTopicCell.h"
#import "LHQTopic.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import <MJRefresh.h>
#import <SVProgressHUD.h>


@interface LHQBaseTopicViewController ()

@property (nonatomic, strong) NSMutableArray *topics;
@property (nonatomic, strong) NSMutableDictionary *params;
@property (nonatomic, assign) NSInteger maxTime;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, assign) NSInteger page;

@end

static NSString *const cellId = @"topic";

@implementation LHQBaseTopicViewController
#pragma mark --- lazy load ---
- (LHQTopicType)type{return 0;};

- (NSMutableDictionary *)params{
    if (_params) {
        return _params;
    }
    _params = [NSMutableDictionary dictionary];
    return _params;
}

- (NSMutableArray *)topics{
    if (_topics) {
        return _topics;
    }
    _topics = [NSMutableArray array];
    return _topics;
}

#pragma mark --- life cycle ---
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configParams];
    [self initView];
    [self firstRefresh];
}

#pragma mark --- private method ---
- (void)configParams{
    
    NSDictionary *params = @{@"a":@"list",
                             @"c":@"data",
                             @"maxtime":@(0),
                             @"type":@(self.type),
                             @"page":@(0)};
    
    [self.params addEntriesFromDictionary:params];
}
/**
 *   初始化视图
 */
- (void)initView{

    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LHQBaseTopicCell class]) bundle:nil] forCellReuseIdentifier:cellId];
    
    //这个属性非常重要
    self.tableView.contentInset = UIEdgeInsetsMake(navigationBarHeight + titleViewHeight, 0, self.tabBarController.tabBar.height, 0);
    //让滚动条的内边距也要和当前视图一样
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;//最初设置的是scrollView的，难怪没反应,让滚动视图的指示器也从下面开始
//    LHQLog(@"%@",NSStringFromUIEdgeInsets(self.tableView.contentInset));
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.backgroundColor = LHQGlobalBg;
    
    [self.tableView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    [self.tableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}

- (void)loadNewData{
    
//    self.tableView.header.hidden = NO;
    [self.params setObject:@(0) forKey:@"page"];
    WeakSelf
    [[AFHTTPSessionManager manager]GET:requestUrl parameters:self.params progress:nil
      success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
          [responseObject writeToFile:@"/Users/HqLee/Desktop/tiezi.plist" atomically:YES];
//          weakSelf.tableView.header.hidden = YES;
          NSArray *newTopics = [LHQTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
//          LHQLog(@"%@",responseObject);
          weakSelf.maxTime = [responseObject[@"info"][@"maxtime"] integerValue];
          weakSelf.count = [responseObject[@"info"][@"count"] integerValue];
          weakSelf.page = 1;
          [weakSelf.topics removeAllObjects];
          [weakSelf.topics addObjectsFromArray:newTopics];
          [weakSelf.tableView.header endRefreshing];
          
          [weakSelf.tableView reloadData];
          
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
//        weakSelf.tableView.header.hidden = YES;
        [weakSelf.tableView.header endRefreshing];
        [SVProgressHUD showErrorWithStatus:@"数据加载失败"];
    }];
    
}

- (void)loadMoreData{
    
    [self.params setObject:@(self.maxTime) forKey:@"maxtime"];
    [self.params setObject:@(self.page) forKey:@"page"];
    WeakSelf
    [[AFHTTPSessionManager manager]GET:requestUrl parameters:self.params progress:nil
      success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
          NSArray *newTopics = [LHQTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
          weakSelf.maxTime = [responseObject[@"info"][@"maxtime"] integerValue];
          weakSelf.count = [responseObject[@"info"][@"count"] integerValue];
          weakSelf.page +=1;
          if (weakSelf.count == newTopics.count) {//说明数据加载完了
              [weakSelf.tableView.footer noticeNoMoreData];
              return ;
          }
          [weakSelf.topics addObjectsFromArray:newTopics];
          [weakSelf.tableView.footer endRefreshing];
          
          [weakSelf.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
          [weakSelf.tableView.footer endRefreshing];
          [SVProgressHUD showErrorWithStatus:@"数据加载失败"];
    }];
    
}

- (void)firstRefresh{
    
    LHQLog(@"%@",self.params);
    [self.tableView.header beginRefreshing];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    self.tableView.footer.hidden = (self.topics.count == 0);
    return self.topics.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LHQBaseTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    
    cell.topic = self.topics[indexPath.row];
    
    return cell;
}

#pragma mark --- table view delegate ---
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
 
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LHQTopic *topic = self.topics[indexPath.row];

    return topic.cellHeight;
}

@end
