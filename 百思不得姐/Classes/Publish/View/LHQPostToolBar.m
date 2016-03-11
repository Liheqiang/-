//
//  LHQPostToolBar.m
//  百思不得姐
//
//  Created by HqLee on 16/3/11.
//  Copyright © 2016年 HqLee. All rights reserved.
//

//    通过控制器的presentedViewController可以获取弹出控制器对象
//    [a presentViewController:b animated:YES completion:nil];
//    a.presentedViewController - > b
//    b.presentedViewController -> a;

#import "LHQPostToolBar.h"
#import "LHQNavigationController.h"
#import "LHQAddTagViewController.h"

@interface LHQPostToolBar()
@property (weak, nonatomic) IBOutlet UIView *tagView;
@property (nonatomic, weak) UIButton *addButton;
@end
@implementation LHQPostToolBar
#pragma -
#pragma mark -
- (void)awakeFromNib{
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [addButton setImage:[UIImage imageNamed:@"tag_add_icon"] forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
    addButton.size = addButton.currentImage.size;
    [self addSubview:addButton];
    self.addButton = addButton;
}
#pragma - 
#pragma mark -
- (void)addButtonClick{
    UIViewController *root = [UIApplication sharedApplication].keyWindow.rootViewController;
    LHQNavigationController *navi = (LHQNavigationController *)root.presentedViewController;
    LHQAddTagViewController *tagVc = [[LHQAddTagViewController alloc] init];
    [navi pushViewController:tagVc animated:YES];
}
@end
