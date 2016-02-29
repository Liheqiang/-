//
//  LHQLoginViewController.m
//  百思不得姐
//
//  Created by HqLee on 16/2/17.
//  Copyright © 2016年 HqLee. All rights reserved.
//

/**
 *  主要是xib的布局
 */
#import "LHQLoginViewController.h"

@interface LHQLoginViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *backgroudImageView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginViewLeadingConstant;


@end

@implementation LHQLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view insertSubview:self.backgroudImageView atIndex:0];
    
}
- (IBAction)showLoaginOrRegister:(id)sender {
    
    WeakSelf
    [self.view endEditing:YES];
    if(self.loginViewLeadingConstant.constant == 0){
        [sender setTitle:@"已有帐号?" forState:UIControlStateNormal];
        weakSelf.loginViewLeadingConstant.constant = - self.view.width;
    }else{
        [sender setTitle:@"注册账号" forState:UIControlStateNormal];
        weakSelf.loginViewLeadingConstant.constant = 0;

    }
    [UIView animateWithDuration:0.25 animations:^{
        [weakSelf.view layoutIfNeeded];//改变约束必须调用该方法，否则不管用
    }];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
}

- (IBAction)cancle:(id)sender {
    
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
@end
