//
//  YPBaseCollectionCell.m
//  YPReusableController
//
//  Created by MichaelPPP on 16/2/1.
//  Copyright © 2016年 tyiti. All rights reserved.
//

#import "YPBaseCollectionCell.h"

@implementation YPBaseCollectionCell

+ (instancetype)cellFromNib:(NSString *)nibName andCollectionView:(UICollectionView *)collectionView andIndexPath:(NSIndexPath *)indexPath
{
    NSString *className = NSStringFromClass([self class]);
    
    NSString *ID = nibName == nil? className : nibName;
    
    UINib *nib = [UINib nibWithNibName:ID bundle:nil];
    
    [collectionView registerNib:nib forCellWithReuseIdentifier:ID];
    
    return [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
}

@end
