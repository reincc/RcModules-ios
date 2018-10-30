//
//  RcAnimation.m
//  hefo
//
//  Created by rein on 2018/10/26.
//  Copyright © 2018 rein. All rights reserved.
//

#import "RcAnimation.h"

@implementation RcAnimation

#pragma mark - 旋转动画效果
+(void)circleAniamtion:(BOOL)isCircle circleView:(UIView *)circleView {
    CAAnimation *animation = [circleView.layer animationForKey:@"rotationAnimation"];
    if (isCircle) {
        //创建动画并开始旋转或者是恢复
        if (animation && circleView.layer.speed == 0) {
            [self resumeAnimationWithCircleView:circleView];
        } else {
            [self rotationAnimationWithCircleView:circleView];
        }
    } else {
        //暂停
        if (animation) {
            [self pauseAnimationWithCircleView:circleView];
        }
    }
}

//暂停动画
+(void)pauseAnimationWithCircleView:(UIView *)circleView {
    //1.取出当前时间，转成动画暂停的时间
    CFTimeInterval pauseTime = [circleView.layer convertTime:CACurrentMediaTime() fromLayer:nil];
    //2.设置动画的时间偏移量，指定时间偏移量的目的是让动画定格在该时间点的位置
    circleView.layer.timeOffset = pauseTime;
    //3.将动画的运行速度设置为0， 默认为1.0
    circleView.layer.speed = 0;
}

//恢复动画
+(void)resumeAnimationWithCircleView:(UIView *)circleView {
    //1.将动画的时间偏移量作为暂停的时间点
    CFTimeInterval pauseTime = circleView.layer.timeOffset;
    //2.计算出开始时间
    CFTimeInterval begin = CACurrentMediaTime() - pauseTime;
    
    circleView.layer.timeOffset = 0;
    circleView.layer.beginTime = begin;
    circleView.layer.speed = 1;
}

//实现旋转动画
+(void)rotationAnimationWithCircleView:(UIView *)circleView {
    CABasicAnimation *animaton = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animaton.fromValue = [NSNumber numberWithFloat:0.0f];
    animaton.toValue = [NSNumber numberWithFloat:M_PI*2];
    animaton.duration = 8;
    animaton.autoreverses = NO;
    animaton.fillMode = kCAFillModeForwards;
    animaton.repeatCount = MAXFLOAT;
    [circleView.layer addAnimation:animaton forKey:@"rotationAnimation"];
}

@end
