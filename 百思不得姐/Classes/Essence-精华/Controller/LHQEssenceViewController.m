//
//  LHQEssenceViewController.m
//  百思不得姐
//
//  Created by HqLee on 16/2/13.
//  Copyright © 2016年 HqLee. All rights reserved.
//

#import "LHQEssenceViewController.h"
#import "LHQRecommandTagsViewController.h"
/**
 * 子控制器
 */
#import "LHQAllViewController.h"
#import "LHQVideoViewController.h"
#import "LHQVoiceViewController.h"
#import "LHQPictureViewController.h"
#import "LHQWordViewController.h"

//static NSInteger const titleViewSubViewsCount = 5;

@interface LHQEssenceViewController ()<UIScrollViewDelegate>

@property (nonatomic, weak) UIButton *seletedButton;
@property (nonatomic, weak) UIView *indicator;
@property (nonatomic, weak) UIView *titleView;
@property (nonatomic, weak) UIScrollView *contentView;

@property (nonatomic, strong) NSMutableArray *buttones;

@end

@implementation LHQEssenceViewController
- (NSString *)a{return @"list";};
#pragma --- lazy load ---
- (NSMutableArray *)buttones{
    if (!_buttones) {
        _buttones = [NSMutableArray array];
    }
    return _buttones;
}

#pragma mark --- life cycle ---
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavi];//设置导航栏
    
    [self setupChildViewController];//添加子控制器
    
    [self setupTitleView];//添加标题视图
    
    [self setupContentView];//添加内容视图
    
}
#pragma mark --- private method---
- (void)setupNavi{
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highlightedImage:@"MainTagSubIconClick" target:self action:@selector(mainTagClick)];
    
    self.view.backgroundColor = LHQGlobalBg;
}

- (void)setupChildViewController{
    
    LHQAllViewController *allVc = [[LHQAllViewController alloc] initWithStyle:UITableViewStylePlain];
    allVc.title = @"全部";
    [self addChildViewController:allVc];
    
    LHQVideoViewController *videoVc = [[LHQVideoViewController alloc] initWithStyle:UITableViewStylePlain];
    videoVc.title = @"视频";
    [self addChildViewController:videoVc];
    
    LHQVoiceViewController *voiceVc = [[LHQVoiceViewController alloc] initWithStyle:UITableViewStylePlain];
    voiceVc.title = @"声音";
    [self addChildViewController:voiceVc];
    
    LHQPictureViewController *pictureVc = [[LHQPictureViewController alloc] initWithStyle:UITableViewStylePlain];
    pictureVc.title = @"图片";
    [self addChildViewController:pictureVc];
    
    LHQWordViewController *wordVc = [[LHQWordViewController alloc] initWithStyle:UITableViewStylePlain];
    wordVc.title = @"段子";
    [self addChildViewController:wordVc];
}

- (void)setupTitleView{
    
    //创建titleView
    UIView *titleView = [[UIView alloc] init];
    titleView.x = 0;
    titleView.y = navigationBarHeight;
    titleView.width = self.view.width;
    titleView.height = titleViewHeight;
    
    //设置titleView为半透明白色  不要直接设置其alpha，否则会影响其内部子控件的颜色
//    titleView.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.6];
//    titleView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.6];
    titleView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.6];
    
    [self.view addSubview:titleView];
    self.titleView = titleView;
    //添加底部指示器
    UIView *indicator = [[UIView alloc] init];
    indicator.x = 0;
    indicator.height = 1;
    indicator.width = 0;//暂时为零，根据按钮文字宽度决定
    indicator.y = titleView.height - indicator.height;
    indicator.backgroundColor = [UIColor redColor];
    [titleView addSubview:indicator];
    self.indicator = indicator;
    
    //添加按钮子控件
    NSInteger count = self.childViewControllers.count;
    
    CGFloat buttonX = 0;
    CGFloat buttonY = 0;
    CGFloat buttonW = self.view.width / count;
    CGFloat buttonH = titleView.height - indicator.height;
    for (NSInteger i = 0; i < count; i++ ) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonX = i *buttonW;
        button.tag = i;
        [button setTitle:self.childViewControllers[i].title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        [self.buttones addObject:button];
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        [button addTarget:self action:@selector(buttonDidClick:) forControlEvents:UIControlEventTouchUpInside];
        [titleView addSubview:button];
        
//        if (i == 0) {//第一次默认选中第一个按钮 但是这样写指示器却无法显示出来，原因？ 因为指示器宽度是用按钮的文字的宽度来确认
//            [button layoutIfNeeded];//加上这句话，强制按钮内部布局，这样就有文字宽度
//            [self buttonDidClick:button];
//        }
        
        if (i == 0){ //解决指示器的宽度方法很多，要灵活多用...
            [button.titleLabel sizeToFit];//为了让选中时指示器的宽度有
            [self buttonDidClick:button];
        }
        
        
    }
}

- (void)setupContentView{
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *contentView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    contentView.delegate = self;
    [self.view insertSubview:contentView atIndex:0];//因为是后添加的，所以遮盖titleView
    //设置分页模式
    contentView.pagingEnabled = YES;
    //不现实横向滚动条
    contentView.showsHorizontalScrollIndicator = NO;
    //设置其滚动区域
    contentView.contentSize = CGSizeMake(contentView.width * self.childViewControllers.count, 0);
    contentView.scrollEnabled = YES;
    self.contentView = contentView;
    [self scrollViewDidEndScrollingAnimation:self.contentView];
    //加载第一个子控制器的视图  得重复设置许多属性
//    UITableViewController *tableViewVc = self.childViewControllers[0];
//    tableViewVc.tableView.contentInset = UIEdgeInsetsMake(CGRectGetMaxY(self.titleView.frame), 0, self.tabBarController.tabBar.height, 0);
//    [self.contentView addSubview:tableViewVc.tableView];
}


#pragma mark --- event response ---
/**
 *  设置按钮的seleted属性来切换文字选中的颜色变化可以的，但是如果点击选中的按钮，会出现高亮的效果，这样不好，如果要去掉高亮效果，可以自定义按钮，去掉高亮效果，或者设置按钮的disable属性来切换文字选中的颜色,这样就可以避免重复点击点记选中按钮变高亮状态
 */
- (void)buttonDidClick:(UIButton *)button{
    
    self.seletedButton.enabled = YES;
    button.enabled = NO;
    self.seletedButton = button;
    
    [UIView animateWithDuration:0.25 animations:^{
       
        self.indicator.width = button.titleLabel.width;//让指示器的宽度等于按钮文字宽度
        self.indicator.centerX = button.centerX;
        
    }];
    
    //点击按钮，视图滚到对应区域 第一次添加到子视图
    CGFloat x = button.tag * self.contentView.width;
    CGPoint offset = CGPointMake(x, 0);
    [self.contentView setContentOffset:offset animated:YES];
    
}

- (void)mainTagClick{
    
    LHQRecommandTagsViewController *vc = [[LHQRecommandTagsViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark --- UIScrollViewDelegate ---
//滚动动画结束时会调用
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
    CGPoint offset = scrollView.contentOffset;
    NSInteger index = offset.x / self.contentView.width;
    UITableViewController *tableViewVc = self.childViewControllers[index];
    if (tableViewVc.isViewLoaded) { //避免多次加载
        return;
    }
    
//    //这个属性非常重要 在这里设置没用，在view Didload中被改回来了
//    tableViewVc.tableView.contentInset = UIEdgeInsetsMake(navigationBarHeight + titleViewHeight, 0, self.tabBarController.tabBar.height, 0);
//    //让滚动条的内边距也要和当前视图一样
//    tableViewVc.tableView.scrollIndicatorInsets = tableViewVc.tableView.contentInset;//最初设置的是scrollView的，难怪没反应,让滚动视图的指示器也从下面开始
    
    UITableView *tableView = tableViewVc.tableView;
    tableView.x = index * self.contentView.width;
    tableView.y = 0;//设置为0(默认为20)这不是状态栏的高度嘛 ios5，6以前view高度没有状态栏
    tableView.height = scrollView.height;//设置tableView的高度是整个屏幕高度，ios5,6以前是比屏幕少20
    [self.contentView addSubview:tableView];

}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    [self scrollViewDidEndScrollingAnimation:scrollView];//拖拽的时候也会滑动
    
    //让按钮也跟着着内容变化
    CGPoint offset = scrollView.contentOffset;
    NSInteger index = offset.x / self.contentView.width;
    
    UIButton *selectedButton = self.buttones[index];
    
    [self buttonDidClick:selectedButton];
}
@end
