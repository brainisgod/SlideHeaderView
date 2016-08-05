//
//  SlideHeaderView.h
//  SlideHeaderView
//
//  Created by 昕明 刚 on 16/6/24.
//  Copyright © 2016年 brain. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SlideHeaderView;

@protocol SlideHeaderViewDelegate <NSObject>

@optional
- (void)userHeaderImageViewTap: (UIImageView *)headerImageView; //点击头像


@end


@interface SlideHeaderView : UIView



//初始化视图
+ (instancetype)slideHeaderViewWithFrame: (CGRect)frame delegate: (id<SlideHeaderViewDelegate>)delegate;


//代理
@property (nonatomic, weak) id<SlideHeaderViewDelegate>delegate;


//自定义的属性

/**
 *  头像位置
 */
@property (nonatomic, assign) CGRect userHeaderImageViewFrame;

/**
 *  背景图url 和 占位图
 */
@property (nonatomic, strong) NSURL *backgroundImageURL;
@property (nonatomic, strong) UIImage *backGroundPlaceholderImage;

/**
 *  用户头像url 和 占位图
 */
@property (nonatomic, strong) NSURL *userImageURL;
@property (nonatomic, strong) UIImage *userPlaceholderImage;




//取到滑动变化的值 需要在scrollView代理里调用
- (void)getScrollViewContentOffSet: (CGFloat)contentOffSetY;

- (void)reloadImageView;

@end
