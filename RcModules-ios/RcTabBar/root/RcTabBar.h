//
//  RcTabBar.h
//  hefo
//
//  Created by rein on 2018/10/24.
//  Copyright © 2018 rein. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RcTabBarConfig.h"

NS_ASSUME_NONNULL_BEGIN
@class RcTabBar;

#pragma mark    -- RcTabBarButton --

//更多的tabbar类型，可以通过继承RcTabBarButton的方式进行添加
@interface RcTabBarButton : UIButton

@end

#pragma mark    -- RcTabBarNormalButton --

//单图片类型，图片文字配合类型，两个写在一起的
@interface RcTabBarNormalButton : RcTabBarButton

@end

#pragma mark    -- RcTabBarCycleButton --

//旋转图片类型
@interface RcTabBarCycleButton : RcTabBarButton

@end

#pragma mark    -- RcTabBarItem --

@interface RcTabBarItem : NSObject

-(instancetype)initWithTabBarConfig:(RcTabBarConfig *)tabBarConfig;

@end

#pragma mark    -- RcTabBar --

@protocol RcTabBarDelegate <NSObject>

/**
 *  该协议为tabbarUItem的点击事件，必须要实现才能进行页面的切换
 *  利用UITabBarController的setSelectedIndex方法实现页面切换
 */
-(void)rc_tabBarDidSelectIndex:(NSInteger)index;

@end

@interface RcTabBar : UIView

@property (nonatomic, weak) id<RcTabBarDelegate> delegate;
@property(nullable, nonatomic, copy) NSArray<RcTabBarItem *> *items;
@property(nullable, nonatomic, weak) RcTabBarItem *selectedItem;

- (void)rc_addButtonWithTabBarItem:(RcTabBarItem *)tabBarItem;

- (void)rc_selectTabBarIndex:(NSInteger)index;

- (void)rc_viewWillAppear:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
