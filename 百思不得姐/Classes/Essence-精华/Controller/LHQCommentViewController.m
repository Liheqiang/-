//
//  LHQCommentViewController.m
//  百思不得姐
//
//  Created by HqLee on 16/3/3.
//  Copyright © 2016年 HqLee. All rights reserved.
//

#import "LHQCommentViewController.h"
#import <MJRefresh.h>
#import <AFNetworking.h>
#import <UIImageView+WebCache.h>
#import "LHQBaseTopicCell.h"
#import "LHQTopic.h"

static NSString *const cellId = @"cell";
static NSString *const headerViewId = @"header";
static NSInteger const headerViewLabelTag = 99;
@interface LHQCommentViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *toolbarBottom;
@end

@implementation LHQCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableHeaderView];
    [self setupTableView];
    [self registerNotification];
}

#pragma -
#pragma private method ---
- (void)setupTableHeaderView{
    UIView *headerView = [[UIView alloc] init];
    LHQBaseTopicCell *topicCell = [LHQBaseTopicCell cell];
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
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellId];
    
    //添加头部刷新控件
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.tableView.mj_footer = [MJRefreshBackFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}

- (void)registerNotification{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardFrameChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)loadNewData{
    
    
    
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


#pragma -
#pragma uitable view datasource ---
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    return cell;
}
#pragma -
#pragma uitable view delegate ---
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
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
    if (section == 0) {
        label.text = @"最热评论";
    }else{
        label.text = @"最新评论";
    }

    return headerView;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}
@end
