//
//  LHQBaseTopicViewController.h
//  百思不得姐
//
//  Created by HqLee on 16/2/26.
//  Copyright © 2016年 HqLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LHQBaseTopicViewController : UITableViewController
//帖子类型
//@property (nonatomic, assign) LHQTopicType type;
- (LHQTopicType)type;
//请求的参数
@property (nonatomic, copy) NSString *a;
@end
