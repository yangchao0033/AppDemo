//
//  IWTabBar.h
//  新浪微博
//
//  Created by apple on 14-11-20.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^IWTabBarBlock)(NSInteger selectedIndex);
// void(^)(NSInteger selectedIndex) block类型
//@class IWTabBar;
//@protocol IWTabBarDelegate <NSObject>
//
//@optional
//- (void)tabBar:(IWTabBar *)tabBar didClickButton:(NSInteger)selectedIndex;
//
//@end

@interface IWTabBar : UIView

- (void)addTabBarButton:(UITabBarItem *)item;

@property (nonatomic, copy) IWTabBarBlock tabBarblock;
//void(^tabBarblock)(NSInteger selectedIndex) ;
//@property (nonatomic, weak) id<IWTabBarDelegate> delegate;

@end
