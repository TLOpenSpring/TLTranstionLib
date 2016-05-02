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
    //容器视图
    UIView *containerView=[transitionContext containerView];
    
    CGRect finalFrameForToVC= [transitionContext finalFrameForViewController:toViewController];
    toView.frame=finalFrameForToVC;
    [toView layoutIfNeeded];
    
    
    if(self.operation == UINavigationControllerOperationPush){
        CGRect frame = toView.frame;
        frame.origin.x=fromView.frame.origin.x+fromView.frame.size.width;
        toView.frame=frame;
        [containerView addSubview:toView];
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            //设置目标视图的frame为最终转场动画后的视图frame
            toView.frame=finalFrameForToVC;
            
            CGRect frame = fromView.frame;
            frame.origin.x= frame.origin.x - frame.size.width/3;
            fromView.frame=frame;
            
        } completion:^(BOOL finished) {
            //设置完成状态
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
        
    }else if(self.operation == UINavigationControllerOperationPop){
     
        CGRect frame = toView.frame;
        frame.origin.x= fromView.frame.origin.x - toView.frame.size.width/3;
        toView.frame=frame;
        
        [containerView insertSubview:toView belowSubview:fromView];
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            toView.frame=finalFrameForToVC;
            CGRect frame = fromView.frame;
            
            frame.origin.x=frame.origin.x + frame.size.width;
            fromView.frame=frame;
            
        } completion:^(BOOL finished) {
            //设置完成状态
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
        
    }else{
     
        [containerView addSubview:toView];
        //设置完成状态
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }
    
}


@end































