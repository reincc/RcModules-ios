//
//  RcTabBar.m
//  hefo
//
//  Created by rein on 2018/10/24.
//  Copyright © 2018 rein. All rights reserved.
//

#import "RcTabBar.h"
#import "RcAnimation.h"

#pragma mark    -- RcTabBarButton --

@interface RcTabBarButton ()

//暴露方法给子类，方便子类重写
-(void)setTabBarConfig:(RcTabBarConfig *)config;

@end

@implementation RcTabBarButton

-(void)setTabBarConfig:(RcTabBarConfig *)config {
    [self setImage:[[UIImage imageNamed:config.normalImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [self setImage:[[UIImage imageNamed:config.selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateSelected];
    [self setTitle:config.title forState:UIControlStateNormal];
    [self setTitleColor:config.normalColor forState:UIControlStateNormal];
    [self setTitleColor:config.selectedColor forState:UIControlStateSelected];
    self.titleLabel.font = config.titleFont;
}

//取消高亮状态，设置self.adjustsImageWhenHighlighted = NO;不知道为啥无效
-(void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:NO];
}

@end

#pragma mark    -- RcTabBarNormalButton --

@implementation RcTabBarNormalButton

-(void)layoutSubviews {
    [super layoutSubviews];
    CGSize textSize = [[self currentTitle] rn_stringSizeWithFont:self.titleLabel.font];
    CGFloat textW = textSize.width;
    CGFloat textH = textSize.height;
    CGFloat imageW = textW == 0 ? 41 : 30;
    CGFloat imageH = imageW;
    
    CGFloat imageX = (self.bounds.size.width - imageW) / 2.0;
    CGFloat imageY = textW == 0 ? (self.bounds.size.height - imageH) / 2.0 : 2.5;
    CGFloat textX = (self.bounds.size.width - textW) / 2.0;
    CGFloat textY = imageY + imageH + 2.5;
    
    self.imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
    self.titleLabel.frame = CGRectMake(textX, textY, textW, textH);
}

@end

#pragma mark    -- RcTabBarCycleButton --

@interface RcTabBarCycleButton ()

@property (nonatomic, weak) RcTabBarButton *cycleBtn;
@property (nonatomic, weak) UIImageView *cycleImageView;

@end

@implementation RcTabBarCycleButton

-(instancetype)init {
    if (self = [super init]) {
        RcTabBarButton *cycleBtn = [[RcTabBarButton alloc] init];
        self.cycleBtn = cycleBtn;
        cycleBtn.userInteractionEnabled = NO;
        [self addSubview:cycleBtn];
        UIImageView *cycleImageView = [[UIImageView alloc] init];
        self.cycleImageView = cycleImageView;
        [cycleBtn addSubview:cycleImageView];
    }
    return self;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat cycleBtnW = 49;
    CGFloat cycleBtnH = cycleBtnW;
    CGFloat cycleBtnX = (self.bounds.size.width - cycleBtnW) / 2.0;
    CGFloat cycleBtnY = (self.bounds.size.height - cycleBtnH) / 2.0;
    
    CGFloat cycleImageW = 35;
    CGFloat cycleImageH = cycleImageW;
    CGFloat cycleimageX = (cycleBtnW - cycleImageW) / 2.0;
    CGFloat cycleimageY = (cycleBtnH - cycleImageH) / 2.0;
    
    self.cycleBtn.frame = CGRectMake(cycleBtnX, cycleBtnY, cycleBtnW, cycleBtnH);
    self.cycleImageView.frame = CGRectMake(cycleimageX, cycleimageY, cycleImageW, cycleImageH);
    [self.cycleBtn sendSubviewToBack:self.cycleImageView];
}

-(void)setTabBarConfig:(RcTabBarConfig *)config {
    [self.cycleBtn setImage:[[UIImage imageNamed:config.normalImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [self.cycleBtn setImage:[[UIImage imageNamed:config.selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateSelected];
    [self.cycleImageView setImage:[[UIImage imageNamed:config.cycleImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
}


@end

#pragma mark    -- RcTabBarItem --

@protocol RcTabBarItemDelegate <NSObject>

-(void)rc_tabBarItemDidSelectIndex:(NSInteger)index;

@end

@interface RcTabBarItem ()

@property (nonatomic, weak) id<RcTabBarItemDelegate> delegate;
@property (nonatomic, strong) RcTabBarButton *tabBarButton;
@property (nonatomic, strong) RcTabBarConfig *tabBarConfig;

@end

@implementation RcTabBarItem

-(instancetype)initWithTabBarConfig:(RcTabBarConfig *)tabBarConfig {
    if (self = [super init]) {
        _tabBarConfig = tabBarConfig;
    }
    return self;
}
/**
 *  这里进行tabBar类型的选择，新增tabbar类型，只需要继承RcTabBarButton，然后在这里进行类型添加就行
 */
-(RcTabBarButton *)tabBarButton {
    if (_tabBarButton == nil) {
        switch (_tabBarConfig.tabBarType) {
            case RcTabBarNormal:
                _tabBarButton = [[RcTabBarNormalButton alloc] init];
                break;
            case RcTabBarCycle:
                _tabBarButton = [[RcTabBarCycleButton alloc] init];
                break;
            default:
                _tabBarButton = [[RcTabBarNormalButton alloc] init];
                break;
        }
        [_tabBarButton setTabBarConfig:_tabBarConfig];
        [_tabBarButton addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _tabBarButton;
}

-(void)btnClick {
    if ([self.delegate respondsToSelector:@selector(rc_selectTabBarIndex:)]) {
        [self.delegate rc_tabBarItemDidSelectIndex:_tabBarConfig.index];
    }
}

@end

#pragma mark    -- RcTabBar --

@interface RcTabBar () <RcTabBarItemDelegate>

@end

@implementation RcTabBar

-(void)layoutSubviews {
    [super layoutSubviews];
    CGFloat btnW = self.frame.size.width / self.subviews.count;
    CGFloat btnH = self.frame.size.height;
    for (int i = 0; i < self.subviews.count; i++) {
        RcTabBarButton *btn = self.subviews[i];
        btn.frame = CGRectMake(btnW * i, 0, btnW, btnH);
    }
    if (self.selectedItem == nil) {
        [self rc_selectTabBarIndex:0];
    }
}

-(NSArray<RcTabBarItem *> *)items {
    if (_items == nil) {
        _items = [NSArray array];
    }
    return _items;
}

-(void)rc_addButtonWithTabBarItem:(RcTabBarItem *)tabBarItem {
    [self addSubview:tabBarItem.tabBarButton];
    tabBarItem.delegate = self;
    self.items = [self.items arrayByAddingObject:tabBarItem];
}

-(void)rc_selectTabBarIndex:(NSInteger)index {
    RcTabBarItem *tabBarItem = self.items[index];
    if (tabBarItem.tabBarConfig.tabBarType != RcTabBarCycle) {
        self.selectedItem.tabBarButton.selected = NO;
        tabBarItem.tabBarButton.selected = YES;
        self.selectedItem = tabBarItem;
    }
    if ([self.delegate respondsToSelector:@selector(rc_tabBarDidSelectIndex:)]) {
        [self.delegate rc_tabBarDidSelectIndex:index];
    }
}

/**
 *  添加tabbar的生命周期，在controllr中使用，控制旋转TabBar的状态
 *  其他方法类似
 */
-(void)rc_viewWillAppear:(BOOL)animated {
    for (int i = 0; i < self.subviews.count; i++) {
        RcTabBarButton *btn = self.subviews[i];
        if ([btn isKindOfClass:[RcTabBarCycleButton class]]) {
            [RcAnimation circleAniamtion:animated circleView:((RcTabBarCycleButton *)btn).cycleBtn];
            ((RcTabBarCycleButton *)btn).cycleBtn.selected = animated;
        }
    }
}

#pragma mark    -- RcTabBarItemDelegate协议 --
- (void)rc_tabBarItemDidSelectIndex:(NSInteger)index {
    [self rc_selectTabBarIndex:index];
}
@end


