//
//  LHQCommentViewController.m
//  百思不得姐
//
//  Created by HqLee on 16/3/3.
//  Copyright © 2016年 HqLee. All rights reserved.
//  采用自动计算高度，只适用iOS8 之后

#import "LHQCommentViewController.h"
#import <MJRefresh.h>
#import <SVProgressHUD.h>
#import <AFNetworking.h>
#import <UIImageView+WebCache.h>
#import "LHQBaseTopicCell.h"
#import "LHQTopic.h"
#import "LHQUser.h"
#import <MJExtension.h>
#import "LHQTopicComment.h"
#import "LHQCommentCell.h"

static NSString *const cellId = @"comment";
static NSString *const headerViewId = @"header";
static NSInteger const headerViewLabelTag = 99;
@interface LHQCommentViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *toolbarBottom;
@property (nonatomic, strong) NSArray *save_top_cmt;
@property (nonatomic, strong) NSArray *hotComments;
@property (nonatomic, strong) NSMutableArray *latestComments;
@end

@implementation LHQCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableHeaderView];
    [self setupTableView];
    [self registerNotification];
    [self beginRefresh];
}

#pragma -
#pragma private method ---
- (void)setupTableHeaderView{
    UIView *headerView = [[UIView alloc] init];
    LHQBaseTopicCell *topicCell = [LHQBaseTopicCell cell];
    self.save_top_cmt = self.topic.top_cmt;
    [self.topic setValue:@(0) forKey:@"cellHeight"];
    self.topic.top_cmt = nil;
    [headerView addSubview:topicCell];
    topicCell.topic = self.topic;
    topicCell.frame = CGRectMake(0, 0, kScreenWidth, self.topic.cellHeight);
    
    headerView.height = self.topic.cellHeight + LHQTopicCellMargin;
    self.tableView.tableHeaderView = headerView;
}

- (void)setupTableView{
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = LHQGlobalBg;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LHQCommentCell class]) bundle:nil] forCellReuseIdentifier:cellId];
    //自动计算高度
    self.tableView.estimatedRowHeight = 44;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    //添加头部刷新控件
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.tableView.mj_footer = [MJRefreshBackFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}

- (void)registerNotification{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardFrameChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)beginRefresh{
    [self.tableView.mj_header beginRefreshing];
}

- (void)loadNewData{
    
    
    WeakSelf
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"hot"] = @"1";
    params[@"data_id"] = self.topic.Id;
    [[AFHTTPSessionManager manager]GET:requestUrl parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        weakSelf.hotComments = [LHQTopicComment mj_objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        weakSelf.latestComments = [LHQTopicComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [weakSelf.tableView reloadData];
        [weakSelf.tableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"加载数据失败"];
        [weakSelf.tableView.mj_header endRefreshing];
    }];
    
}

- (void)loadMoreData{
    
}

#pragma - 
#pragma mark - notification event
- (void)keyboardFrameChange:(NSNotification *)noti{
    
    CGRect frame = [noti.userInfo[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
    double duration = [noti.userInfo[@"UIKeyboardAnimationDurationUserInfoKey"]doubleValue];

    self.toolbarBottom.constant = kScreenHeight - frame.origin.y;
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
    
}

- (void)dealloc{
    self.topic.top_cmt = self.save_top_cmt;
    [self.topic setValue:@(0) forKey:@"cellHeight"];
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


#pragma -
#pragma uitable view datasource ---
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if (self.hotComments.count != 0) {//如果有热门评论 那么一定有最新评论
        return 2;
    }else{
        if (self.latestComments.count != 0) {//如果没有热门评论，不一定有最新评论
            return 1;
        }
        else return 0;
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.hotComments.count != 0) {//如果有热门评论 那么一定有最新评论
        if (section == 0){
            return self.hotComments.count;
        }else{
            return self.latestComments.count;
        }
    }else{
        if (self.latestComments.count != 0) {//如果没有热门评论，不一定有最新评论
            return self.latestComments.count;
        }
        else return 0;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LHQCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    LHQTopicComment *comment = [self commentInIndexPath:indexPath];
    cell.comment = comment;
    return cell;
}
#pragma -
#pragma uitable view delegate ---
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LHQCommentCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    //弹出菜单控制器
    [cell becomeFirstResponder];
    UIMenuController *menu = [UIMenuController sharedMenuController];
    if (menu.isMenuVisible) {
        [menu setMenuVisible:NO animated:YES];
        return;
    }
    UIMenuItem *like = [[UIMenuItem alloc] initWithTitle:@"顶" action:@selector(like:)];
    UIMenuItem *reply = [[UIMenuItem alloc] initWithTitle:@"回复" action:@selector(reply:)];
    UIMenuItem *report = [[UIMenuItem alloc] initWithTitle:@"举报" action:@selector(report:)];
    menu.menuItems = @[like,reply,report];
    
    CGRect showRect = CGRectMake(0, cell.height * 0.5, cell.width, cell.height * 0.5);
    [menu setTargetRect:showRect inView:cell];
    [menu setMenuVisible:YES animated:YES];
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerViewId];
    if (headerView == nil) {
        
        headerView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:headerViewId];
        UILabel *label = [[UILabel alloc] init];
        [headerView addSubview:label];
        label.x = LHQTopicCellMargin;
        label.size = headerView.size;
        label.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;//随着父控件的宽高变化
        label.tag = headerViewLabelTag;
    }
    
    UILabel * label = (UILabel *)[headerView viewWithTag:headerViewLabelTag];
    if (self.hotComments.count != 0) {//如果有热门评论 那么一定有最新评论
        if (section == 0){
            label.text = @"最热评论";
        }else{
            label.text = @"最新评论";
        }
    }else{
        if (self.latestComments.count != 0) {//如果没有热门评论，不一定有最新评论
            label.text = @"最新评论";
        }
        else label.text = nil;
    }

    return headerView;
}

- (NSArray *)commentInSection:(NSInteger)section{
    if (section == 0) {
        return self.hotComments.count ? self.hotComments : self.latestComments;
    }else
        return self.latestComments;
}

- (LHQTopicComment *)commentInIndexPath:(NSIndexPath *)indexPath{
    return [self commentInSection:indexPath.section][indexPath.row];
}

#pragma mark --- event response ---
- (void)like:(UIMenuController *)menu{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    LHQTopicComment *comment = [self commentInIndexPath:indexPath];
    
    LHQLog(@"%@:like %@",comment.user.username,comment.content);
}

- (void)reply:(UIMenuController *)menu{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    LHQTopicComment *comment = [self commentInIndexPath:indexPath];
    
    LHQLog(@"%@:reply %@",comment.user.username,comment.content);
    
}

- (void)report:(UIMenuController *)menu{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    LHQTopicComment *comment = [self commentInIndexPath:indexPath];
    
    LHQLog(@"%@:reply %@",comment.user.username,comment.content);
}


#pragma -
#pragma mark - ScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}
@end
