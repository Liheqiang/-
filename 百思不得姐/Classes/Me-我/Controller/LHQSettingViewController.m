//
//  LHQSettingViewController.m
//  百思不得姐
//
//  Created by HqLee on 16/3/13.
//  Copyright © 2016年 HqLee. All rights reserved.
//

#import "LHQSettingViewController.h"
#import <SDImageCache.h>

@interface LHQSettingViewController ()

@end

@implementation LHQSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
//    [self getSize];
    [self getSize1];
    
}

- (void)getSize1{
    
    NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
    
    NSString *cachesPath = [caches stringByAppendingPathComponent:@"default/com.hackemist.SDWebImageCache.default"];
    
    NSDirectoryEnumerator *dirEnumerator =  [LHQFileManager enumeratorAtPath:cachesPath];
    
    NSUInteger totalSize = 0;
    for (NSString *fileName in dirEnumerator) {
        
        NSString *filePath = [cachesPath stringByAppendingPathComponent:fileName];
        NSDictionary *attrs = [LHQFileManager attributesOfItemAtPath:filePath error:nil];
        NSUInteger size = [attrs[NSFileSize] unsignedIntegerValue];
        
        totalSize += size;
        
    }
    
    LHQLog(@"%.2fMB",totalSize/1000.0/1000);
}

- (void)getSize{
    
//    NSUInteger size = [SDImageCache sharedImageCache].getSize;
    
    NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
    NSString *cachesPath = [caches stringByAppendingPathComponent:@"default/com.hackemist.SDWebImageCache.default"];
    NSArray *files = [LHQFileManager contentsOfDirectoryAtPath:cachesPath error:nil];
    NSUInteger totalSize = 0;
    for (NSString *fileName in files) {
        
        NSString *fillPath = [cachesPath stringByAppendingPathComponent:fileName];
        NSDictionary *attr = [LHQFileManager attributesOfItemAtPath:fillPath error:nil];
        NSUInteger size = [attr[NSFileSize] unsignedIntegerValue];;
        
        totalSize += size;
    }
    LHQLog(@"%.2fMB",totalSize/1000.0/1000);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"setting"];
    
    return cell;
}

@end
