//
//  MenuPresentAnimation.m
//  MenuViewController
//
//  Created by Lee on 8/31/16.
//  Copyright © 2016 Lee. All rights reserved.
//

#import "MenuPresentAnimation.h"

@implementation MenuPresentAnimation
-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.25f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    //  1、取出要跳转到的 VC
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    //   2 、设置 toVC frame
    CGRect screenBounds = [UIScreen mainScreen].bounds;
    CGRect finalFrame = [transitionContext finalFrameForViewController:toVC];
    
    //修改 toVC 起始点 为中心点
    
    toVC.view.frame = CGRectMake(-screenBounds.size.width, 0, screenBounds.size.width*2, screenBounds.size.height);
    toVC.view.layer.cornerRadius = 0;
    
    toVC.view.clipsToBounds = YES;
    //  3 、把 toVC 添加到容器中
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toVC.view];
    
    ////  4、动画
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    [UIView animateWithDuration:duration animations:^{
         toVC.view.frame = finalFrame;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
    
    
}


@end
