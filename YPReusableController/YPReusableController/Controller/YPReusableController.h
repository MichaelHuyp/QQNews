//
//  YPReusableController.h
//  YPReusableController
//
//  Created by MichaelPPP on 15/12/28.
//  Copyright (c) 2015年 tyiti. All rights reserved.
//  YPNavTabBarController 第二代横空出世

#import <UIKit/UIKit.h>
#import "YPReusableControllerConst.h"

typedef void(^YPReusableControllerNormalBlock)(void);

@interface YPReusableController : UIViewController

/** 子控制器 */
@property (nonatomic, strong) NSArray *subViewControllers;

/** 文字内边距 */
@property (nonatomic, assign) CGFloat textInset;

/** 文字字体 */
@property (nonatomic, strong) UIFont *textFont;

/** 文字普通状态下的颜色 */
@property (nonatomic, strong) UIColor *textColor_normal;

/** 文字选中状态下的颜色 */
@property (nonatomic, strong) UIColor *textColor_selected;

/** 索引 */
@property (nonatomic, assign) NSUInteger currentIndex;

/** bar的背景颜色  默认whiteColor */
@property (nonatomic, strong) UIColor *bar_bgColor;

/** bar的滑动内容背景颜色 默认whiteColor */
@property (nonatomic, strong) UIColor *bar_scrollViewBgColor;

/** 右侧图片(普通) */
@property (nonatomic, strong) UIImage *rightImage_normal;

/** 右侧图片(高亮) */
@property (nonatomic, strong) UIImage *rightImage_highlight;

/** 左侧图片(普通) */
@property (nonatomic, strong) UIImage *leftImage_normal;

/** 是否开启阴影效果 默认开启 */
@property (nonatomic, assign) BOOL isOpenShadowEffect;

/** 右侧按钮点击回调方法 */
- (void)setRightBtnTouchBlock:(YPReusableControllerNormalBlock)rightBtnTouchBlock;

/** 左侧按钮点击回调方法 */
- (void)setLeftBtnTouchBlock:(YPReusableControllerNormalBlock)leftBtnTouchBlock;

- (instancetype)init UNAVAILABLE_ATTRIBUTE;
+ (instancetype)new UNAVAILABLE_ATTRIBUTE;

/** 构造方法 */
- (instancetype)initWithParentViewController:(UIViewController *)parentViewController;

@end

@interface UIViewController(YPReusableControllerExtension)

@property (nonatomic, copy) NSString *yp_Title;

@property (nonatomic, strong, readonly) YPReusableController *reusableController;

@end