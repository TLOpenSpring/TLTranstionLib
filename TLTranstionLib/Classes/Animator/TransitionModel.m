//
//  TransitionModel.m
//  Pods
//
//  Created by Andrew on 16/5/2.
//
//

#import "TransitionModel.h"

@implementation TransitionModel
-(instancetype)initWithTransitionContext:(id<UIViewControllerContextTransitioning>)transitionContext{
    self=[super init];
    if(self){
        
         UIViewController *toViewController=[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
         
         UIViewController *fromViewController=[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
         
         UIView *toView=toViewController.view;
         UIView *fromView=fromViewController.view;
         //容器视图
         UIView *containerView=[transitionContext containerView];
         
         CGRect finalFrameForToVC= [transitionContext finalFrameForViewController:toViewController];
         toView.frame=finalFrameForToVC;
         [toView layoutIfNeeded];
        
        
        self.toViewController=toViewController;
        self.fromViewController=fromViewController;
        self.toView=toView;
        self.fromView=fromView;
        self.containerView=containerView;
        self.finalFrameForToVC=finalFrameForToVC;
        
    }
    
    return self;
}
@end
