//
//  UIImage+RnUtil.m
//  RnUtil
//
//  Created by rein on 2018/10/29.
//  Copyright © 2018 rein. All rights reserved.
//

#import "UIImage+RnUtil.h"

@implementation UIImage (RnUtil)

+(UIImage *)rn_imageFromColor:(UIColor *)color {
    CGRect rect=CGRectMake(0.0f,0.0f,1.0f,1.0f);
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    
    CGContextFillRect(context, rect);
    
    UIImage *image=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
