//
//  YPReusableControllerConst.h
//  YPReusableController
//
//  Created by MichaelPPP on 15/12/28.
//  Copyright (c) 2015年 tyiti. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UIView+YPAdd.h"
#import "UIScrollView+YPAdd.h"
#import "YPCacheTool.h"

#if DEBUG

#define YPLog(FORMAT, ...) fprintf(stderr, "[%s:%d行] %s\n", [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);

#else

#define YPLog(FORMAT, ...) nil

#endif

#define YPLogFunc YPLog(@"%s",__func__)

/** navgationbar's height */
#define YPNavigationBarH 44.0f
/** statusbar's height */
#define YPStatusBarH 20.0f
/** navtabbar's height and statusbar's height */
#define YPStatusBarHAndNavBarH 64.0f
/** tabbar's height */
#define YPTabBarH 49.0f

#define YPPadding 8.0f
#define YPPadding_2 16.0f
#define YPPadding_3 24.0f

/** NotificationCenter */
#define YPNotificationCenter [NSNotificationCenter defaultCenter]

#pragma mark - Shortcut for Screen's parameter

#define YPScreen [UIScreen mainScreen]
#define YPScreenW [UIScreen mainScreen].bounds.size.width
#define YPScreenH [UIScreen mainScreen].bounds.size.height
#define YPScreenBounds [UIScreen mainScreen].bounds
#define YPScreenScale [UIScreen mainScreen].scale

#pragma mark - Shortcut for Color

#define YPBlackColor [UIColor blackColor]
#define YPBlueColor [UIColor blueColor]
#define YPRedColor [UIColor redColor]
#define YPWhiteColor [UIColor whiteColor]
#define YPGrayColor [UIColor grayColor]
#define YPDarkGrayColor [UIColor darkGrayColor]
#define YPLightGrayColor [UIColor lightGrayColor]
#define YPGreenColor [UIColor greenColor]
#define YPCyanColor [UIColor cyanColor]
#define YPYellowColor [UIColor yellowColor]
#define YPMagentaColor [UIColor magentaColor]
#define YPOrangeColor [UIColor orangeColor]
#define YPPurpleColor [UIColor purpleColor]
#define YPBrownColor [UIColor brownColor]
#define YPClearColor [UIColor clearColor]

#define iPHone6Plus ([UIScreen mainScreen].bounds.size.height == 736) ? YES : NO

#define iPHone6 ([UIScreen mainScreen].bounds.size.height == 667) ? YES : NO

#define iPHone5 ([UIScreen mainScreen].bounds.size.height == 568) ? YES : NO

#define iPHone4 ([UIScreen mainScreen].bounds.size.height == 480) ? YES : NO

/** RGB颜色 */
#define YPColor_RGB(r, g, b) [UIColor colorWithRed:(r) / 255.0 green:(g) / 255.0 blue:(b) / 255.0 alpha:1.0]
#define YPColor_RGBA(r, g, b, a) [UIColor colorWithRed:(r) / 255.0 green:(g) / 255.0 blue:(b) / 255.0 alpha:(a)]
#define YPColor_RGBA_256(r, g, b, a) [UIColor colorWithRed:(r) / 255.0 green:(g) / 255.0 blue:(b) / 255.0 alpha:(a) / 255.0]
/** 随机色 */
#define YPRandomColor_RGB YPColor_RGB(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))
#define YPRandomColor_RGBA YPColor_RGBA_256(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

#pragma mark - Shortcut for Font

#define YPFontBold_10 [UIFont boldSystemFontOfSize:10]
#define YPFontBold_11 [UIFont boldSystemFontOfSize:11]
#define YPFontBold_12 [UIFont boldSystemFontOfSize:12]
#define YPFontBold_13 [UIFont boldSystemFontOfSize:13]
#define YPFontBold_14 [UIFont boldSystemFontOfSize:14]
#define YPFontBold_15 [UIFont boldSystemFontOfSize:15]
#define YPFontBold_16 [UIFont boldSystemFontOfSize:16]
#define YPFontBold_17 [UIFont boldSystemFontOfSize:17]
#define YPFontBold_18 [UIFont boldSystemFontOfSize:18]
#define YPFontBold_19 [UIFont boldSystemFontOfSize:19]
#define YPFontBold_20 [UIFont boldSystemFontOfSize:20]
#define YPFontBold_21 [UIFont boldSystemFontOfSize:21]
#define YPFontBold_22 [UIFont boldSystemFontOfSize:22]
#define YPFontBold_23 [UIFont boldSystemFontOfSize:23]
#define YPFontBold_24 [UIFont boldSystemFontOfSize:24]
#define YPFontBold_25 [UIFont boldSystemFontOfSize:25]
#define YPFontBold_26 [UIFont boldSystemFontOfSize:26]
#define YPFontBold_27 [UIFont boldSystemFontOfSize:27]
#define YPFontBold_28 [UIFont boldSystemFontOfSize:28]
#define YPFontBold_29 [UIFont boldSystemFontOfSize:29]
#define YPFontBold_30 [UIFont boldSystemFontOfSize:30]

#define YPFontSystem_10 [UIFont systemFontOfSize:10]
#define YPFontSystem_11 [UIFont systemFontOfSize:11]
#define YPFontSystem_12 [UIFont systemFontOfSize:12]
#define YPFontSystem_13 [UIFont systemFontOfSize:13]
#define YPFontSystem_14 [UIFont systemFontOfSize:14]
#define YPFontSystem_15 [UIFont systemFontOfSize:15]
#define YPFontSystem_16 [UIFont systemFontOfSize:16]
#define YPFontSystem_17 [UIFont systemFontOfSize:17]
#define YPFontSystem_18 [UIFont systemFontOfSize:18]
#define YPFontSystem_19 [UIFont systemFontOfSize:19]
#define YPFontSystem_20 [UIFont systemFontOfSize:20]
#define YPFontSystem_21 [UIFont systemFontOfSize:21]
#define YPFontSystem_22 [UIFont systemFontOfSize:22]
#define YPFontSystem_23 [UIFont systemFontOfSize:23]
#define YPFontSystem_24 [UIFont systemFontOfSize:24]
#define YPFontSystem_25 [UIFont systemFontOfSize:25]
#define YPFontSystem_26 [UIFont systemFontOfSize:26]
#define YPFontSystem_27 [UIFont systemFontOfSize:27]
#define YPFontSystem_28 [UIFont systemFontOfSize:28]
#define YPFontSystem_29 [UIFont systemFontOfSize:29]
#define YPFontSystem_30 [UIFont systemFontOfSize:30]

#pragma mark - SystemVersion
float YPDeviceSystemVersion();

#ifndef kSystemVersion
#define kSystemVersion YPDeviceSystemVersion()
#endif

#ifndef kiOS6Later
#define kiOS6Later (kSystemVersion >= 6)
#endif

#ifndef kiOS7Later
#define kiOS7Later (kSystemVersion >= 7)
#endif

#ifndef kiOS8Later
#define kiOS8Later (kSystemVersion >= 8)
#endif

#ifndef kiOS9Later
#define kiOS9Later (kSystemVersion >= 9)
#endif


#ifndef YPSYNTH_DYNAMIC_PROPERTY_OBJECT
#define YPSYNTH_DYNAMIC_PROPERTY_OBJECT(_getter_, _setter_, _association_, _type_) \
- (void)_setter_ : (_type_)object { \
[self willChangeValueForKey:@#_getter_]; \
objc_setAssociatedObject(self, _cmd, object, OBJC_ASSOCIATION_ ## _association_); \
[self didChangeValueForKey:@#_getter_]; \
} \
- (_type_)_getter_ { \
return objc_getAssociatedObject(self, @selector(_setter_:)); \
}
#endif

UIKIT_EXTERN const CGFloat YPStyleBarHeight;
UIKIT_EXTERN const CGFloat YPStyleBarLeftOrRightBtnWH;

UIKIT_EXTERN NSString *const YPKeyPathContentOffset;
UIKIT_EXTERN NSString *const YPKeyPathContentSize;