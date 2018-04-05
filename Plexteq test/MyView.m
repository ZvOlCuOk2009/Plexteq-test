//
//  MyView.m
//  Plexteq test
//
//  Created by Admin on 05.04.18.
//  Copyright © 2018 Tsvigun Aleksander. All rights reserved.
//

#import "MyView.h"

@interface MyView ()

@property (assign, nonatomic) NSInteger counter;

@end

@implementation MyView

//{
//    UIBezierPath *path; // (3)
//}
//
//- (id)initWithCoder:(NSCoder *)aDecoder // (1)
//{
//    if (self = [super initWithCoder:aDecoder])
//    {
//        [self setMultipleTouchEnabled:NO]; // (2)
//        [self setBackgroundColor:[UIColor whiteColor]];
//        path = [UIBezierPath bezierPath];
//        [path setLineWidth:2.0];
//    }
//    return self;
//}
//
- (void)drawRect:(CGRect)rect // (5)
{
//    [[UIColor blackColor] setStroke];
//    [path stroke];
    
    CGRect aRectangle=CGRectMake(50., 50., 40., 40.);
    UIBezierPath *path=[UIBezierPath bezierPathWithRect:aRectangle];
    UIColor *strokeColor=[UIColor orangeColor];
    [strokeColor setStroke];
    [path stroke];
    
    CGContextRef context=UIGraphicsGetCurrentContext();
    
    [self drawGreenRect:context];
    
    CGRect anotherRectangle=CGRectMake(100., 100., 40., 40.);
    UIBezierPath *anotherPath=[UIBezierPath bezierPathWithRect:anotherRectangle];
    [anotherPath stroke];
}

- (void)drawGreenRect:(CGContextRef)ctxt{
    
    UIGraphicsPushContext(UIGraphicsGetCurrentContext());
    
    CGRect aRectangle=CGRectMake(200., 200., 40., 40.);
    UIBezierPath *path=[UIBezierPath bezierPathWithRect:aRectangle];
    UIColor *strokeColor=[UIColor greenColor];
    [strokeColor setStroke];
    [path stroke];
    
    UIGraphicsPopContext();
    
}
//
//
//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    UITouch *touch = [touches anyObject];
//    CGPoint p = [touch locationInView:self];
//    [path moveToPoint:p];
//}
//
//- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    UITouch *touch = [touches anyObject];
//    CGPoint point = [touch locationInView:self];
//    [path addLineToPoint:point]; // (4)
//    self.counter++;
//    NSLog(@"point x %f y %f counter %ld", point.x, point.y, self.counter);
//    [self setNeedsDisplay];
//}
//
//- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    [self touchesMoved:touches withEvent:event];
//}
//
//- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    [self touchesEnded:touches withEvent:event];
//}

@end
