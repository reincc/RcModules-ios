//
//  RcTabBarViewController.h
//  RcTabBar
//
//  Created by rein on 2018/10/29.
//  Copyright © 2018 rein. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class RcTabBar;

@interface RcTabBarViewController : UITabBarController

@property (nonatomic, strong) RcTabBar *customTabBar;

@end

NS_ASSUME_NONNULL_END
