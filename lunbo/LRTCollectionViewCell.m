//
//  LRTCollectionViewCell.m
//  lunbo
//
//  Created by 李荣潭 on 2018/1/2.
//  Copyright © 2018年 李荣潭. All rights reserved.
//

#import "LRTCollectionViewCell.h"

@implementation LRTCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _lable = [[UILabel alloc] initWithFrame:self.contentView.frame];
        [self.contentView addSubview:_lable];
    }
    return self;
}
- (void)setContentString:(NSString *)contentString{
    _contentString = contentString;
    _lable.text = contentString;
}
@end
