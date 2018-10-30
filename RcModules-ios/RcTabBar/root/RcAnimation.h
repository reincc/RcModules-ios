//
//  RcAnimation.h
//  hefo
//
//  Created by rein on 2018/10/26.
//  Copyright © 2018 rein. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RcAnimation : NSObject

#pragma mark - 旋转动画效果
+(void)circleAniamtion:(BOOL)isCircle circleView:(UIView *)circleView;

@end

NS_ASSUME_NONNULL_END
