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

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    TransitionModel *model=[[TransitionModel alloc]initWithTransitionContext:transitionContext];
    
    
    [model.containerView addSubview:model.toView];
    [model.containerView sendSubviewToBack:model.toView];
    
    //Add a perspective transform
    CATransform3D transform = CATransform3DIdentity;
    transform.m34=-0.002;
    [model.containerView.layer setSublayerTransform:transform];
    
    CGRect initialFrame = [transitionContext initialFrameForViewController:model.fromViewController];
    model.fromView.frame=initialFrame;
    model.toView.frame=initialFrame;
    
    //创建两个屏幕快照,from And to View
    NSArray *toViewSnapshots = [self createSnapshots:model.toView afterScreenUpdates:YES];
    UIView *flippedSectionOfToView = toViewSnapshots[self.reverse?0:1];
    
    NSArray *fromViewSnapshots = [self createSnapshots:model.fromView afterScreenUpdates:NO];
    UIView *flippedSectionOfFromView = fromViewSnapshots[self.reverse?1:0];
    
    //用container View替换from view 和 to view
    flippedSectionOfFromView = [self addShadowToView:flippedSectionOfFromView reverse:!self.reverse];
    
    
    
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
