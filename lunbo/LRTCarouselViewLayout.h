//
//  LRTCarouselViewLayout.h
//  lunbo
//
//  Created by 李荣潭 on 2018/1/3.
//  Copyright © 2018年 李荣潭. All rights reserved.
//

#import <UIKit/UIKit.h>
#define INTERSPACEPARAM  0.65

@interface LRTCarouselViewLayout : UICollectionViewLayout
@property (nonatomic) CGSize itemSize;
@property (nonatomic) NSInteger visibleCount;
@end
