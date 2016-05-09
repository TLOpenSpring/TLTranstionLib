//
//  TLTurnAnimator.m
//  Pods
//
//  Created by Andrew on 16/5/9.
//
//

#import "TLTurnAnimator.h"
#import "TransitionModel.h"



@implementation TLTurnAnimator

-(instancetype)init{
    self=[super init];
    if(self){
        self.flipDirection = TLDirection_Vertical;
    }
    return self;
}

/**
 *  执行动画
 *
 *  @param transitionContext 转场的上下文
 */
-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{

    TransitionModel *model = [[TransitionModel alloc]initWithTransitionContext:transitionContext];
    [model.containerView addSubview:model.toView];
    
    //添加一个transform
    CATransform3D transform = CATransform3DIdentity;
    transform.m34=-0.002;
    model.containerView.layer.sublayerTransform=transform;
    
    //设置源View和目标View的frame相等
    CGRect initaialFrame =[transitionContext initialFrameForViewController:model.fromViewController];
    model.fromView.frame=initaialFrame;
    model.toView.frame=initaialFrame;
    
    if(self.operation==UINavigationControllerOperationPop){
        self.reverse=YES;
    }else{
        self.reverse=NO;
    }
    
    float factor = self.reverse ? 1.0 : -1.0;
    
    model.toView.layer.transform=[self rotate:factor * -M_PI_2];
    
    //动画效果
    [UIView animateKeyframesWithDuration:[self animatorDuration]
                                   delay:0.0
                                 options:0
                              animations:^{
        //添加关键帧动画
        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.5 animations:^{
            
            model.fromView.layer.transform=[self rotate:factor*M_PI_2];
        }];
        
        [UIView addKeyframeWithRelativeStartTime:0.5 relativeDuration:0.5 animations:^{
            
            model.toView.layer.transform=[self rotate:0];
        }];
        
        
    } completion:^(BOOL finished) {
        
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
    
}

/**
 *  翻转
 *
 *  @param angle 角度
 *
 *  @return <#return value description#>
 */
-(CATransform3D )rotate:(CGFloat)angle{
    if(self.flipDirection == TLDirection_Horizontal){
        return  CATransform3DMakeRotation(angle, 1.0, 0.0, 0.0);
    }else{
        return  CATransform3DMakeRotation(angle, 0.0, 1.0, 0.0);
    }
}









@end









