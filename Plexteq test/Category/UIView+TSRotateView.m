//
//  UIView+TSRotateView.m
//  Plexteq test
//
//  Created by Admin on 04.04.18.
//  Copyright © 2018 Tsvigun Aleksander. All rights reserved.
//

#import "UIView+TSRotateView.h"

@implementation UIView (TSRotateView)

//+ (UIView *)opdateFrameAfterRotation
//{
//    CGFloat width =
//    return CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
//}

- (CGRect)originalFrame {
    CGAffineTransform currentTransform = self.transform;
    self.transform = CGAffineTransformIdentity;
    CGRect originalFrame = self.frame;
    self.transform = currentTransform;
    return originalFrame;
}

- (CGPoint)centerOffset:(CGPoint)thePoint {
    return CGPointMake(thePoint.x - self.center.x, thePoint.y - self.center.y);
}

- (CGPoint)pointRelativeToCenter:(CGPoint)thePoint {
    return CGPointMake(thePoint.x + self.center.x, thePoint.y + self.center.y);
}

- (CGPoint)newPointInView:(CGPoint)thePoint {
    CGPoint offset = [self centerOffset:thePoint];
    CGPoint transformedPoint = CGPointApplyAffineTransform(offset, self.transform);
    return [self pointRelativeToCenter:transformedPoint];
}

- (CGPoint)newTopLeft {
    CGRect frame = [self originalFrame];
    return [self newPointInView:frame.origin];
}
- (CGPoint)newTopRight {
    CGRect frame = [self originalFrame];
    CGPoint point = frame.origin;
    point.x += frame.size.width;
    return [self newPointInView:point];
}
- (CGPoint)newBottomLeft {
    CGRect frame = [self originalFrame];
    CGPoint point = frame.origin;
    point.y += frame.size.height;
    return [self newPointInView:point];
}
- (CGPoint)newBottomRight {
    CGRect frame = [self originalFrame];
    CGPoint point = frame.origin;
    point.x += frame.size.width;
    point.y += frame.size.height;
    return [self newPointInView:point];
}

@end
