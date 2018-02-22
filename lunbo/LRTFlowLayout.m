//
//  LRTFlowLayout.m
//  lunbo
//
//  Created by 李荣潭 on 2018/1/2.
//  Copyright © 2018年 李荣潭. All rights reserved.
//

#import "LRTFlowLayout.h"

@implementation LRTFlowLayout

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}

- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> * )layoutAttributesForElementsInRect:(CGRect)rect{
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.frame.size.width * 0.5;
//    NSMutableArray *otherArray = [NSMutableArray arrayWithCapacity:0];
//    CGFloat minFloat = MAXFLOAT;
    for (UICollectionViewLayoutAttributes *attrs in array) {
        CGFloat delta = fabs(attrs.center.x - centerX);
        attrs.transform = CGAffineTransformMakeScale(2.25 - delta /80 * 0.75, 2.25 - delta /80 * 0.75);
//
//        if (delta < 40) {
////            CGRect frame = attrs.frame;
////            frame.origin.x += (attrs.center.x - centerX)/80 *20;
////            attrs.frame = frame;
//            attrs.transform = CGAffineTransformMakeScale(2.25 - delta /80 * 0.75, 2.25 - delta /80 * 0.75);
//            attrs.transform = CGAffineTransformTranslate(attrs.transform, (attrs.center.x - centerX)/80 *30, 0);
//        }else if (delta < 80){
////            CGRect frame = attrs.frame;
////            frame.origin.x += (attrs.center.x - centerX)/80 *20;
////            attrs.frame = frame;
//            attrs.transform = CGAffineTransformMakeScale(2.25 - delta /80 * 0.75, 2.25 - delta /80 * 0.75);
////            attrs.transform = CGAffineTransformTranslate(attrs.transform, (attrs.center.x - centerX)/80 *30, 0);
//        }else if (delta <= 120){
//            attrs.transform = CGAffineTransformMakeScale(2.25 - 0.75, 2.25 -  0.75);
//        }else if (delta <= 160){
//            attrs.transform = CGAffineTransformMakeScale(2.25 - 1, 2.25 -  1);
//        }
//        if (delta < minFloat) {
//            minFloat = delta;
//        }
//        NSLog(@"呵呵哒%f",minFloat);
//       
//        if (delta > self.collectionView.frame.size.width * 2) {
//            attrs.transform = CGAffineTransformMakeScale(1, 1);
//
//        }else{
//            [otherArray addObject:attrs];
////            CGFloat rate = 1 - (delta /self.collectionView.frame.size.width);
////            CGFloat scale = 1 + 0.5 *rate;
////            attrs.transform = CGAffineTransformMakeScale(scale, scale);
//        }
    }
//    for (UICollectionViewLayoutAttributes *attrs in array) {
//        CGFloat delta = fabs(attrs.center.x - centerX);
//        if (delta == minFloat) {
//            attrs.transform = CGAffineTransformMakeScale(2.25 - delta /80 * 1.25, 2.25 - delta /80 * 1.25);
//            attrs.transform = CGAffineTransformTranslate(attrs.transform, (attrs.center.x - centerX)/80 *20, 0);
////            attrs.transform = CGAffineTransformMakeTranslation((attrs.center.x - centerX)/80 *20, 0);
//        }else{
//
//        }
//    }
//    if (otherArray.count > 0) {
//        for (UICollectionViewLayoutAttributes *attrs in otherArray) {
//
//        }
//    }
    return array;
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity{
    //计算出实际中心位置
    CGFloat offsetAdjustment = MAXFLOAT;
    CGFloat horizontalCenter = proposedContentOffset.x + (CGRectGetWidth(self.collectionView.bounds) / 2.0);
    //取当前屏幕中的UICollectionViewLayoutAttributes
    CGRect targetRect = CGRectMake(proposedContentOffset.x, 0.0, self.collectionView.bounds.size.width, self.collectionView.bounds.size.height);
    NSArray* array = [super layoutAttributesForElementsInRect:targetRect];
    
    //对当前屏幕中的UICollectionViewLayoutAttributes逐个与屏幕中心进行比较，找出最接近中心的一个
    for (UICollectionViewLayoutAttributes* layoutAttributes in array) {
        CGFloat itemHorizontalCenter = layoutAttributes.center.x;
        if (ABS(itemHorizontalCenter - horizontalCenter) < ABS(offsetAdjustment)) {
            offsetAdjustment = itemHorizontalCenter - horizontalCenter;
        }
    }
    
    //返回调整好的point
    return CGPointMake(proposedContentOffset.x + offsetAdjustment, proposedContentOffset.y);

}
@end
