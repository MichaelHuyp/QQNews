//
//  YPBaseCollectionCell.h
//  YPReusableController
//
//  Created by MichaelPPP on 16/2/1.
//  Copyright © 2016年 tyiti. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YPBaseCollectionCell : UICollectionViewCell

+ (instancetype)cellFromNib:(NSString *)nibName andCollectionView:(UICollectionView *)collectionView andIndexPath:(NSIndexPath *)indexPath;

@end
