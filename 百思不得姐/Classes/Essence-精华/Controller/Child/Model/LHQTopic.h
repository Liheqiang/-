//
//  LHQTopic.h
//  百思不得姐
//
//  Created by HqLee on 16/2/26.
//  Copyright © 2016年 HqLee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LHQTopic : NSObject
/** 帖子id */
@property (nonatomic, copy) NSString *Id;
/** 昵称 */
@property (nonatomic, copy) NSString *name;
/** 昵称 */
@property (nonatomic, copy) NSString *screen_name;
/** 头像url */
@property (nonatomic, copy) NSString *profile_image;
/** 是否为新浪+v */
@property (nonatomic, assign, getter=isSina_v) BOOL sina_v;
/** 帖子创建时间 */
@property (nonatomic, copy) NSString *created_at;
/** 文字 */
@property (nonatomic, copy) NSString *text;
/** 是否为gif图片 */
@property (nonatomic, assign, getter=isGif) BOOL is_gif;
/** 帖子类型 */
@property (nonatomic, assign) LHQTopicType type;
/** 小图url */
@property (nonatomic, copy) NSString *smallImageUrl;
/** 中图url */
@property (nonatomic, copy) NSString *middleImageUrl;
/** 大图url */
@property (nonatomic, copy) NSString *bigImageUrl;
/** 赞的数量 */
@property (nonatomic, assign) NSInteger ding;
/** 踩的数量 */
@property (nonatomic, assign) NSInteger cai;
/** 转发的数量 */
@property (nonatomic, assign) NSInteger repost;
/** 评论的数量 */
@property (nonatomic, assign) NSInteger comment;
/** 图片的宽度 */
@property (nonatomic, assign) CGFloat width;
/** 图片的高度 */
@property (nonatomic, assign) CGFloat height;

//cell的辅助属性
@property (nonatomic, assign ,readonly) CGFloat cellHeight;
@property (nonatomic, assign ,readonly) CGRect pictureF;
@property (nonatomic, assign ,getter=isBigPicture) BOOL bigPicture;
@end
