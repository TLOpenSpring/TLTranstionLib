//
//  TLFadeAnimator.m
//  Pods
//
//  Created by Andrew on 16/5/2.
//
//

#import "TLFadeAnimator.h"
#import "TransitionModel.h"

@implementation TLFadeAnimator



/**
 *  具体执行动画效果
 *  @param transitionContext 切换的上下文
 */
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    UIViewController *toViewController=[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIViewController *fromViewController=[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    UIView *toView=toViewController.view;
    UIView *fromView=fromViewController.view;
    //容器视图
    UIView *containerView=[transitionContext containerView];
    
    CGRect finalFrameForToVC= [transitionContext finalFrameForViewController:toViewController];
    toView.frame=finalFrameForToVC;
    [toView layoutIfNeeded];
    
   
    
    if(self.operation == UINavigationControllerOperationPush){
        [containerView addSubview:toView];
        
        toView.alpha=0;
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            toView.alpha=1.0;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
    }else if(self.operation == UINavigationControllerOperationPop){
        [containerView insertSubview:toView belowSubview:fromView];
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            fromView.alpha=0.0;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
    }else{
        [super animateTransition:transitionContext];
    }
    
    
    


}

@end
