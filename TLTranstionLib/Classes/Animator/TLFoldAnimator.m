//
//  TLFoldAnimator.m
//  Pods
//
//  Created by Andrew on 16/5/6.
//
//

#import "TLFoldAnimator.h"
#import "TransitionModel.h"

@implementation TLFoldAnimator

-(instancetype)init{
    self=[super init];
    if(self){
        _folds=2;
    }
    return self;
}

/**
 *  执行动画
 *
 *  @param transitionContext <#transitionContext description#>
 */
-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{

    
    if(self.operation==UINavigationControllerOperationPop){
        self.reverse=YES;
    }else{
        self.reverse=NO;
    }
    
    TransitionModel *model=[[TransitionModel alloc]initWithTransitionContext:transitionContext];
    //move offscreen
    model.toView.frame = CGRectOffset(model.toView.frame,model.toView.frame.size.width, 0);
    [model.containerView addSubview:model.toView];
    
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -0.0005;
    model.containerView.layer.sublayerTransform = transform;
    
    CGSize size = model.toView.frame.size;
    
    float foldwidth = size.width * 0.5 /(float)self.folds;
    
    //存储屏幕截图的数组
    NSMutableArray *fromViewFolds = [[NSMutableArray alloc]init];
    NSMutableArray *toViewFolds=[[NSMutableArray alloc]init];
    
    
    // create the folds for the form- and to- views
    for (int i = 0; i<self.folds; i++) {
        float offset = (float)i*foldwidth*2;
        
        //设置左边的fold
        UIView *leftFromViewFold = [self createSnapshotFromView:model.fromView afterUpdates:NO location:offset left:YES];
        
        leftFromViewFold.layer.position = CGPointMake(offset, size.height/2);
        
        [fromViewFolds addObject:leftFromViewFold];
        NSLog(@"leftFromViewFold.subviews[1]:%@",leftFromViewFold.subviews[1]);
        //leftFromViewFold.subviews[1]指定的是有阴影的shadowView
        [leftFromViewFold.subviews[1] setAlpha:1];
        
        
        //设置右边的fold
        UIView *rightFromViewFold = [self createSnapshotFromView:model.fromView afterUpdates:NO location:offset+foldwidth left:NO];
        rightFromViewFold.layer.position = CGPointMake(offset + foldwidth*2, size.height/2);
        [fromViewFolds addObject:rightFromViewFold];
         //rightFromViewFold.subviews[1]指定的是有阴影的shadowView
        [rightFromViewFold.subviews[1] setAlpha:1];
        
        //目标视图的左边和右边使用 90度 transform ，并且设置alpha = 1
        UIView *leftToViewFold = [self createSnapshotFromView:model.toView afterUpdates:YES location:offset left:YES];
        leftToViewFold.layer.position = CGPointMake(self.reverse?size.width:0, size.height/2);
        leftToViewFold.layer.transform = CATransform3DMakeRotation(M_PI_2, 0, 1, 0);
        [toViewFolds addObject:leftToViewFold];
        
        UIView *rightToViewFold = [self createSnapshotFromView:model.toView afterUpdates:YES location:offset+foldwidth left:NO];
        rightToViewFold.layer.position = CGPointMake(self.reverse?size.width:0, size.height/2);
        rightToViewFold.layer.transform = CATransform3DMakeRotation(-M_PI_2, 0, 1, 0);
        
        [toViewFolds addObject:rightToViewFold];
    }
    
    
    //移动这from 远离屏幕
    model.fromView.frame = CGRectOffset(model.fromView.frame, model.fromView.frame.size.width, 0);
    
    //开始动画
    NSTimeInterval duration = [self animatorDuration];
    
    [UIView animateWithDuration:duration animations:^{
        
        //set the final state for each fold
        for (int i=0; i<self.folds; i++) {
            float offset = i*foldwidth*2;
            
            //这个fromview的左边和右边设置transform为90度，并且设置alpha = 1
            UIView *leftFromView = fromViewFolds[i*2];
            leftFromView.layer.position = CGPointMake(self.reverse?0:size.width, size.height/2);
            leftFromView.layer.transform = CATransform3DRotate(transform, M_PI_2, 0, 1, 0);
            [leftFromView.subviews[1] setAlpha:1];
            
            UIView *rightFromView = fromViewFolds[i*2+1];
            rightFromView.layer.position = CGPointMake(self.reverse?0:size.width, size.height/2);
            rightFromView.layer.transform = CATransform3DRotate(transform, -M_PI_2, 0, 1, 0);
            [rightFromView.subviews[1] setAlpha:1];
            
            
            
            UIView *leftToView = toViewFolds[i*2];
            leftToView.layer.position = CGPointMake(offset, size.height/2);
            leftToView.layer.transform = CATransform3DIdentity;
            //leftToView.subviews[1]指定的是有阴影的shadowView
            [leftToView.subviews[1] setAlpha:0];
            
            UIView *rightToView= toViewFolds[i*2+1];
            rightToView.layer.position = CGPointMake(offset+foldwidth*2, size.height/2);
            rightToView.layer.transform = CATransform3DIdentity;
            //rightToView.subviews[1]指定的是有阴影的shadowView
            [rightToView.subviews[1] setAlpha:0];
        }
        
    } completion:^(BOOL finished) {
        for (UIView *view in toViewFolds) {
            [view removeFromSuperview];
        }
        
        for (UIView *view in fromViewFolds) {
            [view removeFromSuperview];
        }
        if([transitionContext transitionWasCancelled]){
            model.fromView.frame=model.containerView.bounds;
        }else{
            model.toView.frame = model.containerView.bounds;
            model.fromView.frame=model.containerView.bounds;
        }
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
    
}


/**
 *  根据指定的View创建屏幕快照
 *
 *  @param view         指定的View
 *  @param afterUpdates 截完图后是否更新
 *  @param offset       移动的距离
 *  @param left         是否是屏幕的左边快照
 *
 *  @return 屏幕快照
 */
-(UIView*)createSnapshotFromView:(UIView *)view
                    afterUpdates:(BOOL)afterUpdates
                        location:(CGFloat)offset
                            left:(BOOL)left{
    
    CGSize size = view.frame.size;
    UIView *contentView = view.superview;
    float foldWidth = size.width * 0.5 /(float) self.folds;
    UIView *snapshotView;
    
    if(!afterUpdates){
        //创建一个屏幕快照
        CGRect snapshotRegion = CGRectMake(offset, 0, foldWidth, size.height);
        snapshotView=[view resizableSnapshotViewFromRect:snapshotRegion afterScreenUpdates:afterUpdates withCapInsets:UIEdgeInsetsZero];
        
    }else{
    
        snapshotView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, foldWidth, size.height)];
        snapshotView.backgroundColor=view.backgroundColor;
        CGRect snapshotRegion = CGRectMake(offset, 0, foldWidth, size.height);
        
        UIView *snapshotView2 = [view resizableSnapshotViewFromRect:snapshotRegion afterScreenUpdates:afterUpdates withCapInsets:UIEdgeInsetsZero];
        
        [snapshotView addSubview:snapshotView2];
    }
    
    //创建阴影
    UIView *snapshotWithShowdowView = [self addShadowToView:snapshotView reverse:left];
    
    //添加到容器中
    [contentView addSubview:snapshotWithShowdowView];
    
    //设置坐标在左边或者在右边
    snapshotWithShowdowView.layer.anchorPoint=CGPointMake(left?0:1, 0.5);

    return snapshotWithShowdowView;
}


/**
 *  给指定的View添加阴影视图，并且作为子视图
 *
 *  @param view    指定的视图
 *  @param reverse 转换
 *
 *  @return
 */
-(UIView *)addShadowToView:(UIView *)view reverse:(BOOL)reverse{

    UIView *viewWithShadow =[[UIView alloc]initWithFrame:view.frame];
    
    //create a shadow
    UIView *shadowView = [[UIView alloc]initWithFrame:viewWithShadow.bounds];
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame=shadowView.bounds;
    
    gradient.colors=@[(id)[UIColor colorWithWhite:0.0 alpha:0.0].CGColor,
                      (id)[UIColor colorWithWhite:0.0 alpha:1.0].CGColor];
    gradient.startPoint = CGPointMake(reverse?0.0:1.0, reverse?0.2:0.0);
    gradient.endPoint = CGPointMake(reverse?1.0:0.0, reverse?0.0:1.0);
    
    [shadowView.layer insertSublayer:gradient atIndex:1];
    
    
    //add the original view into our view
    view.frame= view.bounds;
    [viewWithShadow addSubview:view];
    
    // place the shadow on top
    [viewWithShadow addSubview:shadowView];
    return viewWithShadow;
}






@end
