//
//  NSString+RnUtil.m
//  RnUtil
//
//  Created by rein on 2018/10/25.
//  Copyright © 2018 rein. All rights reserved.
//

#import "NSString+RnUtil.h"

@implementation NSString (RnUtil)

-(CGSize)rn_stringSizeWithFont:(UIFont *)font {
    return [self boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, MAXFLOAT)
                              options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                           attributes:@{NSFontAttributeName: font}
                              context:nil].size;
}

@end
