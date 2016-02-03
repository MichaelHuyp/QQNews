//
//  YPLeftMenuController.m
//  YPReusableController
//
//  Created by MichaelPPP on 16/1/25.
//  Copyright © 2016年 tyiti. All rights reserved.
//

#import "YPLeftMenuController.h"
#import "YPReusableControllerConst.h"
#import "YPSideController.h"

typedef NS_ENUM(NSInteger, ProfileBtnTag) {
    ProfileBtnTagMessage = 10086,   // 消息
    ProfileBtnTagCollect,           // 收藏
    ProfileBtnTagGame,              // 游戏
    ProfileBtnTagComment,           // 吐个槽
    ProfileBtnTagMore,              // 更多
    ProfileBtnTagSearch,            // 搜索
    ProfileBtnTagLogin,             // 登录
    ProfileBtnTagOfflineRead,       // 离线阅读
    ProfileBtnTagNightMode,         // 夜间模式
    ProfileBtnTagTextMode           // 文字模式
};

@interface YPLeftMenuController ()

@end

@implementation YPLeftMenuController


#pragma mark - Override
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    [self createUI];
}


#pragma mark - Private

- (void)createUI
{
    // 上方
    UIImageView *rightArrow = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"right_arrow"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
    [self.view addSubview:rightArrow];
    rightArrow.tintColor = [UIColor colorWithRed:0.48f green:0.58f blue:0.69f alpha:1.00f];
    
    if (iPHone6 || iPHone6Plus) {
        rightArrow.frame = CGRectMake(YPScreenW - self.sideController.sideDistance - 44, 44, 44, 44);
    } else if (iPHone4 || iPHone5) {
        rightArrow.frame = CGRectMake(YPScreenW - self.sideController.sideDistance - 49, 33, 44, 44);
    }
    
    
    UIView *line_1 = [[UIView alloc] init];
    [self.view addSubview:line_1];
    line_1.backgroundColor = rightArrow.tintColor;
    
    if (iPHone6 || iPHone6Plus) {
        line_1.frame = CGRectMake(24, rightArrow.yp_bottom + 24, YPScreenW - 16 - self.sideController.sideDistance, 0.5);
    } else if (iPHone4 || iPHone5) {
        line_1.frame = CGRectMake(24, rightArrow.yp_bottom + 14, YPScreenW - 16 - self.sideController.sideDistance, 0.5);
    }
    
    UIImageView *icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_1"]];
    [self.view addSubview:icon];
    
    if (iPHone6 || iPHone6Plus) {
        icon.yp_size = CGSizeMake(64, 64);
    } else if (iPHone4 || iPHone5) {
        icon.yp_size = CGSizeMake(44, 44);
    }
    
    icon.yp_x = line_1.yp_x;
    icon.yp_centerY = rightArrow.yp_centerY;
    
    icon.layer.cornerRadius = icon.yp_width * 0.5;
    icon.layer.masksToBounds = YES;
    
    UILabel *nameLabel = [[UILabel alloc] init];
    [self.view addSubview:nameLabel];
    nameLabel.text = @"点击登录";
    
    if (iPHone6 || iPHone6Plus) {
        nameLabel.font = YPFontBold_20;
    } else if (iPHone4 || iPHone5) {
        nameLabel.font = YPFontBold_17;
    }
    
    [nameLabel sizeToFit];
    nameLabel.textColor = [UIColor colorWithRed:0.66f green:0.75f blue:0.83f alpha:1.00f];
    nameLabel.textAlignment = NSTextAlignmentLeft;
    nameLabel.yp_x = icon.yp_right + 12;
    nameLabel.yp_centerY = icon.yp_centerY;
    
    
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:loginBtn];
    loginBtn.frame = CGRectMake(0, icon.yp_top, rightArrow.yp_right, line_1.yp_bottom - icon.yp_top);
    [loginBtn addTarget:self action:@selector(btnTouch:) forControlEvents:UIControlEventTouchUpInside];
    loginBtn.tag = ProfileBtnTagLogin;
    
    
    // 底部
    
    UIButton *offlineReadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:offlineReadBtn];
    [offlineReadBtn setTintColor:rightArrow.tintColor];
    [offlineReadBtn setBackgroundImage:[[UIImage imageNamed:@"night-setting_accountHeadIconBack"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    [offlineReadBtn setImage:[UIImage imageNamed:@"bottom_btn_screen_revert_white"] forState:UIControlStateNormal];
    if (iPHone6Plus || iPHone6) {
        offlineReadBtn.yp_x = icon.yp_x;
        offlineReadBtn.yp_size = CGSizeMake(64, 64);
    } else if (iPHone5 || iPHone4) {
        offlineReadBtn.yp_x = YPPadding;
        offlineReadBtn.yp_size = CGSizeMake(54, 54);
    }
    offlineReadBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 5, 0);
    offlineReadBtn.yp_y = YPScreenH - offlineReadBtn.yp_height - 32;
    [offlineReadBtn addTarget:self action:@selector(btnTouch:) forControlEvents:UIControlEventTouchUpInside];
    offlineReadBtn.tag = ProfileBtnTagOfflineRead;
    
    UIButton *textModeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:textModeBtn];
    [textModeBtn setTintColor:rightArrow.tintColor];
    [textModeBtn setBackgroundImage:[[UIImage imageNamed:@"night-setting_accountHeadIconBack"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    [textModeBtn setImage:[UIImage imageNamed:@"profile_btn_fontsize_white"] forState:UIControlStateNormal];
    textModeBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 5, 0);
    
    if (iPHone6Plus || iPHone6) {
        textModeBtn.yp_size = CGSizeMake(64, 64);
        textModeBtn.yp_right = YPScreenW - self.sideController.sideDistance - icon.yp_x;
    } else if (iPHone5 || iPHone4) {
        textModeBtn.yp_size = CGSizeMake(54, 54);
        textModeBtn.yp_right = YPScreenW - self.sideController.sideDistance - YPPadding;
    }
    
    textModeBtn.yp_centerY = offlineReadBtn.yp_centerY;
    [textModeBtn addTarget:self action:@selector(btnTouch:) forControlEvents:UIControlEventTouchUpInside];
    textModeBtn.tag = ProfileBtnTagTextMode;
    
    UIButton *nightModeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:nightModeBtn];
    [nightModeBtn setTintColor:rightArrow.tintColor];
    [nightModeBtn setBackgroundImage:[[UIImage imageNamed:@"night-setting_accountHeadIconBack"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    [nightModeBtn setImage:[[UIImage imageNamed:@"bottom_btn_night_white"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    nightModeBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 5, 0);
    
    if (iPHone6Plus || iPHone6) {
        nightModeBtn.yp_size = CGSizeMake(64, 64);
        textModeBtn.yp_right = YPScreenW - self.sideController.sideDistance - icon.yp_x;
    } else if (iPHone5 || iPHone4) {
        nightModeBtn.yp_size = CGSizeMake(54, 54);
        textModeBtn.yp_right = YPScreenW - self.sideController.sideDistance - YPPadding;
    }
    
    
    nightModeBtn.yp_centerX = (YPScreenW - self.sideController.sideDistance) * 0.5;
    nightModeBtn.yp_centerY = offlineReadBtn.yp_centerY;
    [nightModeBtn addTarget:self action:@selector(btnTouch:) forControlEvents:UIControlEventTouchUpInside];
    nightModeBtn.tag = ProfileBtnTagNightMode;
    
    
    UILabel *offlineReadLabel = [[UILabel alloc] init];
    [self.view addSubview:offlineReadLabel];
    offlineReadLabel.text = @"离线阅读";
    offlineReadLabel.font = YPFontBold_14;
    offlineReadLabel.textColor = rightArrow.tintColor;
    [offlineReadLabel sizeToFit];
    offlineReadLabel.yp_top = offlineReadBtn.yp_bottom;
    offlineReadLabel.yp_centerX = offlineReadBtn.yp_centerX;
    
    UILabel *textModeLabel = [[UILabel alloc] init];
    [self.view addSubview:textModeLabel];
    textModeLabel.text = @"文字模式";
    textModeLabel.font = YPFontBold_14;
    textModeLabel.textColor = rightArrow.tintColor;
    [textModeLabel sizeToFit];
    textModeLabel.yp_top = textModeBtn.yp_bottom;
    textModeLabel.yp_centerX = textModeBtn.yp_centerX;
    
    UILabel *nightModeLabel = [[UILabel alloc] init];
    [self.view addSubview:nightModeLabel];
    nightModeLabel.text = @"夜间模式";
    nightModeLabel.font = YPFontBold_14;
    nightModeLabel.textColor = rightArrow.tintColor;
    [nightModeLabel sizeToFit];
    nightModeLabel.yp_top = nightModeBtn.yp_bottom;
    nightModeLabel.yp_centerX = nightModeBtn.yp_centerX;
    
    // 中间
    UIScrollView *middleContainerScrollView = [[UIScrollView alloc] init];
    [self.view addSubview:middleContainerScrollView];
    middleContainerScrollView.bounces = YES;
    middleContainerScrollView.alwaysBounceVertical = YES;
    middleContainerScrollView.showsVerticalScrollIndicator = NO;
    middleContainerScrollView.showsHorizontalScrollIndicator = NO;
    middleContainerScrollView.backgroundColor = YPClearColor;
    middleContainerScrollView.yp_x = 0;
    middleContainerScrollView.yp_width = YPScreenW - self.sideController.sideDistance;
    middleContainerScrollView.yp_top = line_1.yp_bottom;
    middleContainerScrollView.yp_height = YPScreenH - line_1.yp_bottom - (YPScreenH - offlineReadBtn.yp_top + 16);
    middleContainerScrollView.contentSize = CGSizeMake(middleContainerScrollView.yp_width, middleContainerScrollView.yp_height);
    
    UIButton *messageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [middleContainerScrollView addSubview:messageBtn];
    messageBtn.tintColor = YPWhiteColor;
    [messageBtn setTitle:@"消息" forState:UIControlStateNormal];
    [messageBtn setTitleColor:YPWhiteColor forState:UIControlStateNormal];
    [messageBtn setImage:[[UIImage imageNamed:@"profile_btn_message"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    [messageBtn setImage:[[UIImage imageNamed:@"profile_btn_message"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateHighlighted];
    [messageBtn setBackgroundImage:[[UIImage imageNamed:@"tad_shadow_up"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateHighlighted];
    messageBtn.titleLabel.font = YPFontBold_17;
    messageBtn.yp_width = middleContainerScrollView.yp_width;
    
    if (iPHone6 || iPHone6Plus) {
        messageBtn.yp_height = 64;
    } else if (iPHone5) {
        messageBtn.yp_height = 49;
    } else if (iPHone4) {
        messageBtn.yp_height = 44;
    }
    
    messageBtn.yp_x = 0;
    messageBtn.yp_y = 0;
    messageBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    messageBtn.imageEdgeInsets = UIEdgeInsetsMake(0, line_1.yp_x, 0, 0);
    messageBtn.titleEdgeInsets = UIEdgeInsetsMake(0, line_1.yp_x + YPPadding, 0, 0);
    [messageBtn addTarget:self action:@selector(btnTouch:) forControlEvents:UIControlEventTouchUpInside];
    messageBtn.tag = ProfileBtnTagMessage;
    

    
    UIButton *collectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [middleContainerScrollView addSubview:collectBtn];
    collectBtn.tintColor = YPWhiteColor;
    [collectBtn setTitle:@"收藏" forState:UIControlStateNormal];
    [collectBtn setTitleColor:YPWhiteColor forState:UIControlStateNormal];
    [collectBtn setImage:[[UIImage imageNamed:@"fullplayer_icon_faverate"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    [collectBtn setImage:[[UIImage imageNamed:@"fullplayer_icon_faverate"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateHighlighted];
    [collectBtn setBackgroundImage:[[UIImage imageNamed:@"tad_shadow_up"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateHighlighted];
    collectBtn.titleLabel.font = YPFontBold_17;
    collectBtn.yp_width = middleContainerScrollView.yp_width;
    
    if (iPHone6 || iPHone6Plus) {
        collectBtn.yp_height = 64;
    } else if (iPHone5) {
        collectBtn.yp_height = 49;
    } else if (iPHone4) {
        collectBtn.yp_height = 44;
    }
    
    collectBtn.yp_x = 0;
    collectBtn.yp_y = messageBtn.yp_bottom;
    collectBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    collectBtn.imageEdgeInsets = UIEdgeInsetsMake(0, line_1.yp_x + 3, 0, 0);
    collectBtn.titleEdgeInsets = UIEdgeInsetsMake(0, line_1.yp_x + YPPadding + 3, 0, 0);
    [collectBtn addTarget:self action:@selector(btnTouch:) forControlEvents:UIControlEventTouchUpInside];
    collectBtn.tag = ProfileBtnTagCollect;

    
    UIButton *gameBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [middleContainerScrollView addSubview:gameBtn];
    gameBtn.tintColor = YPWhiteColor;
    [gameBtn setTitle:@"游戏" forState:UIControlStateNormal];
    [gameBtn setTitleColor:YPWhiteColor forState:UIControlStateNormal];
    [gameBtn setImage:[[UIImage imageNamed:@"bottom_btn_profile"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    [gameBtn setImage:[[UIImage imageNamed:@"bottom_btn_profile"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateHighlighted];
    [gameBtn setBackgroundImage:[[UIImage imageNamed:@"tad_shadow_up"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateHighlighted];
    gameBtn.titleLabel.font = YPFontBold_17;
    gameBtn.yp_width = middleContainerScrollView.yp_width;
    
    if (iPHone6 || iPHone6Plus) {
        gameBtn.yp_height = 64;
    } else if (iPHone5) {
        gameBtn.yp_height = 49;
    } else if (iPHone4) {
        gameBtn.yp_height = 44;
    }
    
    gameBtn.yp_x = 0;
    gameBtn.yp_y = collectBtn.yp_bottom;
    gameBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    gameBtn.imageEdgeInsets = UIEdgeInsetsMake(0, line_1.yp_x, 0, 0);
    gameBtn.titleEdgeInsets = UIEdgeInsetsMake(0, line_1.yp_x + YPPadding, 0, 0);
    [gameBtn addTarget:self action:@selector(btnTouch:) forControlEvents:UIControlEventTouchUpInside];
    gameBtn.tag = ProfileBtnTagGame;

    
    UIView *line_2 = [[UIView alloc] init];
    [middleContainerScrollView addSubview:line_2];
    line_2.backgroundColor = line_1.backgroundColor;
    line_2.yp_size = line_1.yp_size;
    line_2.yp_x = line_1.yp_x;
    line_2.yp_y = gameBtn.yp_bottom;
    
    UIButton *commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [middleContainerScrollView addSubview:commentBtn];
    commentBtn.tintColor = YPWhiteColor;
    [commentBtn setTitle:@"吐个槽" forState:UIControlStateNormal];
    [commentBtn setTitleColor:YPWhiteColor forState:UIControlStateNormal];
    [commentBtn setImage:[[UIImage imageNamed:@"talk"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    [commentBtn setImage:[[UIImage imageNamed:@"talk"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateHighlighted];
    [commentBtn setBackgroundImage:[[UIImage imageNamed:@"tad_shadow_up"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateHighlighted];
    commentBtn.titleLabel.font = YPFontBold_17;
    commentBtn.yp_width = middleContainerScrollView.yp_width;
    
    if (iPHone6 || iPHone6Plus) {
        commentBtn.yp_height = 64;
    } else if (iPHone5) {
        commentBtn.yp_height = 49;
    } else if (iPHone4) {
        commentBtn.yp_height = 44;
    }
    
    commentBtn.yp_x = 0;
    commentBtn.yp_y = gameBtn.yp_bottom;
    commentBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    commentBtn.imageEdgeInsets = UIEdgeInsetsMake(0, line_1.yp_x + 3, 0, 0);
    commentBtn.titleEdgeInsets = UIEdgeInsetsMake(0, line_1.yp_x + YPPadding + 3, 0, 0);
    [commentBtn addTarget:self action:@selector(btnTouch:) forControlEvents:UIControlEventTouchUpInside];
    commentBtn.tag = ProfileBtnTagComment;
    
    UIButton *moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [middleContainerScrollView addSubview:moreBtn];
    moreBtn.tintColor = YPWhiteColor;
    [moreBtn setTitle:@"更多" forState:UIControlStateNormal];
    [moreBtn setTitleColor:YPWhiteColor forState:UIControlStateNormal];
    [moreBtn setImage:[[UIImage imageNamed:@"profile_btn_setting"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    [moreBtn setImage:[[UIImage imageNamed:@"profile_btn_setting"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateHighlighted];
    [moreBtn setBackgroundImage:[[UIImage imageNamed:@"tad_shadow_up"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateHighlighted];
    moreBtn.titleLabel.font = YPFontBold_17;
    moreBtn.yp_width = middleContainerScrollView.yp_width;
    
    if (iPHone6 || iPHone6Plus) {
        moreBtn.yp_height = 64;
    } else if (iPHone5) {
        moreBtn.yp_height = 49;
    } else if (iPHone4) {
        moreBtn.yp_height = 44;
    }
    
    moreBtn.yp_x = 0;
    moreBtn.yp_y = commentBtn.yp_bottom;
    moreBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    moreBtn.imageEdgeInsets = UIEdgeInsetsMake(0, line_1.yp_x, 0, 0);
    moreBtn.titleEdgeInsets = UIEdgeInsetsMake(0, line_1.yp_x + YPPadding, 0, 0);
    [moreBtn addTarget:self action:@selector(btnTouch:) forControlEvents:UIControlEventTouchUpInside];
    moreBtn.tag = ProfileBtnTagMore;

    
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [middleContainerScrollView addSubview:searchBtn];
    searchBtn.tintColor = [UIColor colorWithRed:0.56f green:0.64f blue:0.70f alpha:1.00f];
    [searchBtn setTitle:@"请输入关键词" forState:UIControlStateNormal];
    [searchBtn setImage:[[UIImage imageNamed:@"night-searchbar_icon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [searchBtn setImage:[[UIImage imageNamed:@"night-searchbar_icon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateHighlighted];
    [searchBtn setBackgroundImage:[[UIImage imageNamed:@"home_searchbox"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    [searchBtn setBackgroundImage:[[UIImage imageNamed:@"home_searchbox"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateHighlighted];
    [searchBtn setTitleColor:YPColor_RGB(80, 80, 80) forState:UIControlStateNormal];
    searchBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    searchBtn.imageEdgeInsets = UIEdgeInsetsMake(0, YPPadding, 0, 0);
    searchBtn.titleEdgeInsets = UIEdgeInsetsMake(0, YPPadding_2, 0, 0);
    searchBtn.titleLabel.font = YPFontBold_18;
    searchBtn.yp_width = middleContainerScrollView.yp_width - 32;
    
    if (iPHone6 || iPHone6Plus) {
        searchBtn.yp_height = 49;
    } else if (iPHone4 || iPHone5) {
        searchBtn.yp_height = 44;
    }
    
    searchBtn.yp_x = 16;
    searchBtn.yp_y = moreBtn.yp_bottom + 8;
    [searchBtn addTarget:self action:@selector(btnTouch:) forControlEvents:UIControlEventTouchUpInside];
    searchBtn.tag = ProfileBtnTagSearch;
    
}

- (void)loginBtnTouch
{
    YPLog(@"点击登录");
}

- (void)btnTouch:(UIButton *)btn
{
    switch (btn.tag) {
        case ProfileBtnTagLogin:
            YPLog(@"登录");
            break;
        case ProfileBtnTagMessage:
            YPLog(@"消息");
            break;
        case ProfileBtnTagCollect:
            YPLog(@"收藏");
            break;
        case ProfileBtnTagGame:
            YPLog(@"游戏");
            break;
        case ProfileBtnTagComment:
            YPLog(@"吐个槽");
            break;
        case ProfileBtnTagMore:
            YPLog(@"更多");
            break;
        case ProfileBtnTagSearch:
            YPLog(@"搜索");
            break;
        case ProfileBtnTagOfflineRead:
            YPLog(@"离线阅读");
            break;
        case ProfileBtnTagNightMode:
            YPLog(@"夜间模式");
            break;
        case ProfileBtnTagTextMode:
            YPLog(@"文字模式");
            break;
        default:
            break;
    }
}




@end
