//
//  ViewController.m
//  LNLoadingLayer
//
//  Created by Lengain on 2018/12/27.
//  Copyright © 2018 Lengain. All rights reserved.
//

#import "ViewController.h"
#import "LNLoadingLayer.h"
#import "LNLoadingExplicitLayer.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
 
    [self.view addSubview:[self title:@"LNLoadingExplicitLayer" frame:CGRectMake(10, 154, 180, 20)]];
    [self testLNLoadingExplicitLayerAnimation:CGRectMake(200, 154, 60, 60)];
    
    [self.view addSubview:[self title:@"LNLoadingLayer,显式" frame:CGRectMake(10, 234, 180, 20)]];
    [self testExplicitAnimation:CGRectMake(200, 234, 60, 60)];
    
    [self.view addSubview:[self title:@"LNLoadingLayer,隐式" frame:CGRectMake(10, 314, 180, 20)]];
    [self testImplicitAnimation:CGRectMake(200, 314, 60, 60)];
    
}

#pragma mark - LNLoadingExplicitLayer

- (void)testLNLoadingExplicitLayerAnimation:(CGRect)frame {
    LNLoadingExplicitLayer *loadingLayer = [[LNLoadingExplicitLayer alloc] init];
    loadingLayer.frame = frame;
    //设置进度条宽度
    loadingLayer.progressLineWidth = 6.f/[UIScreen mainScreen].scale;
    loadingLayer.contentsScale = [UIScreen mainScreen].scale;
    [self.view.layer addSublayer:loadingLayer];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"progress"];
    animation.fromValue = @(0);
    animation.toValue = @(200);
    animation.duration = 2.0;
    animation.repeatCount = MAXFLOAT;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [loadingLayer addAnimation:animation forKey:@"progressKey"];;
}

#pragma mark - LNLoadingLayer,显式

- (void)testExplicitAnimation:(CGRect)frame {
    LNLoadingLayer *loadingLayer = [[LNLoadingLayer alloc] init];
    loadingLayer.frame = frame;
    //设置进度条宽度
    loadingLayer.progressLineWidth = 6.f/[UIScreen mainScreen].scale;
    loadingLayer.contentsScale = [UIScreen mainScreen].scale;
    [self.view.layer addSublayer:loadingLayer];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"progress"];
    animation.fromValue = @(0);
    animation.toValue = @(200);
    animation.duration = 2.0;
    animation.repeatCount = MAXFLOAT;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [loadingLayer addAnimation:animation forKey:@"progressKey"];;
}

#pragma mark - LNLoadingLayer,隐式

- (void)testImplicitAnimation:(CGRect)frame {
    LNLoadingLayer *loadingLayer = [[LNLoadingLayer alloc] init];
    loadingLayer.frame = frame;
    //设置进度条宽度
    loadingLayer.progressLineWidth = 6.f/[UIScreen mainScreen].scale;
    loadingLayer.contentsScale = [UIScreen mainScreen].scale;
    [self.view.layer addSublayer:loadingLayer];
    loadingLayer.progress = 50;
    [self beginChange:loadingLayer];
}

- (void)beginChange:(LNLoadingLayer *)loadingLayer {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(2);
        dispatch_async(dispatch_get_main_queue(), ^{
            if (loadingLayer.progress == 50) {
                loadingLayer.progress = 0;
            }else {
                loadingLayer.progress = 50;
            }
            [self beginChange:loadingLayer];
        });
    });
}

#pragma mark - Other


- (UILabel *)title:(NSString *)title frame:(CGRect)frame {
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:frame];
    titleLabel.textColor = [UIColor darkTextColor];
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.text = title;
    return titleLabel;
}

@end
