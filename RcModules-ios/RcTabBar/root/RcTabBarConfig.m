//
//  RcTabBarConfig.m
//  hefo
//
//  Created by rein on 2018/10/25.
//  Copyright © 2018 rein. All rights reserved.
//

#import "RcTabBarConfig.h"

@implementation RcTabBarConfig

-(instancetype)init {
    if (self = [super init]) {
        _normalColor = [UIColor rn_colorWithHexString:@"#333333"];
        _selectedColor = [UIColor rn_colorWithHexString:@"#1296db"];
        _titleFont = [UIFont systemFontOfSize:10.0];
        _tabBarType = RcTabBarNormal;
    }
    return self;
}

@end
