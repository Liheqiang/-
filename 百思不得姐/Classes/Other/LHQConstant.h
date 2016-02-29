/**
 *  存放常量 .h放extern 引用
 */
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, LHQTopicType) {
    LHQTopicTypeAll = 1,
    LHQTopicTypeVoice = 31,
    LHQTopicTypeVideo = 41,
    LHQTopicTypePicture = 10,
    LHQTopicTypeWord = 29
};
/** 精华栏标题视图高度 */
UIKIT_EXTERN CGFloat const LHQTitleViewH;
/** cell的间隙 */
UIKIT_EXTERN  CGFloat const LHQTopicCellMargin;
/** cell的头部视图高度 */
UIKIT_EXTERN  CGFloat const LHQTopicCellHeaderViewH;
/** cell的底部工具条高度 */
UIKIT_EXTERN  CGFloat const LHQTopicCellBottomViewH;
/** cell 的图片最大高度 */
UIKIT_EXTERN  CGFloat const LHQTopicPictureMaxH;
/** cell 的图片压缩的高度 */
UIKIT_EXTERN  CGFloat const LHQTopicPictureDealH;