//
//  AnimationViewController.m
//  MaterialDesignLoadingDemo
//
//  Created by 李亚坤 on 16/7/23.
//  Copyright © 2016年 NormanLeeIOS. All rights reserved.
//

#import "AnimationViewController.h"
#import "MaterialDesignLoadingView.h"

@interface AnimationViewController ()

@property (nonatomic, strong) MaterialDesignLoadingView *loadingWithNumberAnimation;

@property (nonatomic, strong) MaterialDesignLoadingView *loadingAnimation;

@property (nonatomic, strong) MaterialDesignLoadingView *loadingAnimationGray;

@end

@implementation AnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *restartBtn = [[UIButton alloc] initWithFrame:CGRectMake(10.0, 30.0, 100.0, 40.0)];
    restartBtn.backgroundColor = [UIColor yellowColor];
    [restartBtn addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
    [restartBtn setTitle:[NSString stringWithFormat:@"页面加载"] forState:UIControlStateNormal];
    [restartBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    UIButton *stopBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(restartBtn.frame)+10.0f, 30.0, 100.0, 40.0)];
    stopBtn.backgroundColor = [UIColor yellowColor];
    [stopBtn addTarget:self action:@selector(stop) forControlEvents:UIControlEventTouchUpInside];
    [stopBtn setTitle:[NSString stringWithFormat:@"移除动画"] forState:UIControlStateNormal];
    [stopBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    self.loadingWithNumberAnimation = [[MaterialDesignLoadingView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2 - 12.0f,
                                                                                                  150,
                                                                                                  23,
                                                                                                  23)
                                                                                  Type:AnimationTypeCommon];

    self.loadingAnimation = [[MaterialDesignLoadingView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width / 2 - 8.0f,
                                                                                        CGRectGetMaxY(self.loadingWithNumberAnimation.frame) + 10.0f,
                                                                                        16.0f,
                                                                                        16.0f)
                                                                        Type:AnimationTypeWhite];
    self.loadingAnimationGray = [[MaterialDesignLoadingView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width / 2 - 5.0f,
                                                                                           CGRectGetMaxY(self.loadingAnimation.frame) + 10.0f,
                                                                                           11.0f,
                                                                                           11.0f)
                                                                            Type:AnimationTypeGray];
    
    [self.view addSubview:restartBtn];
    [self.view addSubview:stopBtn];
    [self.view addSubview:self.loadingWithNumberAnimation];
    [self.view addSubview:self.loadingAnimation];
    [self.view addSubview:self.loadingAnimationGray];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma -
# pragma mark buttons methods

- (void)start
{
    [self.loadingWithNumberAnimation startLoadingAnimation];
    [self.loadingAnimation startLoadingAnimation];
    [self.loadingAnimationGray startLoadingAnimation];
}

- (void)stop
{
    [self.loadingWithNumberAnimation stopLoadingAnimation];
    [self.loadingAnimation stopLoadingAnimation];
    [self.loadingAnimationGray stopLoadingAnimation];
}



@end
