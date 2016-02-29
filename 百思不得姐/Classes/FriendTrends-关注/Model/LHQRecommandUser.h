//
//  LHQRecommandUser.h
//  百思不得姐
//
//  Created by HqLee on 16/2/15.
//  Copyright © 2016年 HqLee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LHQRecommandUser : NSObject

/**
 *  粉丝数
 */
@property (nonatomic, assign) NSInteger fans_count;
/**
 *  性别
 */
@property (nonatomic, assign) NSInteger gender;
/**
 *  头像url
 */
@property (nonatomic, copy) NSString *header;

/**
 *  是否为会员
 */
@property (nonatomic, assign) NSInteger is_vip;
/**
 *  姓名
 */
@property (nonatomic, copy) NSString *screen_name;
@end
