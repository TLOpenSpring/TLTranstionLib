//
//  TLAnimator.m
//  Pods
//
//  Created by Andrew on 16/4/29.
//
//

#import "TLAnimator.h"

@implementation TLAnimator
/**
 *  动画执行的时间
 *
 *  @param transitionContext 切换的上下文
 *
 *  @return 动画执行的时间
 */
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext{
    return duration;
}
/**
 *  具体执行动画效果
 *
 *  @param transitionContext 切换的上下文
 */
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    UIViewController *toViewController=[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIViewController *fromViewController=[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    
    UIView *toView=toViewController.view;
    UIView *fromView=fromViewController.view;
    
    UIView *containerView=[transitionContext containerView];
    
}
@end
