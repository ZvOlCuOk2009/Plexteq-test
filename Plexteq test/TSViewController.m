//
//  ViewController.m
//  Plexteq test
//
//  Created by Admin on 02.04.18.
//  Copyright © 2018 Tsvigun Aleksander. All rights reserved.
//

#import "TSViewController.h"
#import "TSView.h"
#import "TSPrefixHeader.pch"

@interface TSViewController () <UIGestureRecognizerDelegate>

@property (strong, nonatomic) TSView *roundViewOne;
@property (strong, nonatomic) TSView *roundViewTwo;
@property (strong, nonatomic) TSView *randomView;
@property (strong, nonatomic) UIView *touchView;
@property (strong, nonatomic) NSMutableArray *views;

@property (assign, nonatomic) CGFloat viewRotation;

@property (assign, nonatomic) CGPoint location;

@property (assign, nonatomic) CGPoint pointOneCoordinate;
@property (assign, nonatomic) CGPoint pointTwoCoordinate;

@end

@implementation TSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.views = [NSMutableArray array];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] init];
    tapGestureRecognizer.delegate = self;
    [tapGestureRecognizer addTarget:self action:@selector(handlerTapGestureRecognizer:)];
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    UITapGestureRecognizer *doubleTapGestureRecognizer = [[UITapGestureRecognizer alloc] init];
    doubleTapGestureRecognizer.delegate = self;
    doubleTapGestureRecognizer.numberOfTapsRequired = 2;
    [doubleTapGestureRecognizer addTarget:self action:@selector(handlerDoubleTapGestureRecognizer:)];
    [self.view addGestureRecognizer:doubleTapGestureRecognizer];
    
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] init];
    panGestureRecognizer.delegate = self;
    [panGestureRecognizer addTarget:self action:@selector(handlerPanGestureRecognizer:)];
    [self.view addGestureRecognizer:panGestureRecognizer];
    
    UIRotationGestureRecognizer *rotationGestureRecognizer =
    [[UIRotationGestureRecognizer alloc] initWithTarget:self
                                                 action:@selector(handlerRotationGestureRecognizer:)];
    rotationGestureRecognizer.delegate = self;
    
    [self.view addGestureRecognizer:rotationGestureRecognizer];
    
    UILongPressGestureRecognizer *longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc]
                                               initWithTarget:self
                                               action:@selector(handleLongPressGestureRecognizer:)];
    longPressGestureRecognizer.minimumPressDuration = 1.0;
    [self.view addGestureRecognizer:longPressGestureRecognizer];
    
    NSLog(@"print");
}

#pragma mark - touch

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self.view];
    self.touchView = [self.view hitTest:touchPoint withEvent:nil];
    self.location = [touch locationInView:self.touchView];
    [self.view bringSubviewToFront:self.touchView];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent*)event
{
    // We only take care of a single touch

//    if ([touches count] == 1) {
//        UITouch *touch = [touches anyObject];
//        // Find the width and height of the rect
//        CGRect drawnFrame = self.touchView.frame;
//        drawnFrame.size.width = [touch locationInView:self.view].x - drawnFrame.origin.x;
//        drawnFrame.size.height = [touch locationInView:self.view].y - drawnFrame.origin.y;
//        self.touchView.frame = drawnFrame;
//    }
}

#pragma mark - handle gesture recognizer

- (void)handlerTapGestureRecognizer:(UITapGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state == UIGestureRecognizerStateRecognized) {
        [self createNewView:[gestureRecognizer locationInView:gestureRecognizer.view]];
    }
}

- (void)handlerPanGestureRecognizer:(UIPanGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state == UIGestureRecognizerStateRecognized) {
//        if (!self.point.x && !self.point.y) {
//            self.point = [gestureRecognizer locationInView:gestureRecognizer.view];
//        }
    }

    if ([self.touchView isEqual:self.view]) {
        return;
    } else {
        NSLog(@"self.location x %f y %f", self.location.x, self.location.y);
        CGPoint point = [gestureRecognizer locationInView:self.view];
        NSLog(@"point x %f y %f", point.x, point.y);
        
        self.touchView.center = [gestureRecognizer locationInView:self.view];
        
//        CGPoint center = CGPointMake(self.location.x, self.location.y);
//        center.x = movePoint.x - w.centerOffset.x ;
//        center.y = movePoint.y - w.centerOffset.y ;
//        self.touchView = center;
        
        
//        self.touchView.frame = CGRectMake(self.location.x, self.location.y, self.touchView.frame.size.width, self.touchView.frame.size.height);
    }
}

- (void)handlerDoubleTapGestureRecognizer:(UITapGestureRecognizer *)gestureRecognizer
{
    if (![self.touchView isEqual:self.view]) {
        [self.touchView removeFromSuperview];
        self.touchView = nil;
    }
}

- (void)handlerRotationGestureRecognizer:(UIRotationGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        self.viewRotation = 0;
    }
    
    if ([self.touchView isEqual:self.view]) {
        return;
    } else {
        CGFloat newRotation = gestureRecognizer.rotation - self.viewRotation;
        CGAffineTransform currentTransform = self.touchView.transform;
        CGAffineTransform newTransform = CGAffineTransformRotate(currentTransform, newRotation);
        self.touchView.transform = newTransform;
        self.viewRotation = gestureRecognizer.rotation;
    }
}

- (void)handleLongPressGestureRecognizer:(UILongPressGestureRecognizer *)gestureRecognizer
{
    if (UIGestureRecognizerStateBegan == gestureRecognizer.state) {
        self.touchView.backgroundColor = [self randomColor];
    }
}

- (void)createNewView:(CGPoint)point
{
    if ([self.touchView isEqual:self.view]) {
        if (!self.roundViewOne) {
            self.pointOneCoordinate = point;
            self.roundViewOne = [[TSView alloc] initWithFrame:CGRectMake(self.pointOneCoordinate.x, self.pointOneCoordinate.y, 2, 2)];
            self.roundViewOne.backgroundColor = BLUE_COLOR;
            self.roundViewOne.layer.cornerRadius = self.roundViewOne.frame.size.width / 2;
            [self.view addSubview:self.roundViewOne];
            [self animateRoundView:self.roundViewOne];
        } else if (!self.roundViewTwo) {
            self.pointTwoCoordinate = point;
            self.roundViewTwo = [[TSView alloc] initWithFrame:CGRectMake(self.pointTwoCoordinate.x, self.pointTwoCoordinate.y, 1, 1)];
            [self removeRoundView];
            [self addRandomView:CGPointMake(self.pointOneCoordinate.x, self.pointOneCoordinate.y) coordinate:CGPointMake(self.pointTwoCoordinate.x, self.pointTwoCoordinate.y)];
        }
    } else {
        NSArray *subviews = self.touchView.subviews;
        if (subviews.count == 0) {
            
            CGPoint newTopLeftPoint = [self newTopLeft];
            CGPoint newTopRightPoint = [self newTopRight];
            CGPoint newBottomLeftPoint = [self newBottomLeft];
            CGPoint newBottomRightPoint = [self newBottomRight];
            
//            CGPoint poinstArray[] = {newTopLeftPoint, newTopRightPoint, newBottomLeftPoint, newBottomRightPoint};
//            CGRect smallestRect = CGRectSmallestWithCGPoints(poinstArray, 4);
            

//            UIView *myView = [[UIView alloc]initWithFrame:transformedBounds];
//            myView.backgroundColor = [UIColor yellowColor];

//            UIBezierPath *linePath = [UIBezierPath bezierPath];
//
//            [linePath moveToPoint:CGPointMake(newTopRightPoint.x, newTopRightPoint.y)];
//            [linePath addLineToPoint:CGPointMake(newTopLeftPoint.x, newTopLeftPoint.y)];
//            [linePath addLineToPoint:CGPointMake(newBottomLeftPoint.x, newBottomLeftPoint.y)];
//            [linePath addLineToPoint:CGPointMake(newBottomRightPoint.x, newBottomRightPoint.y)];
//            [linePath closePath];
////            CAShapeLayer *shape = [[CAShapeLayer alloc]init];
////            [shape setPath:linePath.CGPath];
////            myView.layer.mask = shape;
//
//            CGRect rectPath = linePath.bounds;
//
//            myView.frame = rectPath;
//
//            [self.view addSubview:myView];
            
            //            for (int i = 0; i < 5; i++) {
            UIView *round = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
            round.backgroundColor = [UIColor whiteColor];
            round.layer.cornerRadius = round.frame.size.width / 2;
            [self.touchView addSubview:round];
            
            UIView *round2 = [[UIView alloc] initWithFrame:CGRectMake(self.touchView.frame.size.width - 20, 0, 20, 20)];
            round2.backgroundColor = [UIColor whiteColor];
            round2.layer.cornerRadius = 10;
            [self.touchView addSubview:round2];
            
            UIView *round3 = [[UIView alloc] initWithFrame:CGRectMake(0, self.touchView.frame.size.height - 20, 20, 20)];
            round3.backgroundColor = [UIColor whiteColor];
            round3.layer.cornerRadius = 10;
            [self.touchView addSubview:round3];
            
            UIView *round4 = [[UIView alloc] initWithFrame:CGRectMake(self.touchView.frame.size.width - 20, self.touchView.frame.size.height - 20, 20, 20)];
            round4.backgroundColor = [UIColor whiteColor];
            round4.layer.cornerRadius = 10;
            [self.touchView addSubview:round4];
            
            UIView *round5 = [[UIView alloc] initWithFrame:CGRectMake((self.touchView.frame.size.width / 2) - 10, (self.touchView.frame.size.height / 2) - 10, 20, 20)];
            round5.backgroundColor = [UIColor whiteColor];
            round5.layer.cornerRadius = 10;
            [self.touchView addSubview:round5];
            //            }
        } else {
            for (UIView *round in self.touchView.subviews) {
                [round removeFromSuperview];
            }
        }
    }
}

- (void)animateRoundView:(UIView *)view
{
    CGFloat width = 30;
    CGFloat heihgt = 30;
    CGFloat x = view.frame.origin.x - (width / 2);
    CGFloat y = view.frame.origin.y - (heihgt / 2);
    
    [UIView animateWithDuration:0.5 animations:^{
        view.frame = CGRectMake(x, y, width, heihgt);
        view.layer.cornerRadius = view.frame.size.width / 2;
        view.alpha = 0.2;
    }];
}

- (void)removeRoundView
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.roundViewOne removeFromSuperview];
        [self.roundViewTwo removeFromSuperview];
        self.roundViewOne = nil;
        self.roundViewTwo = nil;
    });
}

- (void)addRandomView:(CGPoint)oneCoordinate coordinate:(CGPoint)twoCoordinate
{
    CGFloat width = twoCoordinate.x - oneCoordinate.x;
    CGFloat height = twoCoordinate.y - oneCoordinate.y;
    
    self.randomView = [[TSView alloc] initWithFrame:CGRectMake(oneCoordinate.x, oneCoordinate.y, width, height)];
    self.randomView.backgroundColor = [self randomColor];
    [self.view addSubview:self.randomView];
    [self.views addObject:self.randomView];
    
    //delete view last touch
//    if (![self.touchView isEqual:self.view]) {
//        [self.touchView removeFromSuperview];
//        self.touchView = nil;
//    }
}

- (UIColor *)randomColor
{
    return [UIColor colorWithRed:[self random] / 255.0 green:[self random] / 255.0 blue:[self random] / 255.0 alpha:1];
}

- (NSInteger)random
{
    return arc4random_uniform(255);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - get coordinate rotate view

- (CGRect)originalFrame {
    CGAffineTransform currentTransform = self.touchView.transform;
    self.touchView.transform = CGAffineTransformIdentity;
    CGRect originalFrame = self.touchView.frame;
    self.touchView.transform = currentTransform;
    return originalFrame;
}

- (CGPoint)centerOffset:(CGPoint)thePoint {
    return CGPointMake(thePoint.x - self.touchView.center.x, thePoint.y - self.touchView.center.y);
}

- (CGPoint)pointRelativeToCenter:(CGPoint)thePoint {
    return CGPointMake(thePoint.x + self.touchView.center.x, thePoint.y + self.touchView.center.y);
}

- (CGPoint)newPointInView:(CGPoint)thePoint {
    // get offset from center
    CGPoint offset = [self centerOffset:thePoint];
    // get transformed point
    CGPoint transformedPoint = CGPointApplyAffineTransform(offset, self.touchView.transform);
    // make relative to center
    return [self pointRelativeToCenter:transformedPoint];
}

// now get your corners
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

CGRect CGRectSmallestWithCGPoints(CGPoint pointsArray[], int numberOfPoints)
{
    CGFloat greatestXValue = pointsArray[0].x;
    CGFloat greatestYValue = pointsArray[0].y;
    CGFloat smallestXValue = pointsArray[0].x;
    CGFloat smallestYValue = pointsArray[0].y;
    
    for (int i = 1; i < numberOfPoints; i++)
    {
        CGPoint point = pointsArray[i];
        greatestXValue = MAX(greatestXValue, point.x);
        greatestYValue = MAX(greatestYValue, point.y);
        smallestXValue = MIN(smallestXValue, point.x);
        smallestYValue = MIN(smallestYValue, point.y);
    }
    
    CGRect rect;
    rect.origin = CGPointMake(smallestXValue, smallestYValue);
    rect.size.width = greatestXValue - smallestXValue;
    rect.size.height = greatestYValue - smallestYValue;
    
    return rect;
}

@end
