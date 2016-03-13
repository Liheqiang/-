//
//  LHQAddTagViewController.m
//  百思不得姐
//
//  Created by HqLee on 16/3/11.
//  Copyright © 2016年 HqLee. All rights reserved.
//

#import "LHQAddTagViewController.h"
#import "LHQTagTextField.h"
#import "LHQTagButton.h"

static CGFloat const addButtonHeight = 30.0f;

@interface LHQAddTagViewController ()<UITextFieldDelegate>
@property (nonatomic, weak) UIView *contentView;
@property (nonatomic, weak) LHQTagTextField *textField;
@property (nonatomic, weak) UIButton *addButton;
@property (nonatomic, strong) NSMutableArray *tagButtons;
@end

@implementation LHQAddTagViewController
#pragma -
#pragma mark - lazy load
- (UIButton *)addButton{
    if (!_addButton) {
        UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        addButton.titleLabel.font = [UIFont systemFontOfSize:14];
        addButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [addButton addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
        addButton.width = self.view.width;
        addButton.height = addButtonHeight;
        addButton.backgroundColor = LHQRGB(137, 218, 250);
        [self.contentView addSubview:addButton];
        _addButton = addButton;
    }
    return _addButton;
}

- (NSMutableArray *)tagButtons{
    if (!_tagButtons) {
        _tagButtons = [NSMutableArray array];
    }
    return _tagButtons;
}
#pragma -
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavi];
    [self setupContentView];
    [self setupTextField];
}
#pragma -
#pragma mark - 初始化
- (void)setupNavi{
    self.title = @"添加标签";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(done)];
}

- (void)done{
    
    NSMutableArray *tags = [NSMutableArray array];
    for (LHQTagButton *tagButton in self.tagButtons) {
        [tags addObject:tagButton.currentTitle];
    }
    !self.tagsBlock ? :self.tagsBlock(tags);
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)setupContentView{
    UIView *contentView = [[UIView alloc] init];
    contentView.x = LHQTagMargin;
    contentView.width = self.view.width - 2 * contentView.x;
    contentView.y = 64 + LHQTagMargin;
    contentView.height = self.view.height - contentView.y - LHQTagMargin;
    [self.view addSubview:contentView];
    self.contentView = contentView;
}

- (void)setupTextField{
    LHQTagTextField *textField = [[LHQTagTextField alloc] init];
    [textField addTarget:self action:@selector(textDidChange:) forControlEvents:UIControlEventEditingChanged];
    textField.placeholder = @"多个标签用逗号或者换行隔开";
    [textField setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [textField sizeToFit];
    textField.delegate = self;
    [textField becomeFirstResponder];
    textField.x = LHQTagMargin;
    textField.y  =LHQTagMargin;
    
    __weak typeof(self) weakSelf = self;
    textField.deleteBlock = ^{
        if (!weakSelf.textField.hasText) {
            LHQTagButton *lastTagButton = [weakSelf.tagButtons lastObject];
            
            [weakSelf tagButtonClick:lastTagButton];
        }
    };
    textField.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:textField];
    self.textField = textField;
    
    //设置默认标签
    for (NSString *tagTitle in self.tags) {
        textField.text = tagTitle;
        [self addButtonClick];
    }
}

- (void)textDidChange:(UITextField *)textField{
    
    if (textField.hasText) {//输入文本框有值
        self.addButton.hidden = NO;
        NSString *text = [NSString stringWithFormat:@"添加标签：%@",textField.text];
        [self.addButton setTitle:text forState:UIControlStateNormal];
        self.addButton.y = CGRectGetMaxY(textField.frame) + LHQTagMargin;
        
        text = textField.text;
        NSUInteger length = textField.text.length - 1;
        
        NSString *lastCharacter = [text substringFromIndex:length];
        if (([lastCharacter isEqualToString:@","] || [lastCharacter isEqualToString:@"，"]) && length > 1) {
            
            textField.text = [text substringToIndex:length];
            [self addButtonClick];
        }
        
    }
    else{
        self.addButton.hidden = YES;
        
    }
    
    [self updateTextFieldFrame];
    
}

- (void)dealloc{
    
}

#pragma -
#pragma mark - event response
- (void)addButtonClick{
    
    if (!self.textField.hasText)return;
    
    LHQTagButton *tagButton = [LHQTagButton buttonWithType:UIButtonTypeCustom];
    [tagButton setTitle:self.textField.text forState:UIControlStateNormal];
    [tagButton addTarget:self action:@selector(tagButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    tagButton.height = self.textField.height;
    [self.contentView addSubview:tagButton];
    [self.tagButtons addObject:tagButton];
    
    WeakSelf
    //更新子控件的frame
    [UIView animateWithDuration:0.25 animations:^{
        [weakSelf updateTagButtonFrame];
        [weakSelf updateTextFieldFrame];
    }];
    
    //隐藏添加按钮
    self.addButton.hidden = YES;
    //清空文本输入框
    self.textField.text = nil;
    
    
}

- (void)tagButtonClick:(LHQTagButton *)tagButton{
    
    [tagButton removeFromSuperview];
    [self.tagButtons removeObject:tagButton];
    
    WeakSelf
    //更新子控件的frame
    [weakSelf updateTagButtonFrame];
    [weakSelf updateTextFieldFrame];
}

#pragma -
#pragma mark - 更新标签按钮frame
- (void)updateTagButtonFrame{
    for (NSInteger i = 0; i < self.tagButtons.count; i ++) {
        LHQTagButton *tagButton = self.tagButtons[i];
        if (i == 0) {//第一个按钮永远排在第一排的第一列
            tagButton.x = 0;
            tagButton.y = 0;
        }else{
            //取出最后一个按钮的上一个按钮
            UIButton *lastTagButton = self.tagButtons[i - 1];
            //左边的宽度
            CGFloat leftWidth = CGRectGetMaxX(lastTagButton.frame) + LHQTagMargin;
            //右边的宽度
            CGFloat rightWidth = self.contentView.width - leftWidth;
            if (rightWidth > (tagButton.width + LHQTagMargin)) {
                tagButton.x = leftWidth;
                tagButton.y = lastTagButton.y;
            }else{
                tagButton.x = 0;
                tagButton.y = CGRectGetMaxY(lastTagButton.frame) + LHQTagMargin;
            }
        }
    }
}
#pragma -
#pragma mark - 更新文本输入框frame
- (void)updateTextFieldFrame{
    
    //最后一个按钮
    LHQTagButton *lastTagButton = [self.tagButtons lastObject];
    //左边的宽度
    CGFloat leftWidth = CGRectGetMaxX(lastTagButton.frame) + LHQTagMargin;
    //右边的宽度
    CGFloat rightWidth = self.contentView.width - leftWidth;
    
    if(rightWidth > [self textFieldTextWidth]){
        self.textField.x = CGRectGetMaxX(lastTagButton.frame) + LHQTagMargin;
        self.textField.y = lastTagButton.y;
    }else{
        self.textField.x = 0;
        self.textField.y = CGRectGetMaxY(lastTagButton.frame) + LHQTagMargin;
    }
    
}
#pragma -
#pragma mark - UITextField delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if (!textField.hasText)return NO;
    [self addButtonClick];
    return YES;
}

/**
 *  返回输入文字宽度
 */
- (CGFloat)textFieldTextWidth{
    
    CGFloat textW = [self.textField.text sizeWithAttributes:@{NSFontAttributeName:self.textField.font}].width;
    return MAX(100, textW);
}

@end
