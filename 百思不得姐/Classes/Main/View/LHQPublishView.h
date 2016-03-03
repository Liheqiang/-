//
//  LHQPublishView.h
//  百思不得姐
//
//  Created by HqLee on 16/3/3.
//  Copyright © 2016年 HqLee. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, LHQPublishViewButtonType) {
    LHQPublishViewButtonTypeVideo,
    LHQPublishViewButtonTypePicture,
    LHQPublishViewButtonTypeText,
    LHQPublishViewButtonTypeAudio,
    LHQPublishViewButtonTypeReview,
    LHQPublishViewButtonTypeOffline
};
@interface LHQPublishView : UIView

+ (instancetype)publishView;
+ (void)show;

@end
