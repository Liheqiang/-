//
//  LHQMeViewController.m
//  百思不得姐
//
//  Created by HqLee on 16/2/13.
//  Copyright © 2016年 HqLee. All rights reserved.
//

#import "LHQMeViewController.h"
#import "LHQMeFooterView.h"
#import "LHQMeCell.h"

static NSString *const meCellId = @"me";
@interface LHQMeViewController ()

@end

@implementation LHQMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavi];
    [self setupTableView];

}

- (void)setupNavi{
    self.navigationItem.title = @"我的";
    
    UIBarButtonItem *settingItem = [UIBarButtonItem itemWithImage:@"mine-setting-icon" highlightedImage:@"mine-setting-icon-click" target:self action:@selector(settingItemClick)];
    UIBarButtonItem *moonItem = [UIBarButtonItem itemWithImage:@"mine-moon-icon" highlightedImage:@"mine-moon-icon-click" target:self action:@selector(moonItemClick)];
    self.navigationItem.rightBarButtonItems = @[settingItem, moonItem];
    
}

- (void)setupTableView{
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[LHQMeCell class] forCellReuseIdentifier:meCellId];
    self.tableView.backgroundColor = LHQGlobalBg;
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);
    self.tableView.sectionFooterHeight = LHQTopicCellMargin;
    self.tableView.tableFooterView = [[LHQMeFooterView alloc] init];
}

//计算tableview的congtentSize
- (void)viewDidLayoutSubviews{
    
    [super viewDidLayoutSubviews];
    self.tableView.contentSize = CGSizeMake(0, CGRectGetMaxY(self.tableView.tableFooterView.frame));
}

#pragma -
#pragma mark -


#pragma -
#pragma mark - event response -
- (void)settingItemClick{
    
}

- (void)moonItemClick{
    
}

#pragma -
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
#pragma -
#pragma mark - UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LHQMeCell *cell = [tableView dequeueReusableCellWithIdentifier:meCellId];
    if (indexPath.section == 0) {
        cell.textLabel.text = @"登陆／注册";
        cell.imageView.image = [UIImage imageNamed:@"publish-audio"];
    }else{
        cell.textLabel.text = @"离线下载";
    }
    return cell;
}
@end
