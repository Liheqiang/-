//
//  LHQRecommandTagsViewController.m
//  百思不得姐
//
//  Created by HqLee on 16/2/16.
//  Copyright © 2016年 HqLee. All rights reserved.
//

#import "LHQRecommandTagsViewController.h"
#import "LHQRecommandTag.h"
#import "LHQRecommandTagCell.h"
#import <MJExtension.h>
#import <MJRefresh.h>
#import <AFNetworking.h>
#import <SVProgressHUD.h>

@interface LHQRecommandTagsViewController ()

@property (nonatomic, strong) NSMutableArray *tags;

@property (nonatomic, assign) NSInteger page;

@end

static NSString *const tagCellId = @"tag";

@implementation LHQRecommandTagsViewController
#pragma mark --- lazy load ---
- (NSMutableArray *)tags{
    if (!_tags) {
        _tags = [NSMutableArray array];
    }
    return _tags;
}

#pragma mark --- life cycle ---

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化控件
    [self setupTableView];
    //添加刷新控件
    [self setupRefresh];
    //第一次自动进入下拉刷新
    [self refreshController];
    
}

#pragma mark --- private method ---
- (void)setupTableView{
    
    self.title = @"推荐标签";
    
    self.tableView.rowHeight = 60;
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LHQRecommandTagCell class]) bundle:nil] forCellReuseIdentifier:tagCellId];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.backgroundColor = LHQGlobalBg;
}

- (void)setupRefresh{
    
    
    //添加头部刷新控件
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    //添加尾部刷新控件
    self.tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
}

- (void)loadNewData{
    
    WeakSelf
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"page"] = @(1);
    params[@"a"] = @"tag_recommend";
    params[@"action"] = @"sub";
    params[@"c"] = @"topic";
    [[AFHTTPSessionManager manager] GET:requestUrl parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [weakSelf.tableView.header endRefreshing];//头部结束刷新
        
        [weakSelf.tableView.footer resetNoMoreData];
        
        weakSelf.page = 2;
        
        [weakSelf.tags removeAllObjects];
        
        NSArray *tags = [LHQRecommandTag mj_objectArrayWithKeyValuesArray:responseObject];
        
        [self.tags addObjectsFromArray:tags];
        
        [weakSelf.tableView reloadData];
        
        LHQLog(@"%@",responseObject);
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [weakSelf.tableView.header endRefreshing];
        [SVProgressHUD showErrorWithStatus:@"数据加载失败"];
        
    }];
    
}

- (void)loadMoreData{
    
    WeakSelf
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"page"] = @(self.page);
    params[@"a"] = @"tag_recommend";
    params[@"action"] = @"sub";
    params[@"c"] = @"topic";
    
    [[AFHTTPSessionManager manager] GET:requestUrl parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        weakSelf.page = weakSelf.page + 1;
        
        NSArray *tags = [LHQRecommandTag mj_objectArrayWithKeyValuesArray:responseObject];
        
        if (tags.count == 0) {
            [weakSelf.tableView.footer noticeNoMoreData];
        }else{
            [weakSelf.tableView.footer endRefreshing];
            [weakSelf.tags addObjectsFromArray:tags];
        }
        
        [weakSelf.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [weakSelf.tableView.footer endRefreshing];
        [SVProgressHUD showErrorWithStatus:@"数据加载失败"];
        
    }];
    
}

- (void)refreshController{
    
    [self.tableView.header beginRefreshing];
    
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    self.tableView.footer.hidden = (self.tags.count == 0);
    return self.tags.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LHQRecommandTagCell *cell = [tableView dequeueReusableCellWithIdentifier:tagCellId];
    
    cell.recommandTag = self.tags[indexPath.row];
    
    return cell;
}

@end
