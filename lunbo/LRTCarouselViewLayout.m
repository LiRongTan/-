//
//  LRTCarouselViewLayout.m
//  lunbo
//
//  Created by 李荣潭 on 2018/1/3.
//  Copyright © 2018年 李荣潭. All rights reserved.
//

#import "LRTCarouselViewLayout.h"

@interface LRTCarouselViewLayout () {
    CGFloat _viewHeight;
    CGFloat _itemHeight;
}
@end
@implementation LRTCarouselViewLayout

- (void)prepareLayout {
    [super prepareLayout];
    if (self.visibleCount < 1) {
        self.visibleCount = 9;
    }
    self.visibleCount = 9;
    _viewHeight = CGRectGetWidth(self.collectionView.frame);
    _itemHeight = self.itemSize.width;
    self.collectionView.contentInset = UIEdgeInsetsMake(0, (_viewHeight - _itemHeight) / 2, 0, (_viewHeight - _itemHeight) / 2);
}

- (CGSize)collectionViewContentSize {
    NSInteger cellCount = [self.collectionView numberOfItemsInSection:0];
    return CGSizeMake(cellCount * _itemHeight, CGRectGetHeight(self.collectionView.frame) - 64);
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSInteger cellCount = [self.collectionView numberOfItemsInSection:0];
    CGFloat centerY = self.collectionView.contentOffset.x + _viewHeight / 2;
    NSInteger index = centerY / _itemHeight;
    NSInteger count = (self.visibleCount - 1) / 2;
    NSInteger minIndex = MAX(0, (index - count));
    NSInteger maxIndex = MIN((cellCount - 1), (index + count));
    NSMutableArray *array = [NSMutableArray array];
    for (NSInteger i = minIndex; i <= maxIndex; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
        [array addObject:attributes];
    }
    return array;
}
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attributes.size = self.itemSize;
    
    CGFloat cY = self.collectionView.contentOffset.x + _viewHeight / 2;
    CGFloat attributesY = _itemHeight * indexPath.row + _itemHeight / 2;
    attributes.zIndex = -ABS(attributesY - cY);
    CGFloat delta = cY - attributesY;
    CGFloat ratio =  - delta / (_itemHeight * 2);
    CGFloat scale = 1 - ABS(delta) / (_itemHeight * 6.0) * cos(ratio * M_PI_4);
    attributes.transform = CGAffineTransformMakeScale(scale, scale);
    CGFloat centerY = attributesY;
    centerY = cY + sin(ratio * M_PI_2) * _itemHeight * INTERSPACEPARAM;
    if (delta > 0 && delta <= _itemHeight / 2) {
        attributes.transform = CGAffineTransformIdentity;
        CGRect rect = attributes.frame;
        rect.origin.x = centerY - _itemHeight * scale / 2;
        rect.origin.y = CGRectGetHeight(self.collectionView.frame) / 2 - _itemSize.height * scale / 2;
        rect.size.height = _itemSize.height * scale;
        //                    rect.size.width = _itemSize.height * scale;
        
        CGFloat param = delta / (_itemHeight / 2);
        rect.size.width = _itemHeight * scale * (1 - param) + sin(0.25 * M_PI_2) * _itemHeight * INTERSPACEPARAM * 2 * param;
        NSLog(@"%f",rect.size.width);

        attributes.frame = rect;
        NSLog(@"%@===%f====%f======%f",NSStringFromCGRect(attributes.frame),param,scale,_itemHeight);
        return attributes;
    }
    attributes.center = CGPointMake(centerY, CGRectGetHeight(self.collectionView.frame) / 2);
    return attributes;
}


- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    CGFloat index = roundf((proposedContentOffset.x + _viewHeight / 2 - _itemHeight / 2) / _itemHeight);
    
    proposedContentOffset.x = _itemHeight * index + _itemHeight / 2 - _viewHeight / 2;

    return proposedContentOffset;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return !CGRectEqualToRect(newBounds, self.collectionView.bounds);
}
@end
