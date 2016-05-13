//
//  TLFlipAnimator.m
//  Pods
//

//  Created by Andrew on 16/5/10.
//
//

#import "TLFlipAnimator.h"
#import "TransitionModel.h"

@implementation TLFlipAnimator

/**
 *  flippedSectionOfFromView
 移动前的坐标:
 {{0, 0}, {160, 480}}
 
 anchorPoint:(x = 0.5, y = 0.5)
 
 移动后的坐标：
 {{0, 0}, {160, 480}}>
 
 anchorPoint:(x = 1, y = 0.5)
 
 
 flippedSectionOfToView
 移动前的坐标
 {{160, 0}, {160, 480}}
 
 
 anchorPoint:(x = 0.5, y = 0.5)
 
 移动后的坐标:
 {{160, 0}, {160, 480}}
 anchorPoint:(x = 0, y = 0.5)
 *
 *  @param transitionContext 动画的上下文
 */
-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    TransitionModel *model=[[TransitionModel alloc]initWithTransitionContext:transitionContext];
    
    if(self.operation==UINavigationControllerOperationPop){
        self.reverse=YES;
    }else{
        self.reverse=NO;
        
    }
    
    [model.containerView addSubview:model.toView];
    [model.containerView sendSubviewToBack:model.toView];
    
    //Add a perspective transform
    CATransform3D transform = CATransform3DIdentity;
    transform.m34=-0.002;
    [model.containerView.layer setSublayerTransform:transform];
    
   
    
    CGRect initialFrame = model.fromView.frame;
    model.fromView.frame=initialFrame;
    model.toView.frame=initialFrame;
    
    //创建两个屏幕快照,from And to View
    NSArray *toViewSnapshots = [self createSnapshots:model.toView afterScreenUpdates:YES];
    UIView *flippedSectionOfToView = toViewSnapshots[self.reverse?0:1];
    
      NSLog(@"刚开始flippedSectionOfToView坐标:%@",NSStringFromCGRect(flippedSectionOfToView.frame));
    
    //from View 的两个屏幕快照
    NSArray *fromViewSnapshots = [self createSnapshots:model.fromView afterScreenUpdates:NO];
    UIView *flippedSectionOfFromView = fromViewSnapshots[self.reverse?1:0];
    
    NSLog(@"刚开始flippedSectionOfFromView坐标:%@",NSStringFromCGRect(flippedSectionOfFromView.frame));
    
    //用container View替换from view 和 to view
    flippedSectionOfFromView = [self addShadowToView:flippedSectionOfFromView reverse:!self.reverse];
    //创建 from view 的阴影视图
    UIView *flippedSectionOfFromViewShadow = flippedSectionOfFromView.subviews[1];
    flippedSectionOfFromViewShadow.alpha=1;
    
    //TO View
    flippedSectionOfToView = [self addShadowToView:flippedSectionOfToView reverse:!self.reverse];
    //创建to View 的阴影视图
    UIView *flippedSectionOfToViewShadow = flippedSectionOfToView.subviews[1];
    flippedSectionOfToViewShadow.alpha=1;
    
    //改变坐标使得View能够按照正确的角度旋转
    [self updateAnchorPointAndOffset:CGPointMake(self.reverse?0:1, 0.5) view:flippedSectionOfFromView];
    [self updateAnchorPointAndOffset:CGPointMake(self.reverse?1:0, 0.5) view:flippedSectionOfToView];
     NSLog(@"结束后flippedSectionOfFromView坐标:%@",NSStringFromCGRect(flippedSectionOfFromView.frame));
    NSLog(@"结束后flippedSectionOfToView坐标:%@",NSStringFromCGRect(flippedSectionOfToView.frame));
    
    
    flippedSectionOfToView.layer.transform=[self rotate:self.reverse?M_PI_2:-M_PI_2];
    
    [UIView animateKeyframesWithDuration:[self animatorDuration] delay:0 options:UIViewKeyframeAnimationOptionBeginFromCurrentState animations:^{
        
        [UIView addKeyframeWithRelativeStartTime:0
                                relativeDuration:0.5
                                      animations:^{
                                          flippedSectionOfFromView.layer.transform=[self rotate:self.reverse?-M_PI_2:M_PI_2];
                                          
                                          flippedSectionOfFromViewShadow.alpha=1.0;
                                      }];
        [UIView addKeyframeWithRelativeStartTime:0.5
                                relativeDuration:0.5
                                      animations:^{
                                        
                                          flippedSectionOfToView.layer.transform=[self rotate:self.reverse?0.001:-0.00001];
                                         flippedSectionOfToViewShadow.alpha=0;
                                      }];
        
    } completion:^(BOOL finished) {
        if([transitionContext transitionWasCancelled]){
            [self removeOtherViews:model.fromView];
        }else{
            [self removeOtherViews:model.toView];
        }
        
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
    
    
}

/**
 *  创建一对屏幕快照,根据指定的View
 *
 *  @param view     指定的 View
 *  @param afterUpdates 是否更新
 *
 *  @return 一对屏幕快照
 */
-(NSArray*)createSnapshots:(UIView *)view
        afterScreenUpdates:(BOOL)afterUpdates{
    UIView *containerView = view.superview;
    CGRect snapshotRegion = CGRectMake(0, 0, view.frame.size.width/2, view.frame.size.height);
    //创建左边的屏幕快照
    UIView *leftHandView = [view resizableSnapshotViewFromRect:snapshotRegion afterScreenUpdates:afterUpdates withCapInsets:UIEdgeInsetsZero];
    leftHandView.frame=snapshotRegion;
    [containerView addSubview:leftHandView];
    
    //创建右边的屏幕快照
    snapshotRegion = CGRectMake(view.frame.size.width/2, 0, view.frame.size.width/2, view.frame.size.height);
    UIView *rightHandView =[view resizableSnapshotViewFromRect:snapshotRegion afterScreenUpdates:afterUpdates withCapInsets:UIEdgeInsetsZero];
    rightHandView.frame = snapshotRegion;
    [containerView addSubview:rightHandView];
    
    [containerView sendSubviewToBack:view];
    
    return @[leftHandView,rightHandView];
    
}

// removes all the views other than the given view from the superview
- (void)removeOtherViews:(UIView*)viewToKeep {
    UIView* containerView = viewToKeep.superview;
    for (UIView* view in containerView.subviews) {
 
        
        if (view != viewToKeep) {
            [view removeFromSuperview];
        }
    }
}
/**
 *  给指定的View添加阴影效果
 *
 *  @param view    <#view description#>
 *  @param reverse <#reverse description#>
 *
 *  @return <#return value description#>
 */
-(UIView *)addShadowToView:(UIView *)view
                   reverse:(BOOL)reverse{

    UIView *containerView = view.superview;
    //create a view with same frame
    UIView *viewWithShadow = [[UIView alloc]initWithFrame:view.frame];
    
     // replace the view that we are adding a shadow to
    [containerView insertSubview:viewWithShadow aboveSubview:view];
    [view removeFromSuperview];
    
    //create a shadow
    UIView *shadowView = [[UIView alloc]initWithFrame:viewWithShadow.bounds];
    CAGradientLayer *grandient = [CAGradientLayer layer];
    grandient.frame=shadowView.bounds;
    
    grandient.colors = @[(id)[UIColor colorWithWhite:0.0 alpha:0.0].CGColor,
                        (id)[UIColor colorWithWhite:0.0 alpha:0.5].CGColor];
    
    grandient.startPoint=CGPointMake(reverse?0:1, 0);
    grandient.endPoint=CGPointMake(reverse?1:0, 0);
    [shadowView.layer insertSublayer:grandient atIndex:1];
    
    //添加原始的视图到我们的新的视图上
    view.frame=view.bounds;
    [viewWithShadow addSubview:view];
    
    [viewWithShadow addSubview:shadowView];
    
    return viewWithShadow;
    
    
}




/**
 *  根据指定的view更新锚点和坐标值
 *
 *  @param anchorPoint 锚点
 *  @param view        指定的View
 */
-(void)updateAnchorPointAndOffset:(CGPoint)anchorPoint
                             view:(UIView*)view{
    view.layer.anchorPoint = anchorPoint;
    float xOffset = anchorPoint.x - 0.5;
    
    view.frame = CGRectOffset(view.frame, xOffset*view.frame.size.width, 0);
}







- (CATransform3D) rotate:(CGFloat) angle {
    return  CATransform3DMakeRotation(angle, 0.0, 1.0, 0.0);
}




@end
