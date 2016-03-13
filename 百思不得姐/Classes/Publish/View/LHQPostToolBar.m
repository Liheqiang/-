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
@property (nonatomic, strong) NSMutableArray *tagLabels;
@end
@implementation LHQPostToolBar
- (NSMutableArray *)tagLabels{
    if (!_tagLabels) {
        _tagLabels = [NSMutableArray array];
    }
    return _tagLabels;
}
#pragma -
#pragma mark -
- (void)awakeFromNib{
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [addButton setImage:[UIImage imageNamed:@"tag_add_icon"] forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
    addButton.size = addButton.currentImage.size;
    [self.tagView addSubview:addButton];
    self.addButton = addButton;
    
    //添加默认的标签
    [self createTagLabel:@[@"糗事",@"搞笑"]];
}
#pragma - 
#pragma mark -
- (void)addButtonClick{
    UIViewController *root = [UIApplication sharedApplication].keyWindow.rootViewController;
    LHQNavigationController *navi = (LHQNavigationController *)root.presentedViewController;
    LHQAddTagViewController *tagVc = [[LHQAddTagViewController alloc] init];
    tagVc.tags = @[@"糗事",@"搞笑"];
    __weak typeof(self) weakSelf = self;
    [tagVc setTagsBlock:^(NSArray * tags) {
        
        [weakSelf createTagLabel:tags];
    }];
    [navi pushViewController:tagVc animated:YES];
}

- (void)createTagLabel:(NSArray *)tags{
    
    [self.tagLabels makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.tagLabels removeAllObjects];
    
    for (NSInteger i = 0; i < tags.count; i ++) {
        NSString *tagTitle = tags[i];
        
        UILabel *tagLabel = [[UILabel alloc] init];
        [self.tagView addSubview:tagLabel];
        tagLabel.font = [UIFont systemFontOfSize:14];
        tagLabel.backgroundColor = LHQTagBg;
        tagLabel.textColor = [UIColor whiteColor];
        tagLabel.textAlignment = NSTextAlignmentCenter;
        tagLabel.text = tagTitle;
        [tagLabel sizeToFit];
        tagLabel.height = self.addButton.height;
        tagLabel.width = tagLabel.width + 2 * LHQTagMargin;
        [self.tagLabels addObject:tagLabel];
    }
    
    [self updateTagLabelFrame];
    
}

- (void)updateTagLabelFrame{
    
    for (NSInteger i = 0 ; i < self.tagLabels.count; i ++) {
        UILabel *tagLabel = self.tagLabels[i];
        
        if (i == 0) {
            tagLabel.x = 0;
            tagLabel.y = 0;
        }else{
            UILabel *lastTagLabel = self.tagLabels[i - 1];
            
            CGFloat leftWidth = CGRectGetMaxX(lastTagLabel.frame) + LHQTagMargin;
            CGFloat rightWidth = self.tagView.width - leftWidth - LHQTagMargin;
            
            if (rightWidth > tagLabel.width) {
                tagLabel.x = leftWidth;
                tagLabel.y = lastTagLabel.y;
            }else{
                tagLabel.x = 0;
                tagLabel.y = CGRectGetMaxY(lastTagLabel.frame) + LHQTagMargin;
            }
        }
    }
    
    [self updateAddButtonFrame];
}

- (void)updateAddButtonFrame{
    
    UILabel *lastTagLabel = [self.tagLabels lastObject];
    CGFloat leftWidth = CGRectGetMaxX(lastTagLabel.frame) + LHQTagMargin;
    CGFloat rightWidth = self.tagView.width - leftWidth;
    
    if (rightWidth > self.addButton.width) {
        self.addButton.x = leftWidth;
        self.addButton.y = lastTagLabel.y;
    }else{
        self.addButton.x = 0;
        self.addButton.y = CGRectGetMaxY(self.addButton.frame) + LHQTagMargin;
    }
    
    [self updateTagViewFrame];
}

- (void)updateTagViewFrame{
    
    self.tagView.height = CGRectGetMaxY(self.addButton.frame) + LHQTagMargin;
    CGFloat newHeight = self.tagView.height + 35;
    CGFloat deltaHeight = self.height - newHeight;
    self.height = newHeight;
    self.y += deltaHeight;
}
@end
