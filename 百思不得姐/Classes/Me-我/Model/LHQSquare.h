//
//  LHQSquare.h
//  百思不得姐
//
//  Created by HqLee on 16/3/9.
//  Copyright © 2016年 HqLee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LHQSquare : NSObject
/** 方格子的名字 */
@property (nonatomic, copy) NSString *name;
/** 方格子图标的链接 */
@property (nonatomic, copy) NSString *icon;
/** 点击方格子对应的链接 */
@property (nonatomic, copy) NSString *url;
@end
