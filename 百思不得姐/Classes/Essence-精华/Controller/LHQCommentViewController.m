//
//  LHQCommentViewController.m
//  百思不得姐
//
//  Created by HqLee on 16/3/3.
//  Copyright © 2016年 HqLee. All rights reserved.
//

#import "LHQCommentViewController.h"
#import <MJRefresh.h>
#import <UIImageView+WebCache.h>
#import "LHQBaseTopicCell.h"
#import "LHQTopic.h"

static NSString *const cellId = @"cell";

@interface LHQCommentViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *toolbarBottom;
@end

@implementation LHQCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableHeaderView];
    [self setupTableView];
}

#pragma -
#pragma private method ---
- (void)setupTableHeaderView{
    UIView *headerView = [[UIView alloc] init];
    LHQBaseTopicCell *topicCell = [LHQBaseTopicCell cell];
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
//    self.tableView.header = [];
}


#pragma -
#pragma uitable view datasource ---
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 100;
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
    
}
@end
