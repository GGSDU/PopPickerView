//
//  UIButton+Layer.m
//  YDTX
//
//  Created by Story5 on 3/27/17.
//  Copyright © 2017 RookieHua. All rights reserved.
//

#import "UIButton+Layer.h"

@implementation UIButton (Layer)

- (void)addLineOn:(LayerDirection)direction color:(UIColor *)color width:(CGFloat)width
{
    CALayer *layer = [CALayer layer];
    layer.backgroundColor = color.CGColor;
    CGPoint origin = CGPointZero;
    CGSize size = CGSizeZero;
    switch (direction) {
        case Top:
            origin = CGPointMake(0, 0);
            size = CGSizeMake(self.bounds.size.width, width);
            break;
        case Left:
            origin = CGPointMake(0, 0);
            size = CGSizeMake(width, self.bounds.size.height);
            break;
        case Bottom:
            origin = CGPointMake(0, self.bounds.size.height - width);
            size = CGSizeMake(self.bounds.size.width, width);
            break;
        case Right:
            origin = CGPointMake(self.bounds.size.width - width, 0);
            size = CGSizeMake(width, self.bounds.size.height);
            break;
        default:
            break;
    }
    
    layer.frame = CGRectMake(origin.x, origin.y, size.width, size.height);
    [self.layer addSublayer:layer];
}

@end
