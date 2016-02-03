//
//  YPCacheTool.m
//  YPReusableController
//
//  Created by MichaelPPP on 16/2/3.
//  Copyright © 2016年 tyiti. All rights reserved.
//

#import "YPCacheTool.h"

#define kChannelTitleArrayKey @"ChannelTitleArrayKey"

@implementation YPCacheTool

+ (NSArray *)channelTitleArray
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:kChannelTitleArrayKey];
}

+ (void)saveChannelTitleArray:(NSArray *)titleArray
{
    [[NSUserDefaults standardUserDefaults] setObject:[titleArray copy] forKey:kChannelTitleArrayKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
