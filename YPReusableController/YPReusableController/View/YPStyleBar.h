//
//  YPStyleBar.h
//  YPReusableController
//
//  Created by MichaelPPP on 15/12/29.
//  Copyright (c) 2015年 tyiti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YPReusableControllerConst.h"

@protocol YPStyleBarDelegate;

@interface YPStyleBar : UIView

@property (nonatomic, assign) id<YPStyleBarDelegate> myDelegate;

/** 标题数组 */
@property (nonatomic, strong) NSMutableArray *items;

/** 文字内边距 */
@property (nonatomic, assign) CGFloat textInset;

/** 文字字体 */
@property (nonatomic, strong) UIFont *textFont;

/** 文字普通状态下的颜色 */
@property (nonatomic, strong) UIColor *textColor_normal;

/** 文字选中状态下的颜色 */
@property (nonatomic, strong) UIColor *textColor_selected;

/** 保存所有选项按钮的数组 */
@property (nonatomic, strong) NSMutableArray *allItemBtnArr;

/** 拖动比例 */
@property (nonatomic, assign) CGFloat progress;

/** 当前索引 */
@property (nonatomic, assign) NSInteger currentItemIndex;

/** bar的滑动内容背景颜色 */
@property (nonatomic, strong) UIColor *scrollViewBgColor;

/** 右侧图片(普通) */
@property (nonatomic, strong) UIImage *rightImage_normal;

/** 右侧图片(高亮) */
@property (nonatomic, strong) UIImage *rightImage_highlight;

/** 左侧图片(普通) */
@property (nonatomic, strong) UIImage *leftImage_normal;

/** 是否开启阴影效果 默认开启 */
@property (nonatomic, assign) BOOL isOpenShadowEffect;

@end

@protocol YPStyleBarDelegate <NSObject>

@optional
/** 当选项被选择时候的回调代理方法 */
- (void)itemDidSelectedWithIndex:(YPStyleBar *)navTabBar index:(NSUInteger)index;

@end

UIKIT_EXTERN NSString *const YPStyleBarLeftBtnDidTouchNotification;
UIKIT_EXTERN NSString *const YPStyleBarRightBtnDidTouchNotification;
