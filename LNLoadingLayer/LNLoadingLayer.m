//
//  LNLoadingLayer.m
//  LNLoadingLayer
//
//  Created by Lengain on 2018/12/27.
//  Copyright © 2018 Lengain. All rights reserved.
//

#import "LNLoadingLayer.h"

@implementation LNLoadingLayer

@dynamic progress;

static NSString *LNProgressKey = @"progress";

- (instancetype)initWithLayer:(id)layer {
    self = [super initWithLayer:layer];
    if (self) {
        if ([layer isKindOfClass:[LNLoadingLayer class]]) {
            LNLoadingLayer *loadingLayer = (LNLoadingLayer *)layer;
            self.progressLineWidth = loadingLayer.progressLineWidth;
            self.loadingColor = loadingLayer.loadingColor;
            //无需添加，super会自动copy
            //self.progress = loadingLayer.progress;
        }
    }
    return self;
}

#pragma mark - override

+ (BOOL)needsDisplayForKey:(NSString *)key {
    return [key isEqualToString:LNProgressKey] ? YES : [super needsDisplayForKey:key];
}

- (id<CAAction>)actionForKey:(NSString *)event {
    if ([event isEqualToString:LNProgressKey]) {
        CABasicAnimation *actionAnimation = [CABasicAnimation animationWithKeyPath:LNProgressKey];
        actionAnimation.timingFunction = [[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
                                          ] actionAnimation.fromValue = @(self.progress);
        return actionAnimation;
    }
    return [super actionForKey:event];
}

- (void)drawInContext:(CGContextRef)ctx {
    if (self.progress < 0) return;
    if (self.progress > 200) return;
    CGColorRef color = self.loadingColor;
    BOOL releaseColorNeeded = NO;
    if (color == nil) {
        const CGFloat components[] = {1.000000,0.000000,0.000000,1.000000};
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        color = CGColorCreate(colorSpace, components);
        CGColorSpaceRelease(colorSpace);
        releaseColorNeeded = YES;
    }
    CGFloat lineWidth = self.progressLineWidth;
    if (lineWidth <= 0) {
        lineWidth = 4;
    }
    const CGFloat *components = CGColorGetComponents(color);
    CGContextSetRGBStrokeColor(ctx, components[0], components[1], components[2], components[3]);
    CGContextSetLineWidth(ctx, lineWidth);
    CGContextSetLineCap(ctx, kCGLineCapRound);
    
    CGFloat radius = self.frame.size.width/2.f;
    CGPoint center = CGPointMake(radius, radius);
    if (radius > self.frame.size.height/2.f) {
        radius = self.frame.size.height/2.f;
        center.y = radius;
    }else if (radius < self.frame.size.height/2.f) {
        center.y = self.frame.size.height/2.f;
    }
    if (self.progress <= 100) {
        CGContextAddArc(ctx, center.x, center.y, radius - lineWidth/2.f,-M_PI_2, -M_PI_2 + (M_PI * 2 * (self.progress / 100)), 0);
    }else {
        CGFloat relativeProgress = self.progress - 100;
        CGContextAddArc(ctx, center.x, center.y, radius - lineWidth/2.f,-M_PI_2, -M_PI_2 - (M_PI * 2 * (1 - relativeProgress / 100)), 1);
    }
    CGContextDrawPath(ctx, kCGPathStroke);
    if (releaseColorNeeded) {
        CGColorRelease(color);
    }
    
}


@end
