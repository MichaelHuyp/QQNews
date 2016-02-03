//
//  YPCacheTool.h
//  YPReusableController
//
//  Created by MichaelPPP on 16/2/3.
//  Copyright © 2016年 tyiti. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YPCacheTool : NSObject

+ (NSArray *)channelTitleArray;

+ (void)saveChannelTitleArray:(NSArray *)titleArray;

@end
