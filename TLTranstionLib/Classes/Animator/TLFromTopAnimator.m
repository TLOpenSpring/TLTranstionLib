//
//  TLFromTopAnimator.m
//  Pods
//
//  Created by Andrew on 16/5/3.
//
//

#import "TLFromTopAnimator.h"
#import "TransitionModel.h"
#import "TLSnapshotModel.h"

#define TAG  12306

@interface TLFromTopAnimator()
@property (nonatomic,strong)NSMutableArray *snapshots;
@end


@implementation TLFromTopAnimator
-(NSMutableArray *)snapshots{
    if(!_snapshots){
        _snapshots = [[NSMutableArray alloc]init];
    }
    return _snapshots;
}
/**
 *  执行动画的代码
 *
 *  @param transitionContext <#transitionContext description#>
 */
-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{

    TransitionModel *model=[[TransitionModel alloc]initWithTransitionContext:transitionContext];
    
    UIWindow *keyWindown = model.fromView.window;
    UIView *baseView = [keyWindown subviews].firstObject;
    
    if(self.operation == UINavigationControllerOperationPush){
        UIView *snapshotView = [baseView snapshotViewAfterScreenUpdates:NO];
        snapshotView.frame=baseView.frame;
        
        //创建一个蒙板
        UIView *maskView = [[UIView alloc]initWithFrame:snapshotView.bounds];
        maskView.backgroundColor=[UIColor blackColor];
        maskView.alpha=0;
        maskView.tag=TAG;
        [snapshotView addSubview:maskView];
        
        
        [model.containerView addSubview:model.toView];
        [keyWindown addSubview:snapshotView];
        [keyWindown bringSubviewToFront:baseView];
        
        CGRect originalFrame = baseView.frame;
        CGRect newFrame = baseView.frame;
        newFrame.origin.y=newFrame.size.height;
        baseView.frame=newFrame;
        
        
        CATransform3D transform = CATransform3DIdentity;
        transform.m34=-1.0/1000;
        transform = CATransform3DTranslate(transform, 0, 10, -60);
        transform = CATransform3DScale(transform, 0.98, 1, 1);
        
        [UIView animateWithDuration:[self animatorDuration] delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            baseView.frame=originalFrame;
            
            snapshotView.layer.transform=transform;
            maskView.alpha=0.5;
            
            
        } completion:^(BOOL finished) {
            [snapshotView removeFromSuperview];
            
            TLSnapshotModel *snapshot = nil;
            for (TLSnapshotModel *sp  in self.snapshots) {
                if(sp.viewcontroller == model.fromViewController){
                    snapshot = sp;
                    break;
                }
            }
            
            if(snapshot){
                snapshot.snapshotView = snapshotView;
            }else{
                snapshot  =  [[TLSnapshotModel alloc]init];
                snapshot.snapshotView = snapshotView;
                snapshot.viewcontroller = model.fromViewController;
                [self.snapshots addObject:snapshot];
            }
            
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
        
    }else if(self.operation == UINavigationControllerOperationPop){
        [self popOperation:model context:transitionContext];
    }else{
        [super animateTransition:transitionContext];
    }
}

-(void)popOperation:(TransitionModel *)model context:(id<UIViewControllerContextTransitioning>)context{
    
    UIWindow *keyWindown = model.fromView.window;
    UIView *baseView = [keyWindown subviews].firstObject;
    
    TLSnapshotModel *result = nil;
    for (int i = self.snapshots.count-1; i>=0; i--) {
        TLSnapshotModel *snapshot = [self.snapshots objectAtIndex:i];
        if(snapshot.viewcontroller == model.toViewController){
            result = snapshot;
            break;
        }
    }
    
    if(result){
        NSUInteger index = [self.snapshots indexOfObject:result];
        [self.snapshots removeObjectsInRange:NSMakeRange(index, self.snapshots.count - index)];
        if(result.snapshotView.frame.size.width == baseView.frame.size.height||
           result.snapshotView.frame.size.height == baseView.frame.size.width){
            result = nil;
        }
    }
    
    if(result){
        UIView *snapshotView = result.snapshotView;
        UIView *maskView = [snapshotView viewWithTag:TAG];
        
        [keyWindown addSubview:snapshotView];
        [keyWindown bringSubviewToFront:baseView];
      
        CGRect originalFrame = baseView.frame;
        CGRect newFrame = baseView.frame;
        newFrame.origin.y = newFrame.size.height;
        
        [UIView animateWithDuration:[self animatorDuration] animations:^{
            maskView.alpha=0;
            snapshotView.layer.transform=CATransform3DIdentity;
            baseView.frame=newFrame;
            
        } completion:^(BOOL finished) {
            
            baseView.frame=originalFrame;
            [model.containerView addSubview:model.toView];
            [snapshotView removeFromSuperview];
            
            [context completeTransition:![context transitionWasCancelled]];
        }];
    }else{
        [super animateTransition:context];
    }
}
@end











