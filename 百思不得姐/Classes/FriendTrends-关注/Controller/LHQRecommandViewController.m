//
//  LHQRecommandViewController.m
//  百思不得姐
//
//  Created by HqLee on 16/2/15.
//  Copyright © 2016年 HqLee. All rights reserved.
//

/**
 *  遇到问题，每次进行上拉刷新后，在点击其他分类标签，就不进行下拉刷新了？？？  搞了半天原来是少了268行的那句话,,,可是原因呢？？？
 */

#import "LHQRecommandViewController.h"
#import "LHQRecommandCategoryCell.h"
#import "LHQRecommandCategory.h"
#import "LHQRecommandUserCell.h"
#import "LHQRecommandUser.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import <MJExtension.h>
#import <MJRefresh.h>

#define selectedCategory self.categories[[self.categoryTableView indexPathForSelectedRow].row]

@interface LHQRecommandViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;
@property (weak, nonatomic) IBOutlet UITableView *userTableView;
@property (nonatomic, strong) NSArray *categories;
@property (nonatomic, strong) AFHTTPSessionManager *manager;
@property (nonatomic, strong) NSMutableDictionary *params;
@end

static NSString *const categoryCellId = @"category";
static NSString *const userCellId = @"user";

@implementation LHQRecommandViewController

- (AFHTTPSessionManager *)manager{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

#pragma mark --- life cycle ---
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //控件初始化
    [self setupView];
    //添加刷新控件
    [self setupRefresh];
    //加载左边类别数据
    [self refreshCategoryTableView];
}

#pragma mark --- private method ---
- (void)setupView{
    
    self.navigationItem.title = @"推荐关注";
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.categoryTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.categoryTableView.backgroundColor = LHQGlobalBg;
    [self.categoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([LHQRecommandCategoryCell class]) bundle:nil] forCellReuseIdentifier:categoryCellId];
    
    self.userTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.userTableView.backgroundColor = LHQGlobalBg;
    self.userTableView.rowHeight = 60;
    [self.userTableView registerNib:[UINib nibWithNibName:NSStringFromClass([LHQRecommandUserCell class]) bundle:nil] forCellReuseIdentifier:userCellId];
    
}

- (void)setupRefresh{
    
    [self.userTableView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    [self.userTableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    self.userTableView.footer.hidden = YES;
}

/**
 *  刷新右边标签
 */
- (void)refreshCategoryTableView{
    
    WeakSelf
    [SVProgressHUD showWithStatus:@"正在加载"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    [self.manager GET:requestUrl parameters:params progress:nil
              success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                  
                  
                  [SVProgressHUD dismiss];
                  
                  weakSelf.categories = [LHQRecommandCategory mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
                  
                  [weakSelf.categoryTableView reloadData];
                  
                  // 默认选中首行
                  [weakSelf.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
                  
                  //让用户表格进入下拉刷新状态
                  [weakSelf.userTableView.header beginRefreshing];//刷新
                  
                  
                  LHQLog(@"%@",responseObject);
                  
              } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                  
                  [SVProgressHUD showErrorWithStatus:@"加载失败"];
                  
              }];
}


- (void)loadNewData{
    
    WeakSelf
    LHQRecommandCategory *category = selectedCategory;
    
    category.currentPage = 1;//下拉刷新页码置1

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(category.id);
    params[@"page"] = @(category.currentPage);
    self.params = params; //这一步很重要，避免重复发送请求，导致最后数据出错
    [self.manager GET:requestUrl parameters:params progress:nil
        success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
//            if (weakSelf.params != params)return; 放弃之前成功的操作
                
            NSArray *users = [LHQRecommandUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
            
            [category.users removeAllObjects]; //下拉刷新清除原来的数据，避免添加新数据
            [category.users addObjectsFromArray:users];
                
            category.total = [responseObject[@"total"] integerValue];
            
            if (weakSelf.params != params)return;//可以节约流量
            
            //刷新右边表格
            [weakSelf.userTableView reloadData];
            
            //结束刷新
            [weakSelf.userTableView.header endRefreshing];
            
            //让底部控件结束刷新
            [weakSelf checkFooterState];
            
            LHQLog(@"%@",responseObject);
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            if (weakSelf.params != params) return ;
            
            [SVProgressHUD showErrorWithStatus:@"加载失败"];
            [weakSelf.userTableView.header endRefreshing];
        
        }];

    
}

- (void)loadMoreData{
    
    WeakSelf
    LHQRecommandCategory *category = selectedCategory;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(category.id);
    params[@"page"] = @(++ category.currentPage);
    self.params = params;
    [self.manager GET:requestUrl parameters:params progress:nil
        success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
//            if (weakSelf.params != params)return ;
            NSArray *users = [LHQRecommandUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
            
            //追加到原来的数组中
            [category.users addObjectsFromArray:users];
            
            //不是最后一次请求，就不执行刷新操作
            if (weakSelf.params != params)return ;
            
            //刷新右边表格
            [weakSelf.userTableView reloadData];
            
            //让底部控件结束刷新
            [weakSelf checkFooterState];
            
            LHQLog(@"%@",responseObject);
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            if (weakSelf.params != params)return;
            
            [SVProgressHUD showErrorWithStatus:@"加载失败"];
            
            [weakSelf.userTableView.footer endRefreshing];
                                    
        }];
}

- (void)checkFooterState{
    
    LHQRecommandCategory *category = selectedCategory;
    
    self.userTableView.footer.hidden = (category.users.count == 0);
    
    if (category.users.count == category.total) {
        //提醒没有更多数据
        [self.userTableView.footer noticeNoMoreData];
    }else{
        //显示footer的状态为还可以上拉加载
        [self.userTableView.footer endRefreshing];
    }
    
}


#pragma mark --- UITableViewDelegate UITableDataSource ---
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (tableView == self.categoryTableView){
        
        return self.categories.count;
    }else{
        [self checkFooterState];//非常关键，避免点击标签之间的footer的状态会互相影响 这就是不同的数据源使用同一个tableView会带来许许多多的麻烦的逻辑
        return [selectedCategory users].count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == self.categoryTableView) {
        
        LHQRecommandCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:categoryCellId];
        cell.category = self.categories[indexPath.row];
        return cell;
    }else{
        
        LHQRecommandCategory *category = selectedCategory;
        LHQRecommandUserCell *cell = [tableView dequeueReusableCellWithIdentifier:userCellId];
        cell.user = category.users[indexPath.row];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.userTableView.header endRefreshing];
    [self.userTableView.footer endRefreshing];
    
    if (tableView == self.categoryTableView) {
        
        LHQRecommandCategory *category = self.categories[indexPath.row];
        
        if (category.users.count > 0) {
            
            [self.userTableView reloadData];//如果有数据直接刷新列表
        }else{
            
            // 赶紧刷新表格,目的是: 马上显示当前category的用户数据, 不让用户看见上一个category的残留数据
            [self.userTableView reloadData]; 
            
            [self.userTableView.header beginRefreshing];
            
        }
    }
}

- (void)dealloc{
    
    [self.manager.operationQueue cancelAllOperations];//控制器销毁，停止所有任务
}
@end
