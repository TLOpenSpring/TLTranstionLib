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

    TransitionModel *transitionModel=[[TransitionModel alloc]initWithTransitionContext:transitionContext];
    
    if(self.operation == UINavigationControllerOperationPush){
        [transitionModel.containerView addSubview:transitionModel.toView];
        
        transitionModel.toView.alpha=0;
        
        [UIView animateWithDuration:[self animatorDuration] animations:^{
            transitionModel.toView.alpha=1.0;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
    }else if(self.operation == UINavigationControllerOperationPop){
        [transitionModel.containerView insertSubview:transitionModel.toView belowSubview:transitionModel.fromView];
        
        [UIView animateWithDuration:[self animatorDuration] animations:^{
            transitionModel.fromView.alpha=0.0;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
    }else{
        [super animateTransition:transitionContext];
    }
    
    
    


}

@end
