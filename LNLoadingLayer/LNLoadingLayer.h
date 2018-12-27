//
//  LNLoadingLayer.h
//  LNLoadingLayer
//
//  Created by Lengain on 2018/12/27.
//  Copyright © 2018 Lengain. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

NS_ASSUME_NONNULL_BEGIN

@interface LNLoadingLayer : CALayer

/**
 0-100进度条正向增加,100-200进度条正向减少,其他失效
 */
@property (nonatomic, assign) CGFloat progress;
@property (nonatomic, assign) CGColorRef loadingColor;

/**
 default is 4
 */
@property (nonatomic, assign) CGFloat progressLineWidth;

@end

NS_ASSUME_NONNULL_END
