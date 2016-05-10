//
//  TLGeoAnimaotor.m
//  Pods
//
//  Created by Andrew on 16/5/10.
//
//

#import "TLGeoAnimaotor.h"
#import "TransitionModel.h"
#import <UIKit/UIKit.h>
static const CGFloat kAnimationFirstPartRatio = 0.8f;
@implementation TLGeoAnimaotor


-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{

    TransitionModel *model = [[TransitionModel alloc]initWithTransitionContext:transitionContext];
    
    
    if(self.operation == UINavigationControllerOperationPop){
        [self popOperation:model context:transitionContext];
    }else{
        [self pushOperation:model context:transitionContext];
    }
}

-(void)popOperation:(TransitionModel *)model context:(id<UIViewControllerContextTransitioning>)context{
    model.toViewController.view.userInteractionEnabled = YES;
    
    [model.containerView addSubview:model.toView];
    [model.containerView addSubview:model.fromView];
    
    CALayer *fromLayer;
    CALayer *toLayer;
    
    fromLayer = model.toView.layer;
    toLayer = model.fromView.layer;
    
    //重置成初始化的transform
    sourceLastTrasnform(fromLayer);
    destinationLastTransform(toLayer);
    
    //执行动画
    [UIView animateKeyframesWithDuration:[self animatorDuration] delay:0 options:UIViewKeyframeAnimationOptionCalculationModeCubic animations:^{
        
        [UIView addKeyframeWithRelativeStartTime:0
                                relativeDuration:kAnimationFirstPartRatio animations:^{
            sourceFirstTransform(fromLayer);
        }];
        
        [UIView addKeyframeWithRelativeStartTime:0
                                relativeDuration:1
                                      animations:^{
           destinationFirstTransform(toLayer);
        }];
        
        
    } completion:^(BOOL finished) {
        if([context transitionWasCancelled]){
            [model.containerView bringSubviewToFront:model.fromView];
            model.toViewController.view.userInteractionEnabled=NO;
        }
        
        model.fromViewController.view.layer.transform=CATransform3DIdentity;
        model.toViewController.view.layer.transform=CATransform3DIdentity;
        model.containerView.layer.transform=CATransform3DIdentity;
        
        [context completeTransition:![context transitionWasCancelled]];
    }];
}

-(void)pushOperation:(TransitionModel *)model context:(id<UIViewControllerContextTransitioning>)context{

    [model.containerView addSubview:model.toView];
    [model.containerView addSubview:model.fromView];
    
    CALayer *fromLayer=model.fromView.layer;
    CALayer *toLayer=model.toView.layer;
    
    
    CGRect oldFrame = fromLayer.frame;
    
    fromLayer.anchorPoint=CGPointMake(0, 0.5);
    fromLayer.frame=oldFrame;
    
    sourceFirstTransform(fromLayer);
    destinationFirstTransform(toLayer);
    model.fromView.userInteractionEnabled=NO;
    
    [UIView animateKeyframesWithDuration:[self animatorDuration] delay:0 options:UIViewKeyframeAnimationOptionCalculationModeCubic animations:^{
        
        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:1 animations:^{
            destinationLastTransform(toLayer);
        }];
        
        [UIView addKeyframeWithRelativeStartTime:1-kAnimationFirstPartRatio relativeDuration:kAnimationFirstPartRatio animations:^{
            sourceLastTrasnform(fromLayer);
        }];
        
        
    } completion:^(BOOL finished) {
        if([context transitionWasCancelled]){
            [model.containerView bringSubviewToFront:model.fromView];
            model.fromView.userInteractionEnabled=YES;
        }
        
        model.fromView.layer.transform=CATransform3DIdentity;
        model.toView.layer.transform=CATransform3DIdentity;

        model.containerView.layer.transform=CATransform3DIdentity;
        
        [context completeTransition:![context transitionWasCancelled]];

    }];
    
}

static void sourceFirstTransform(CALayer *layer){
    CATransform3D t = CATransform3DIdentity;
    t.m34 = 1 / -500;
    t= CATransform3DTranslate(t, 0, 0, 0);
    layer.transform=t;
}


static void sourceLastTrasnform(CALayer *layer){
    CATransform3D t =CATransform3DIdentity;
    t.m34 = 1.0 / -500;
    //沿着Y轴旋转80度
    t = CATransform3DRotate(t, radianFromDegress(80), 0, 1, 0);
    t = CATransform3DTranslate(t, 0, 0, -30);
    t = CATransform3DTranslate(t, 170, 0, 0);
    layer.transform=t;
}

static void destinationFirstTransform(CALayer *layer){
    CATransform3D t = CATransform3DIdentity;
    //沿着Z轴旋转5度
    t = CATransform3DRotate(t, radianFromDegress(5), 0, 0, 1);
    t = CATransform3DTranslate(t, 320, -40, 150);
    //沿着y轴旋转-45度
    t = CATransform3DRotate(t, radianFromDegress(-45), 0, 1, 0);
    //沿着x轴旋转10度
    t = CATransform3DRotate(t, radianFromDegress(10), 1.0f, 0.0f, 0.0f);
    layer.transform=t;
}

static void destinationLastTransform(CALayer *layer){
    CATransform3D  t = CATransform3DIdentity;
    t.m34 = 1.0 / 500;
    //rotate to 0 degress within z axis;
    t= CATransform3DRotate(t, radianFromDegress(0), 0, 0, 1);
    //回到最终位置
    t = CATransform3DTranslate(t, 0, 0, 0);
    //沿着y轴旋转0度
    t = CATransform3DRotate(t, radianFromDegress(0), 0, 1, 0);
    //沿着x轴旋转0度
    t = CATransform3DRotate(t, radianFromDegress(0), 1, 0, 0);
    layer.transform=t;
}


#pragma mark - Covert Degress to Redian
static double radianFromDegress(float degress){
    return (degress/180) * M_PI;
}


@end








