//
//  SlideHeaderView.m
//  SlideHeaderView
//
//  Created by 昕明 刚 on 16/6/24.
//  Copyright © 2016年 brain. All rights reserved.
//

#import "SlideHeaderView.h"
#import <UIImageView+WebCache.h>

#define ScreenWidth [UIScreen mainScreen].bounds.size.width  //屏幕宽度
#define ScreenHeight [UIScreen mainScreen].bounds.size.height  //屏幕高度

@interface SlideHeaderView ()

@property (nonatomic, strong) UIView *mainHeaderView; //headView
@property (nonatomic, strong) UIImageView *headerBackgroundImageView; //大背景图
@property (nonatomic, strong) UIImageView *userHeaderImageView; //用户头像

/**
 *  可以自定义需要显示的内容 example: namelabel
 */
@property (nonatomic, strong) UILabel *userNameLabel;


@end



@implementation SlideHeaderView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initialization];
        [self setupMainView];
    }
    return self;
}

- (void)awakeFromNib {
    [self initialization];
    [self setupMainView];
}


- (void)initialization {
    
    self.backgroundColor = [UIColor whiteColor];
    self.userHeaderImageViewFrame = CGRectMake(self.bounds.size.width/2 - 40, self.bounds.size.height/2 - 40, 80, 80);
    
    //可以再这把占位图写成固定的
    self.backGroundPlaceholderImage = [UIImage imageNamed:@"ss.jpeg"];
    
}

+ (instancetype)slideHeaderViewWithFrame:(CGRect)frame delegate:(id<SlideHeaderViewDelegate>)delegate {
    SlideHeaderView *headerView = [[self alloc] initWithFrame:frame];
    headerView.delegate = delegate;
    return headerView;
}


- (void)setupMainView {
    self.mainHeaderView = [[UIView alloc] initWithFrame:self.bounds];
    self.mainHeaderView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_mainHeaderView];
    
    //背景图
    self.headerBackgroundImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    [self.headerBackgroundImageView sd_setImageWithURL:_backgroundImageURL placeholderImage:_backGroundPlaceholderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
    self.headerBackgroundImageView.userInteractionEnabled = YES;
    self.headerBackgroundImageView.contentMode = UIViewContentModeScaleToFill;
    [self.mainHeaderView addSubview:_headerBackgroundImageView];
    
    //用户头像
    self.userHeaderImageView = [[UIImageView alloc] initWithFrame:_userHeaderImageViewFrame];
    self.userHeaderImageView.userInteractionEnabled = YES;
    [self.userHeaderImageView sd_setImageWithURL:_userImageURL placeholderImage:_userPlaceholderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
    UITapGestureRecognizer *headTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHeaderImageView:)];
    [self.userHeaderImageView addGestureRecognizer:headTap];
    
    self.userHeaderImageView.backgroundColor = [UIColor orangeColor];
    self.userHeaderImageView.clipsToBounds = YES;
    self.userHeaderImageView.layer.cornerRadius = 40;
    [self.mainHeaderView addSubview:_userHeaderImageView];

    self.userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,self.bounds.size.height - 40,ScreenWidth,20)];
    self.userNameLabel.text = @"test:example";
    self.userNameLabel.textColor = [UIColor whiteColor];
    self.userNameLabel.font = [UIFont systemFontOfSize:20.0];
    self.userNameLabel.textAlignment = NSTextAlignmentCenter;
    [self.mainHeaderView addSubview:_userNameLabel];

}


//scrollView代理 可以根据更改效果
- (void)getScrollViewContentOffSet:(CGFloat)contentOffSetY {
    
    CGFloat topHeight = self.bounds.size.height;
    
    if (contentOffSetY < 0) {
        
        CGFloat offSetY = contentOffSetY;
        CGFloat add_topHeight = -(offSetY);
        CGFloat scale = (topHeight + add_topHeight)/topHeight;
        
        //修改frame
        CGRect mainBackViewFrame = CGRectMake(0, -add_topHeight, ScreenWidth, topHeight + add_topHeight);
        self.mainHeaderView.frame = mainBackViewFrame;
        
        //修改背景图片的放大比例
        CGRect headerBackgroundImageViewFrame = CGRectMake(-(ScreenWidth*scale - ScreenWidth)/2.0, 0, ScreenWidth*scale, topHeight + add_topHeight);
        self.headerBackgroundImageView.frame = headerBackgroundImageViewFrame;
        
        //修改用户头像的位置
        self.userHeaderImageView.frame = CGRectMake(_userHeaderImageViewFrame.origin.x, (self.mainHeaderView.bounds.size.height - _userHeaderImageViewFrame.size.height)/2, _userHeaderImageViewFrame.size.width, _userHeaderImageViewFrame.size.height);

        
        //修改自定义需求的控件位置,根据具体需求变换
        self.userNameLabel.frame = CGRectMake(0,self.mainHeaderView.bounds.size.height - 40,ScreenWidth,20);
    }
    
}

- (void)reloadImageView {
    
}

//头像点击事件
- (void)tapHeaderImageView: (UITapGestureRecognizer *)sender {
    [self.delegate userHeaderImageViewTap:_userHeaderImageView];
}

@end
