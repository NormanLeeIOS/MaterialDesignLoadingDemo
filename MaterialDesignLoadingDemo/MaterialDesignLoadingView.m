//
//  MaterialDesignLoadingView.m
//  MaterialDesignLoadingDemo
//
//  Created by 李亚坤 on 16/7/23.
//  Copyright © 2016年 NormanLeeIOS. All rights reserved.
//

#import "MaterialDesignLoadingView.h"

#define ROUND_COLOR [[UIColor grayColor] colorWithAlphaComponent:0.2]

static NSString *loadingAnimationRotationKey = @"loading.rotation";
static NSString *loadingAnimationStrokeKey = @"loading.stroke";

@interface MaterialDesignLoadingView ()

@property (nonatomic, assign, readwrite) BOOL isAnimating;

@property (nonatomic, strong) CAShapeLayer *progressLayer;

@property (nonatomic, strong) UIImageView *bgArcImageView;

@end

@implementation MaterialDesignLoadingView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}


- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize
{
    self.duration = 1.0f;
    self.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    [self.layer addSublayer:self.progressLayer];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resetAnimations) name:UIApplicationDidBecomeActiveNotification object:nil];
}

- (void)addArcBackground
{
    // ArcBackground
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, [UIScreen mainScreen].scale);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(ctx, ROUND_COLOR.CGColor);
    CGContextSetLineWidth(ctx, self.lineWidth);
    CGContextAddArc(ctx, self.bounds.size.width/2, self.bounds.size.height/2, MIN(self.bounds.size.width/2, self.bounds.size.height/2) - self.lineWidth/2, 0, 2*M_PI, 1); // r = 50
    CGContextDrawPath(ctx, kCGPathStroke);
    UIImage *curve = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.bgArcImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    self.bgArcImageView.image = curve;
    self.bgArcImageView.backgroundColor = [UIColor clearColor];
    
    [self addSubview:self.bgArcImageView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.progressLayer.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    
    [self updataPath];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidBecomeActiveNotification object:nil]; 
}

- (void)tintColorDidChange
{
    [super tintColorDidChange];
    self.progressLayer.strokeColor = self.tintColor.CGColor;
}

#pragma mark - Animation Method

- (void)startLoadingAnimation
{
    if (self.isAnimating) {
        return;
    }
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    animation.duration = self.duration / 0.375f;    // 2 + 2/3 round per duration
    animation.fromValue = @(0.f);
    animation.toValue = @(2 * M_PI);
    animation.repeatCount = INFINITY;
    animation.removedOnCompletion = NO;
    [self.progressLayer addAnimation:animation forKey:loadingAnimationRotationKey];
    
    CABasicAnimation *headAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    headAnimation.duration = self.duration / 1.5f;
    headAnimation.fromValue = @(0.f);
    headAnimation.toValue = @(0.25f);           // empty space to tail, 1/4 round
    headAnimation.timingFunction = self.timingFunction;
    
    CABasicAnimation *tailAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    tailAnimation.duration = self.duration / 1.5f;
    tailAnimation.fromValue = @(0.0f);
    tailAnimation.toValue = @(1.f);              // 1 round
    tailAnimation.timingFunction = self.timingFunction;
    
    CABasicAnimation *endHeadAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    endHeadAnimation.beginTime = self.duration / 1.5f;  // start from last animation fade
    endHeadAnimation.duration = self.duration / 3.0f;
    endHeadAnimation.fromValue = @(0.25f);
    endHeadAnimation.toValue = @(1.f);
    endHeadAnimation.timingFunction = self.timingFunction;
    
    CABasicAnimation *endTailAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    endTailAnimation.beginTime = self.duration / 1.5f;
    endTailAnimation.duration = self.duration / 3.0f;
    endTailAnimation.fromValue = @(1.f);
    endTailAnimation.toValue = @(1.f);
    endTailAnimation.timingFunction = self.timingFunction;
    
    CAAnimationGroup *animations = [CAAnimationGroup animation];
    animations.duration = self.duration;
    animations.animations = @[headAnimation, tailAnimation, endHeadAnimation, endTailAnimation];
    animations.repeatCount = INFINITY;
    animations.removedOnCompletion = NO;
    [self.progressLayer addAnimation:animations forKey:loadingAnimationStrokeKey];
    
    self.isAnimating = YES;
    
    if (self.hidesWhenStopped) {
        self.hidden = NO;
    }
    
    if (!self.bgArcImageView) {
        [self addArcBackground];
    }
}

- (void)stopLoadingAnimation
{
    if (!self.isAnimating) {
        return;
    }
    
    [self.progressLayer removeAllAnimations];
    self.isAnimating = NO;
    
    if (self.hidesWhenStopped) {
        self.hidden = YES;
    }
    
    [self.bgArcImageView removeFromSuperview];
    self.bgArcImageView = nil;
}

- (void)resetAnimations
{
    if (self.isAnimating) {
        [self stopLoadingAnimation];
        [self startLoadingAnimation];
    }
}

#pragma mark - private methods

- (void)updataPath
{
    CGPoint center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    CGFloat radius = MIN(self.bounds.size.width / 2, self.bounds.size.height / 2) - _progressLayer.lineWidth / 2;
    CGFloat startAngle = (CGFloat)(0);
    CGFloat endAngle = (CGFloat)(2*M_PI);
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center
                                                        radius:radius
                                                    startAngle:startAngle
                                                      endAngle:endAngle
                                                     clockwise:YES];
    self.progressLayer.path = path.CGPath;
    self.progressLayer.strokeStart = 0.f;
    self.progressLayer.strokeEnd = 0.f;
}

#pragma mark - getters & setters

- (CAShapeLayer *)progressLayer
{
    if (!_progressLayer) {
        _progressLayer = [CAShapeLayer layer];
        _progressLayer.strokeColor = self.tintColor.CGColor;
        _progressLayer.fillColor = nil;
        _progressLayer.lineWidth = 1.5f;
        _progressLayer.lineJoin = kCALineJoinRound;
        _progressLayer.lineCap = kCALineCapRound;
    }
    return _progressLayer;
}

- (CGFloat)lineWidth
{
    return self.progressLayer.lineWidth;
}

- (void)setLineWidth:(CGFloat)lineWidth
{
    self.progressLayer.lineWidth = lineWidth;
    [self updataPath];
}

- (void)setHidesWhenStopped:(BOOL)hidesWhenStopped
{
    _hidesWhenStopped = hidesWhenStopped;
    self.hidden = !self.isAnimating && hidesWhenStopped;
}

@end
