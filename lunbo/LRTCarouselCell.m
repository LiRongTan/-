//
//  LRTCarouselCell.m
//  lunbo
//
//  Created by 李荣潭 on 2018/1/3.
//  Copyright © 2018年 李荣潭. All rights reserved.
//

#import "LRTCarouselCell.h"

@implementation LRTCarouselCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor cyanColor];
        _imageView = [[UIImageView alloc] initWithFrame:self.contentView.frame];
        [self.contentView addSubview:_imageView];
        self.contentView.clipsToBounds = YES;
        self.layer.shadowColor = [UIColor blackColor].CGColor;
        self.layer.shadowOffset = CGSizeMake(0, 2);
        self.layer.shadowOpacity = 0.7;
        self.layer.shadowRadius = 12;
        
//        UIBezierPath *path = [UIBezierPath bezierPath];
        
        float width = self.bounds.size.width;
        float height = self.bounds.size.height;
        float x = self.bounds.origin.x;
        float y = self.bounds.origin.y;
        float addWH = 10;
        UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(x - 5, y - 5, width + 10, height + 10)];

//        CGPoint topLeft      = self.bounds.origin;
//        CGPoint topMiddle = CGPointMake(x+(width/2),y-addWH);
//        CGPoint topRight     = CGPointMake(x+width,y);
//        
//        CGPoint rightMiddle = CGPointMake(x+width+addWH,y+(height/2));
//        
//        CGPoint bottomRight  = CGPointMake(x+width,y+height);
//        CGPoint bottomMiddle = CGPointMake(x+(width/2),y+height+addWH);
//        CGPoint bottomLeft   = CGPointMake(x,y+height);
//        
//        
//        CGPoint leftMiddle = CGPointMake(x-addWH,y+(height/2));
//        
//        [path moveToPoint:topLeft];
//        //添加四个二元曲线
//        [path addQuadCurveToPoint:topRight
//                     controlPoint:topMiddle];
//        [path addQuadCurveToPoint:bottomRight
//                     controlPoint:rightMiddle];
//        [path addQuadCurveToPoint:bottomLeft
//                     controlPoint:bottomMiddle];
//        [path addQuadCurveToPoint:topLeft
//                     controlPoint:leftMiddle];
        //设置阴影路径
        self.layer.shadowPath = path.CGPath;
        
    }
    return self;
}
@end
