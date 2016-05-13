//
//  TLPortalAnimator.m
//  Pods
//
//  Created by Andrew on 16/5/6.
//
//

#import "TLPortalAnimator.h"
#import "TransitionModel.h"

#define ZOOM_SCALE 0.8


@interface TLPortalAnimator()

@end


@implementation TLPortalAnimator

/**
 *  执行动画
 *
 *  @param transitionContex <#transitionContex description#>
 */
-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContex{
   
    TransitionModel *model=[[TransitionModel alloc]initWithTransitionContext:transitionContex];
    
    if(self.operation == UINavigationControllerOperationPush){
        [self pushOperation:model context:transitionContex];
    }else if(self.operation == UINavigationControllerOperationPop){
        [self popOperation:model context:transitionContex];
    }else {
        [super animateTransition:transitionContex];
    }
}


-(void)pushOperation:(TransitionModel *)model context:(id<UIViewControllerContextTransitioning>)contenxt{
 
    //获取目标View的屏幕截图
    UIView *toViewSnopshot = [model.toView resizableSnapshotViewFromRect:model.toView.frame afterScreenUpdates:YES withCapInsets:UIEdgeInsetsZero];
    
    CATransform3D scale = CATransform3DIdentity;
    toViewSnopshot.layer.transform=CATransform3DScale(scale, ZOOM_SCALE, ZOOM_SCALE, 1);
    
    [model.containerView addSubview:toViewSnopshot];
    [model.containerView sendSubviewToBack:toViewSnopshot];
    
    //创建两个部分的屏幕截图从fromView中
    
    //先创建左边的视图
    CGRect leftSnapshotRegion = CGRectMake(0, 0, model.fromView.frame.size.width/2,  model.fromView.frame.size.height);
    UIView *lefthandView = [model.fromView resizableSnapshotViewFromRect:leftSnapshotRegion afterScreenUpdates:NO withCapInsets:UIEdgeInsetsZero];
    lefthandView.frame=leftSnapshotRegion;
    
    [model.containerView addSubview:lefthandView];
    
    //创建右边的视图
    CGRect rightSnapshotRegion = CGRectMake(model.fromView.frame.size.width/2, 0, model.fromView.frame.size.width/2, model.fromView.frame.size.height);
    UIView *righthandView = [model.fromView resizableSnapshotViewFromRect:rightSnapshotRegion afterScreenUpdates:NO withCapInsets:UIEdgeInsetsZero];
    righthandView.frame=rightSnapshotRegion;
    
    [model.containerView addSubview:righthandView];
    
    //删除fromView,只保留屏幕截图那部分
    [model.fromView removeFromSuperview];
    
     NSTimeInterval duration = [self animatorDuration];
    
    [UIView animateWithDuration:duration animations:^{
        //// Open the portal doors of the from-view
        lefthandView.frame=CGRectOffset(lefthandView.frame, -lefthandView.frame.size.width, 0);
        righthandView.frame=CGRectOffset(righthandView.frame, righthandView.frame.size.width, 0);
        
        //缩放toView
        toViewSnopshot.center  = model.toView.center;
        toViewSnopshot.frame = model.toView.frame;
        
    } completion:^(BOOL finished) {
        //删除所有的临时视图
        
        [toViewSnopshot removeFromSuperview];
        [model.containerView addSubview:model.toView];
        
        
        [lefthandView removeFromSuperview];
        [righthandView removeFromSuperview];
        
        // model.toView.frame=model.containerView.bounds;
        [contenxt completeTransition:![contenxt transitionWasCancelled]];
    }];
    
}

- (void)removeOtherViews:(UIView*)viewToKeep {
    UIView *containerView = viewToKeep.superview;
//    for (UIView *view in containerView.subviews) {
//        if (view != viewToKeep) {
//            [view removeFromSuperview];
//        }
//    }
}

-(void)popOperation:(TransitionModel *)model context:(id<UIViewControllerContextTransitioning>)contenxt{
    
    model.toView.frame=CGRectOffset(model.toView.frame, model.toView.frame.size.width, 0);
    [model.containerView addSubview:model.toView];
    
    //创建左边的屏幕截图
    CGRect leftSnapshotRegion = CGRectMake(0, 0, model.toView.frame.size.width/2, model.toView.frame.size.height);
    UIView *leftHandView = [model.toView resizableSnapshotViewFromRect:leftSnapshotRegion afterScreenUpdates:NO withCapInsets:UIEdgeInsetsZero];
    leftHandView.frame = leftSnapshotRegion;
    //开始慢慢远离屏幕 越往里
    leftHandView.frame= CGRectOffset(leftHandView.frame, -leftHandView.frame.size.width, 0);
    [model.containerView addSubview:leftHandView];
    
    
    //创建右边的屏幕截图
    CGRect rightSnapshotRegion = CGRectMake(model.toView.frame.size.width/2, 0, model.toView.frame.size.width/2, model.toView.frame.size.height);
    UIView *rightHandView = [model.toView resizableSnapshotViewFromRect:rightSnapshotRegion afterScreenUpdates:NO withCapInsets:UIEdgeInsetsZero];
    rightHandView.frame=rightSnapshotRegion;
    rightHandView.frame=CGRectOffset(rightHandView.frame, rightHandView.frame.size.width, 0);
    
    [model.containerView addSubview:rightHandView];
    
     NSTimeInterval duration = [self animatorDuration];
    
    
    [UIView animateWithDuration:duration animations:^{
        
        leftHandView.frame=CGRectOffset(leftHandView.frame, leftHandView.frame.size.width, 0);
        rightHandView.frame=CGRectOffset(rightHandView.frame, -rightHandView.frame.size.width, 0);
        
        //缩放
        CATransform3D scale = CATransform3DIdentity;
        model.fromView.layer.transform = CATransform3DScale(scale, ZOOM_SCALE, ZOOM_SCALE, 1);
        
    } completion:^(BOOL finished) {
        
        [leftHandView removeFromSuperview];
        [rightHandView removeFromSuperview];
        
         model.toView.frame=model.containerView.bounds;
        [contenxt completeTransition:![contenxt transitionWasCancelled]];
    }];
}
@end






