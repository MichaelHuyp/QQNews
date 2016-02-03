//
//  YPStyleBtn.m
//  YPReusableController
//
//  Created by MichaelPPP on 15/12/30.
//  Copyright (c) 2015年 tyiti. All rights reserved.
//

#import "YPStyleBtn.h"

@implementation YPStyleBtn

#pragma mark - Public
+ (instancetype)styleBtn
{
    return [[self alloc] init];
}

#pragma mark - Override

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (!self) return nil;
    
    [self prepare];
    
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
}

#pragma mark - Private
- (void)prepare{}

@end
