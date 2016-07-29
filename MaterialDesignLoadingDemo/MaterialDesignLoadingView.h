//
//  MaterialDesignLoadingView.h
//  MaterialDesignLoadingDemo
//
//  Created by 李亚坤 on 16/7/23.
//  Copyright © 2016年 NormanLeeIOS. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, AnimationType) {
    AnimationTypeCommon  = 0,   //包含数字
    AnimationTypeWhite   = 1,   //不包含数字,白色
    AnimationTypeGray    = 2,   //不包含数字,灰色
};


@interface MaterialDesignLoadingView : UIView

@property (nonatomic, readonly) BOOL isAnimating;

@property (nonatomic, readwrite) NSTimeInterval duration;

@property (nonatomic, strong) CAMediaTimingFunction *timingFunction;

@property (nonatomic, assign) CGFloat lineWidth;

@property (nonatomic, assign) BOOL hidesWhenStopped;

- (instancetype)initWithFrame:(CGRect)frame Type:(AnimationType)animationType;

- (void)startLoadingAnimation;

- (void)stopLoadingAnimation;

@end
