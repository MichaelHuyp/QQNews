//
//  YPChannelFooterView.m
//  YPReusableController
//
//  Created by MichaelPPP on 16/2/3.
//  Copyright © 2016年 tyiti. All rights reserved.
//

#import "YPChannelFooterView.h"
#import "YPReusableControllerConst.h"
@interface YPChannelFooterView ()


@property (nonatomic, weak) UISegmentedControl *segmentedControl;

@end

@implementation YPChannelFooterView


#pragma mark - Override
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self) return nil;
    [self setup];
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (!self) return nil;
    [self setup];
    return self;
}

#pragma mark - Private
- (void)setup
{
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"更多频道",@"地方新闻",@"报纸"]];
    
    self.segmentedControl = segmentedControl;
    [self addSubview:segmentedControl];
    segmentedControl.frame = CGRectMake(12, 0, self.yp_width - 24, 44);
    segmentedControl.tintColor = [UIColor colorWithRed:0.15f green:0.38f blue:0.77f alpha:1.00f];
    segmentedControl.selectedSegmentIndex = 0;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

@end

















































