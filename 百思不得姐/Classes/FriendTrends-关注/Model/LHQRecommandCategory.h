//
//  LHQRecommandCategory.h
//  百思不得姐
//
//  Created by HqLee on 16/2/15.
//  Copyright © 2016年 HqLee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LHQRecommandCategory : NSObject

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) NSInteger count;

@property (nonatomic, assign) NSInteger total;

@property (nonatomic, strong) NSMutableArray *users;

@property (nonatomic, assign) NSInteger currentPage;
@end
