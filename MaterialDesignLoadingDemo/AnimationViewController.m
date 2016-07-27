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

@property (nonatomic, strong) MaterialDesignLoadingView *loadingAnimation;

@end

@implementation AnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *restartBtn = [[UIButton alloc] initWithFrame:CGRectMake(10.0, 30.0, 100.0, 40.0)];
    restartBtn.backgroundColor = [UIColor yellowColor];
    [restartBtn addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
    [restartBtn setTitle:[NSString stringWithFormat:@"start"] forState:UIControlStateNormal];
    [restartBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    UIButton *stopBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(restartBtn.frame)+10.0f, 30.0, 100.0, 40.0)];
    stopBtn.backgroundColor = [UIColor yellowColor];
    [stopBtn addTarget:self action:@selector(stop) forControlEvents:UIControlEventTouchUpInside];
    [stopBtn setTitle:[NSString stringWithFormat:@"stop"] forState:UIControlStateNormal];
    [stopBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    _loadingAnimation = [[MaterialDesignLoadingView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2 - 50.0f, 150, 100, 100)];
    _loadingAnimation.tintColor = [[UIColor grayColor] colorWithAlphaComponent:0.3];
    _loadingAnimation.lineWidth = 10.0f;
    _loadingAnimation.duration = 1.0f;
    
    [self.view addSubview:restartBtn];
    [self.view addSubview:stopBtn];
    [self.view addSubview:_loadingAnimation];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma -
# pragma mark buttons methods

- (void)start
{
    [_loadingAnimation startLoadingAnimation];
}

- (void)stop
{
    [_loadingAnimation stopLoadingAnimation];
}



@end
