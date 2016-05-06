//
//  TLCardAnimator.m
//  Pods
//
//  Created by Andrew on 16/5/6.
//
//

#import "TLCardAnimator.h"
#import "TransitionModel.h"

@interface TLCardAnimator ()

@property (nonatomic)NSTimeInterval duration;

@end


@implementation TLCardAnimator


-(NSTimeInterval)duration{
    return 1;
}



-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{




    TransitionModel *model=[[TransitionModel alloc]initWithTransitionContext:transitionContext];
    if(self.operation == UINavigationControllerOperationPush){
        [self pushOperation:model context:transitionContext];
    }else if(self.operation == UINavigationControllerOperationPop){
        [self popOperation:model context:transitionContext];
    }else{
        [super animateTransition:transitionContext];
    }

}

-(void)pushOperation:(TransitionModel*)model context:(id<UIViewControllerContextTransitioning>)context{
    //过渡开始时的动画
    CGRect frame = [context initialFrameForViewController:model.fromViewController];
    CGRect offScreenFrame =frame;
    
    offScreenFrame.origin.y = offScreenFrame.size.height;
    model.toView.frame=offScreenFrame;
    
    [model.containerView insertSubview:model.toView aboveSubview:model.fromView];
    
    CATransform3D t1 =[self firstTransform];
    CATransform3D t2 =[self secondTransformWithView:model.fromView];
    
    
    [UIView animateKeyframesWithDuration:self.duration delay:0 options:UIViewKeyframeAnimationOptionCalculationModeCubic animations:^{
        
        //动画step1
        [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:0.4 animations:^{
            model.fromView.layer.transform=t1;
            model.fromView.alpha=0.6;
        }];
        //动画step2
        [UIView addKeyframeWithRelativeStartTime:0.2 relativeDuration:0.4 animations:^{
            model.fromView.layer.transform=t2;
        }];
        
        //添加目标View
        [UIView addKeyframeWithRelativeStartTime:0.6f relativeDuration:0.2f animations:^{
            model.toView.frame=CGRectOffset(model.toView.frame, 0, -30);
        }];
        
        [UIView addKeyframeWithRelativeStartTime:0.8f relativeDuration:0.2f animations:^{
            model.toView.frame=frame;;
        }];
        
        
    } completion:^(BOOL finished) {
        [context completeTransition:![context transitionWasCancelled]];
    }];
   

}

-(void)popOperation:(TransitionModel*)model context:(id<UIViewControllerContextTransitioning>)context{
    
    
    //过渡开始时的动画
    CGRect frame = [context initialFrameForViewController:model.fromViewController];
    model.toView.frame=frame;
    
    CATransform3D scale = CATransform3DIdentity;
    model.toView.layer.transform=CATransform3DScale(scale, 0.6, 0.6, 1);
    model.toView.alpha=0.6;
    
    [model.containerView insertSubview:model.toView belowSubview:model.fromView];
    
    CGRect frameOffsetScreen = frame;
    frameOffsetScreen.origin.y = frame.size.height;
    
    CATransform3D t1 = [self firstTransform];
    
    [UIView animateKeyframesWithDuration:self.duration delay:0 options:UIViewKeyframeAnimationOptionCalculationModeCubic animations:^{
        
        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.5 animations:^{
            model.fromView.frame=frameOffsetScreen;
        }];
        
        
        [UIView addKeyframeWithRelativeStartTime:0.35 relativeDuration:0.35 animations:^{
            model.toView.layer.transform=t1;
            model.toView.alpha=1;
        }];
        
        [UIView addKeyframeWithRelativeStartTime:0.75 relativeDuration:0.25 animations:^{
            model.toView.layer.transform=CATransform3DIdentity;
        }];
        
        
    } completion:^(BOOL finished) {
        
        if([context transitionWasCancelled]){
            model.toView.layer.transform=CATransform3DIdentity;
            model.toView.alpha=1;
        }
        [context completeTransition:![context transitionWasCancelled]];
    }];
    

}

-(CATransform3D)firstTransform{
    CATransform3D t1 = CATransform3DIdentity;
    //设置透明度
    t1.m34 = 1.0/900;
    t1 = CATransform3DScale(t1, 0.95, 0.95, 1);
    //在X轴上旋转15度
    t1 = CATransform3DRotate(t1, 15*M_PI/180.f, 1, 0, 0);
    return t1;
}

-(CATransform3D)secondTransformWithView:(UIView *)view{
 
    CATransform3D t2 = CATransform3DIdentity;
    t2.m34 = [self firstTransform].m34;
     //在Y轴上移动
    t2 = CATransform3DTranslate(t2, 0, view.frame.size.height*-0.08, view.frame.size.height*-0.08);
    t2 = CATransform3DScale(t2, 0.8, 0.8, 1);
    
    
    return t2;
}










@end
