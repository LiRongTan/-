//
//  LRTSecondCarouselLayout.m
//  lunbo
//
//  Created by 李荣潭 on 2018/1/3.
//  Copyright © 2018年 李荣潭. All rights reserved.
//

#import "LRTSecondCarouselLayout.h"
#import "LRTCarouselViewLayout.h"
@interface LRTSecondCarouselLayout () {
    CGFloat _viewHeight;
    CGFloat _itemHeight;
    CGFloat _oldCenterY;
    BOOL scrollLeft;
    CGFloat _oldMindelta;
    CGFloat defaultsItemHeight;
    
}
@end
@implementation LRTSecondCarouselLayout

- (void)prepareLayout {
    [super prepareLayout];
    if (self.visibleCount < 1) {
        self.visibleCount = 7;
    }
    defaultsItemHeight = [UIScreen mainScreen].bounds.size.width /375.0 *130;   
    self.visibleCount = 7;
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
    _oldCenterY = centerY;
    return array;
}
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attributes.size = self.itemSize;
    
    CGFloat cY = self.collectionView.contentOffset.x + _viewHeight / 2;
    CGFloat attributesY = _itemHeight * indexPath.row + _itemHeight / 2;
    attributes.zIndex = -ABS(attributesY - cY);
    
    CGFloat delta = cY - attributesY;
    CGFloat scale = 1 - ABS(delta) / (_itemHeight * 6.0);
    attributes.transform = CGAffineTransformMakeScale(scale, scale);
    CGFloat centerY = attributesY;
    centerY = cY - delta *0.6 *pow(0.95, ABS(delta)/_itemHeight);
    CGFloat halfDelta = (delta *0.6 - delta *0.5) *2;
    if ((delta < _itemHeight / 4.0 && delta >= 0) || (delta > - _itemHeight / 4.0 && delta < 0)) {
        BOOL old;
        BOOL new;
        if (_oldMindelta <= 0) {
            old = NO;
        }else{
            old = YES;
        }
        if (delta <= 0) {
            new = NO;
        }else{
            new = YES;
        }
        NSLog(@"判断    %f    ====     %f",delta,_oldMindelta);
        _oldMindelta = delta;
        if (old != new) {
            if (_oldCenterY - cY <= 0) {
                scrollLeft = YES;
            }else{
                scrollLeft = NO;
            }
        }
    }
//    if (delta <= 1 && delta >= - 1) {
//        if (_oldCenterY - cY <= 0) {
//            scrollLeft = YES;
//        }else{
//            scrollLeft = NO;
//        }
//        NSLog(@"是否左%d",scrollLeft);
//    }
    if (scrollLeft) {
        if (delta >= 0 && delta <= _itemHeight / 2.0) {
            CGFloat rate = (delta)/(_itemHeight /2.0);
            centerY = centerY - _itemHeight *scale /2.0 *rate + halfDelta*rate;
        }else if (delta <= _itemHeight && delta >=_itemHeight / 2.0){
            CGFloat rate = 1 - (delta - (_itemHeight /2.0))/(_itemHeight /2.0);
            centerY = centerY - _itemHeight *scale /2.0 *rate + halfDelta *rate;
        }
    }else{
        if (delta <= 0 && delta >= - _itemHeight / 2.0) {
            CGFloat rate = (ABS(delta))/(_itemHeight /2.0);
            
            centerY = centerY + _itemHeight *scale /2.0 *rate + halfDelta*rate;
            
        }else if (delta >= - _itemHeight && delta <= - _itemHeight / 2.0){
            CGFloat rate = 1 - (ABS(delta) - (_itemHeight /2.0))/(_itemHeight /2.0);
            centerY = centerY + _itemHeight *scale /2.0 *rate + halfDelta *rate;
        }
    }
    
    if (ABS(delta) >= _itemHeight * (3 - 0.2)) {
        attributes.alpha = 0;
    }else if (ABS(delta) >= _itemHeight * (3 - 0.5)){
        CGFloat alphaRate = (ABS(delta) - (_itemHeight *2.5)) /(_itemHeight *0.3);
        attributes.alpha = 1 - alphaRate;
    }else{
        attributes.alpha = 1;
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
