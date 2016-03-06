//
//  LHQTopicComment.h
//  百思不得姐
//
//  Created by HqLee on 16/3/3.
//  Copyright © 2016年 HqLee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LHQUser.h"

@interface LHQTopicComment : NSObject

@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *ctime;
@property (nonatomic, assign) NSInteger like_count;
@property (nonatomic, strong) LHQUser *user;

@end
