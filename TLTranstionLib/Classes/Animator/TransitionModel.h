//
//  TransitionModel.h
//  Pods
//
//  Created by Andrew on 16/5/2.
//
//

@import UIKit;

@interface TransitionModel : NSObject


@property (nonatomic,strong)UIViewController *toViewController;
@property (nonatomic,strong)UIViewController *fromViewController;
@property (nonatomic,strong)UIView *toView;
@property (nonatomic,strong)UIView *fromView;
/**
 *  容器视图
 */
@property (nonatomic,strong)UIView *containerView;
/**
 *  转场动画结束后的视图
 */
@property CGRect finalFrameForToVC;


-(instancetype)initWithTransitionContext:(id <UIViewControllerContextTransitioning>)context;
@end
