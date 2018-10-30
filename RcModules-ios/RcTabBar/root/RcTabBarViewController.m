//
//  RcTabBarViewController.m
//  RcTabBar
//
//  Created by rein on 2018/10/29.
//  Copyright © 2018 rein. All rights reserved.
//

#import "RcTabBarViewController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "FourthViewController.h"
#import "RcTabBar.h"
#import "RcTabBarConfig.h"


@interface RcTabBarViewController () <RcTabBarDelegate>

@property (nonatomic, strong) NSArray *allControllers;
@property (nonatomic, strong) NSArray *tabBarConfigs;

@end

@implementation RcTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _customTabBar = [[RcTabBar alloc] init];
    _customTabBar.frame = self.tabBar.bounds;
    NSMutableArray *array = [[NSMutableArray alloc] initWithArray:self.allControllers];
    [self setViewControllers:array animated:NO];
    [self.tabBar addSubview:_customTabBar];
    self.tabBar.backgroundImage = [UIImage rn_imageFromColor:[UIColor whiteColor]];
    
    _customTabBar.delegate = self;
}

-(void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    for (UIView *subView in self.tabBar.subviews) {
        if ([subView isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [subView removeFromSuperview];
        }
    }
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.customTabBar rc_viewWillAppear:YES];
}

-(NSArray *)allControllers {
    if (_allControllers == nil) {
        FirstViewController *firstVC = [[FirstViewController alloc] init];
        SecondViewController *secondVC = [[SecondViewController alloc] init];
        ThirdViewController *thirdVC = [[ThirdViewController alloc] init];
        FourthViewController *fourthVC = [[FourthViewController alloc] init];
        
        _allControllers = [NSArray arrayWithObjects:
                           [self navWithRoot:firstVC],
                           [self navWithRoot:secondVC],
                           [self navWithRoot:thirdVC],
                           [self navWithRoot:fourthVC], nil];
        
        for (int i = 0; i < self.tabBarConfigs.count; i++) {
            RcTabBarConfig *config = [[RcTabBarConfig alloc] init];
            config.title = self.tabBarConfigs[i][@"title"];
            config.normalImage = self.tabBarConfigs[i][@"normalImage"];
            config.selectedImage = self.tabBarConfigs[i][@"selectedImage"];
            config.cycleImage = self.tabBarConfigs[i][@"cycleImage"];
            config.tabBarType = [self.tabBarConfigs[i][@"tabBarType"] integerValue];
            config.index = i;
            
            RcTabBarItem *tabBarItem = [[RcTabBarItem alloc] initWithTabBarConfig:config];
            [self.customTabBar rc_addButtonWithTabBarItem:tabBarItem];
        }
    }
    return _allControllers;
}

-(UINavigationController *)navWithRoot:(UIViewController *)vc {
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    return nav;
}

-(NSArray *)tabBarConfigs {
    if (_tabBarConfigs == nil) {
        _tabBarConfigs = @[
                           @{@"normalImage":@"shouye_normal", @"selectedImage":@"shouye_press"},
                           @{@"normalImage":@"faxian_normal", @"selectedImage":@"faxian_press", @"title":@"发现"},
                           @{@"normalImage":@"music_play", @"selectedImage":@"music_pause",
                             @"cycleImage":@"music_cycle_bg", @"tabBarType":[NSNumber numberWithInteger:RcTabBarCycle]},
                           @{@"normalImage":@"tansuo_normal", @"selectedImage":@"tansuo_press", @"title":@"探索"},
                           @{@"normalImage":@"wode_normal", @"selectedImage":@"wode_press", @"title":@"我的"}];
    }
    return _tabBarConfigs;
}

#pragma mark    -- RcTabBarDelegate --
-(void)rc_tabBarDidSelectIndex:(NSInteger)index {
//    if ([self.tabBarConfigs[index][@"tabBarType"] integerValue] == RcTabBarCycle) {
//        return;
//    }
    if (index == 2) {
        //这里可以进行页面的跳转
        return;
    } else if (index > 2) {
        index --;
    }
    [self setSelectedIndex:index];
}

@end
