//
//  YPChannelCell.m
//  YPReusableController
//
//  Created by MichaelPPP on 16/2/1.
//  Copyright © 2016年 tyiti. All rights reserved.
//

#import "YPChannelCell.h"
#import "YPReusableControllerConst.h"

@interface YPChannelCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation YPChannelCell


#pragma mark - Override
+ (instancetype)channelCellWithCollectionView:(UICollectionView *)collectionView andIndexPath:(NSIndexPath *)indexPath
{
    return [self cellFromNib:nil andCollectionView:collectionView andIndexPath:indexPath];
}

- (void)awakeFromNib
{
    // titleLabel
    self.titleLabel.backgroundColor = YPWhiteColor;
    self.titleLabel.layer.borderWidth = 0.5;
    self.titleLabel.layer.borderColor = YPColor_RGB(200, 200, 200).CGColor;
    self.titleLabel.layer.cornerRadius = 2;
}

#pragma mark - setter

- (void)setTitle:(NSString *)title
{
    _title = title;
    
    self.titleLabel.text = title;
}



@end







































