//
//  TLExplodeAnimator.m
//  Pods
//
//  Created by Andrew on 16/5/9.
//
//

#import "TLExplodeAnimator.h"
#import "TransitionModel.h"

@implementation TLExplodeAnimator

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
 
    TransitionModel *model = [[TransitionModel alloc]initWithTransitionContext:transitionContext];
   
    [model.containerView addSubview:model.toView];
    [model.containerView sendSubviewToBack:model.toView];
    
    
    CGSize size = model.toView.frame.size;
    
    NSMutableArray *snapshots = [NSMutableArray new];
    
    CGFloat xFactor = 20;
    CGFloat yFactor = xFactor *size.height /size.width;
    
    //开始屏幕截图
    UIView *fromViewSnapshot = [model.fromView snapshotViewAfterScreenUpdates:NO];
    
    //创建屏幕截图的每个爆炸碎片
    
    for (CGFloat x = 0; x<size.width; x+=size.width/xFactor) {
        for (CGFloat y = 0; y<size.height; y+=size.height/yFactor) {
            
            CGRect snapshotRegion = CGRectMake(x, y, size.width/xFactor, size.height/yFactor);
            
            UIView *snapshot = [fromViewSnapshot resizableSnapshotViewFromRect:snapshotRegion afterScreenUpdates:NO withCapInsets:UIEdgeInsetsZero];
            snapshot.frame = snapshotRegion;
            [model.containerView addSubview:snapshot];
            [snapshots addObject:snapshot];
        }
    }
    
    [model.containerView sendSubviewToBack:model.fromView];
    
    
    
    
    NSTimeInterval duration = [self animatorDuration];
    
    //动画
    [UIView animateWithDuration:duration animations:^{
        
        for (UIView *view in snapshots) {
            CGFloat xOffset = [self randomFloatBetween:-100 and:100];
            CGFloat yOffset = [self randomFloatBetween:-100 and:100];
            view.frame=CGRectOffset(view.frame, xOffset, yOffset);
            view.alpha=0;
            
            CGAffineTransform transform=CGAffineTransformMakeRotation([self randomFloatBetween:-10 and:10]);
            
            view.transform = CGAffineTransformScale(transform, 0.01, 0.01);
        }
        
    } completion:^(BOOL finished) {
        
        for (UIView *view in snapshots) {
            [view removeFromSuperview];
        }
        
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
    
}

-(float)randomFloatBetween:(float)smallNumber and:(float)bigNumber{
    float diff = bigNumber - smallNumber;
    return (((float) (arc4random() % ((unsigned)RAND_MAX + 1)) / RAND_MAX) * diff) + smallNumber;
}
@end


















