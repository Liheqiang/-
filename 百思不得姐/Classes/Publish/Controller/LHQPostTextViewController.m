//
//  LHQPostTextViewController.m
//  百思不得姐
//
//  Created by HqLee on 16/3/10.
//  Copyright © 2016年 HqLee. All rights reserved.
//

#import "LHQPostTextViewController.h"
#import "LHQNavigationController.h"
#import "LHQPlaceholderTextView.h"
#import "LHQPostToolBar.h"

@interface LHQPostTextViewController ()<UITextViewDelegate>
@property (nonatomic, strong) LHQPlaceholderTextView *textView;
@property (nonatomic, weak) LHQPostToolBar *toolBar;
@end

@implementation LHQPostTextViewController
#pragma -
#pragma mark - life cycle -
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavi];
    [self setupTextView];
    [self setupToolBar];
    [self registerObserver];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.textView becomeFirstResponder];
}

- (void)setupNavi{
    
    self.title = @"发布文字";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancle)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"发布" style:UIBarButtonItemStyleDone target:self action:@selector(post)];
    self.navigationItem.rightBarButtonItem.enabled = NO;

}

- (void)setupTextView{
    LHQPlaceholderTextView *textView = [[LHQPlaceholderTextView alloc] init];
    textView.placeholder = @"把好玩的图片，好笑的段子或糗事发到这里，接受千万网友膜拜吧！发布违反国家法律内容的，我们将依法提交给有关部门处理。";
    textView.font = [UIFont systemFontOfSize:13];
    textView.frame = self.view.bounds;
    textView.delegate = self;
    [self.view addSubview:textView];
    self.textView = textView;
}
- (void)setupToolBar{
    LHQPostToolBar *toolBar = [LHQPostToolBar viewLoadFromXib];
    toolBar.y = self.view.height - toolBar.height;
    [self.view addSubview:toolBar];
    self.toolBar = toolBar;
}

- (void)registerObserver{
    [LHQNotificationCenter addObserver:self selector:@selector(keyboardFrameChanged:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)keyboardFrameChanged:(NSNotification *)noti{
    
    CGRect keyboardFrame = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGFloat duration = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:duration animations:^{
        self.toolBar.transform = CGAffineTransformMakeTranslation(0, keyboardFrame.origin.y - kScreenHeight);
    }];
}

- (void)dealloc{
    [LHQNotificationCenter removeObserver:self];
}

#pragma -
#pragma mark -
- (void)cancle{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)post{
    
}

#pragma -
#pragma mark -
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}
@end
