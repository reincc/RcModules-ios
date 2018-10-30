//
//  RcTabBarConfig.h
//  hefo
//
//  Created by rein on 2018/10/25.
//  Copyright © 2018 rein. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

//tabbar的类型枚举
typedef NS_ENUM(NSInteger, RcTabBarType){
    RcTabBarNormal,
    RcTabBarCycle
};

@interface RcTabBarConfig : NSObject

@property (nonatomic, copy) NSString *normalImage;
@property (nonatomic, copy) NSString *selectedImage;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) UIColor *normalColor;
@property (nonatomic, strong) UIColor *selectedColor;
@property (nonatomic, assign) UIFont *titleFont;            //文字的字体
@property (nonatomic, copy) NSString *cycleImage;           //旋转button背景图片，可以设置为url进行网络加载(自己配置)
@property (nonatomic, assign) NSInteger index;              //tabBar的下标

@property (nonatomic, assign) RcTabBarType tabBarType;      //tabBar的类型

@end

NS_ASSUME_NONNULL_END
