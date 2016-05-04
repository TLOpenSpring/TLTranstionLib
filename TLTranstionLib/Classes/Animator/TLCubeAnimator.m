//
//  TLCubeAnimator.m
//  Pods
//
//  Created by Andrew on 16/5/4.
//
//

#import "TLCubeAnimator.h"
#import "TransitionModel.h"

#define PERSPECTIVE -1.0 / 200.0
#define ROTATION_ANGLE M_PI_2

@interface TLCubeAnimator()

@end

@implementation TLCubeAnimator


-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 0.5;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    TransitionModel *model=[[TransitionModel alloc]initWithTransitionContext:transitionContext];
    
    //创建不同的3d效果
    CATransform3D viewFromTransform;
    CATransform3D viewToTransform;
    
    int dir=1;
    
    if(self.operation==UINavigationControllerOperationPop){
        dir=-dir;
    }
    
    switch (self.cubeDirection) {
        case TLCubeHorizontal:
        {
            viewFromTransform = CATransform3DMakeRotation(dir*ROTATION_ANGLE, 0, 1, 0);
            viewToTransform =CATransform3DMakeRotation(-dir*ROTATION_ANGLE, 0, 1, 0);
            
            [model.toView.layer setAnchorPoint:CGPointMake(dir==1?0:1,0.5)];
            [model.fromView.layer setAnchorPoint:CGPointMake(dir==1?1:0, 0.5)];

            [model.containerView setTransform:CGAffineTransformMakeTranslation(dir*(model.containerView.frame.size.width/2), 0)];
        }
            break;
            
        case TLCubeVertical:
        {
            viewFromTransform = CATransform3DMakeRotation(-dir*ROTATION_ANGLE, 1, 0, 0);
            viewToTransform =CATransform3DMakeRotation(dir*ROTATION_ANGLE, 1, 0, 0);
            
            [model.toView.layer setAnchorPoint:CGPointMake(0.5, dir==1?0:1)];
            [model.fromView.layer setAnchorPoint:CGPointMake(0.5, dir==1?1:0)];
            [model.containerView setTransform:CGAffineTransformMakeTranslation(0, dir*(model.containerView.frame.size.height)/2.0)];
        }
            break;
            
        default:
            break;
    }
    
    
    //设置透明度，只有在旋转的时候这个属性值才会有效
    viewFromTransform.m34=PERSPECTIVE;
    viewToTransform.m34=PERSPECTIVE;
    
    model.toView.layer.transform=viewToTransform;
    
    //创建阴影
    UIView *fromShadow = [self addOpacityToView:model.fromView withColor:[UIColor blackColor]];
    UIView *toShadow = [self addOpacityToView:model.toView withColor:[UIColor blackColor]];
    fromShadow.alpha=0;
    toShadow.alpha=1;
    
    //添加到容器中
    [model.containerView addSubview:model.toView];
    
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        switch (self.cubeDirection) {
            case TLCubeHorizontal:
               [model.containerView setTransform:CGAffineTransformMakeTranslation(-dir*model.containerView.frame.size.width/2, 0)];
                
                break;
            case TLCubeVertical:
                [model.containerView setTransform:CGAffineTransformMakeTranslation(0, -dir*(model.containerView.frame.size.height)/2)];
                break;
                
            default:
                break;
        }
        
        model.fromView.layer.transform=viewFromTransform;
        model.toView.layer.transform=CATransform3DIdentity;
        
        fromShadow.alpha=1;
        toShadow.alpha=0;
        
    } completion:^(BOOL finished) {
        
        //设置最终的位置
        [model.containerView setTransform:CGAffineTransformIdentity];
        model.fromView.layer.transform=CATransform3DIdentity;
        model.toView.layer.transform=CATransform3DIdentity;
        //设置到中心
        model.fromView.layer.anchorPoint=CGPointMake(0.5, 0.5);
        model.toView.layer.anchorPoint=CGPointMake(0.5, 0.5);
        
        [fromShadow removeFromSuperview];
        [toShadow removeFromSuperview];
        
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
    
    
    
}

-(UIView*)addOpacityToView:(UIView *)view withColor:(UIColor *)color{
    UIView *shadowView = [[UIView alloc]initWithFrame:view.bounds];
    shadowView.backgroundColor=[color colorWithAlphaComponent:0.8];
    [view addSubview:shadowView];
    return shadowView;
    
}
@end





