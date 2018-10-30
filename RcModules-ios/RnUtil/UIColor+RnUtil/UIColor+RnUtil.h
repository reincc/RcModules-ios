//
//  UIColor+RnUtil.h
//  RnUtil
//
//  Created by rein on 2018/10/29.
//  Copyright © 2018 rein. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (RnUtil)

-(UIImage *)rn_colorToImage;

// 颜色转换：将十六进制的颜色转换为UIColor(RGB)
+ (UIColor *)rn_colorWithHexString: (NSString *)color;

+ (UIColor *)rn_colorWithHexString: (NSString *)color alpha: (float)alpha;

@end

NS_ASSUME_NONNULL_END
