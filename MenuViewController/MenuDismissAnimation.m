//
//  MenuDismissAnimation.m
//  MenuViewController
//
//  Created by Lee on 9/1/16.
//  Copyright © 2016 Lee. All rights reserved.
//

#import "MenuDismissAnimation.h"

@implementation MenuDismissAnimation
-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return  0.25f;
}


-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:fromVC.view];
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration animations:^{
        fromVC.view.frame = CGRectMake(-screenBounds.size.width, 0, screenBounds.size.width*2, screenBounds.size.height);
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
    
    
    
    
    
}

@end
