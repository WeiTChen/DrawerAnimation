//
//  ViewController.m
//  drawerAnimation
//
//  Created by William on 16/5/20.
//  Copyright © 2016年 William. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIScrollViewDelegate>

@property (nonatomic,strong) UIView *rightView;

@property (nonatomic,strong) UIView *leftView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIScrollView *scroll = [[UIScrollView alloc] init];
    scroll.bounces = NO;
    [self.view addSubview:scroll];
    scroll.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    scroll.contentSize = CGSizeMake(self.view.frame.size.width+100, 0);
    scroll.contentOffset = CGPointMake(100, 0);
    
    _leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, self.view.frame.size.height)];
    scroll.delegate = self;
    _leftView.backgroundColor = [UIColor purpleColor];
    [scroll addSubview:_leftView];
    
    _rightView = [[UIView alloc]initWithFrame:CGRectMake(100, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [scroll addSubview:_rightView];
    _rightView.backgroundColor = [UIColor orangeColor];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat xy = scrollView.contentOffset.x/_leftView.frame.size.width;
    //0.75+0.25*xy = 最小缩放尺寸+滑动控制的缩放尺寸
    _rightView.transform = CGAffineTransformMakeScale(0.75+0.25*xy,0.75+0.25*xy);
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    CGFloat leftViewWidth = _leftView.frame.size.width;
    if (scrollView.contentOffset.x < leftViewWidth*0.5)
    {
        [UIView animateWithDuration:0.3 animations:^{
            scrollView.contentOffset = CGPointMake(0, 0);
        }];
    }
    else
    {
        [UIView animateWithDuration:0.3 animations:^{
            scrollView.contentOffset = CGPointMake(leftViewWidth, 0);
        }];
    }
}

@end