//
//  MaterialDesignLoadingView.h
//  MaterialDesignLoadingDemo
//
//  Created by 李亚坤 on 16/7/23.
//  Copyright © 2016年 NormanLeeIOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MaterialDesignLoadingView : UIView

@property (nonatomic, readonly) BOOL isAnimating;

@property (nonatomic, readwrite) NSTimeInterval duration;

@property (nonatomic, strong) CAMediaTimingFunction *timingFunction;

@property (nonatomic, assign) CGFloat lineWidth;

@property (nonatomic, assign) BOOL hidesWhenStopped;

- (void)startLoadingAnimation;

- (void)stopLoadingAnimation;

@end
