//
//  TLFromLeftAnimator.m
//  Pods
//
//  Created by Andrew on 16/5/3.
//
//

#import "TLFromLeftAnimator.h"
#import "TLSnapshotModel.h"

#define TAGKEY 9999

@interface TLFromLeftAnimator()
@property (nonatomic, strong) NSMutableArray *snapshots;

@end

@implementation TLFromLeftAnimator
- (NSMutableArray *)snapshots {
    if (!_snapshots) {
        _snapshots = [NSMutableArray array];
    }
    return _snapshots;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    TransitionModel *model=[[TransitionModel alloc]initWithTransitionContext:transitionContext];
    
    UIWindow *keyWindow = model.fromView.window;
    UIView *baseView = [keyWindow subviews].firstObject;
    
    if(self.operation == UINavigationControllerOperationPush){
        [self pushOperation:model context:transitionContext];
    }else if(self.operation == UINavigationControllerOperationPop){
        [self popOperation:model context:transitionContext];
    }else{
        [super animateTransition:transitionContext];
    }
}

-(void)pushOperation:(TransitionModel *)model context:(id<UIViewControllerContextTransitioning>)context{
    
    UIWindow *keyWindow = model.fromView.window;
    UIView *baseView = [keyWindow subviews].firstObject;
    //获取屏幕快照
    UIView *snapshotView = [baseView snapshotViewAfterScreenUpdates:NO];
    snapshotView.frame = baseView.frame;
    
    UIView *maskView = [[UIView alloc]initWithFrame:snapshotView.bounds];
    maskView.alpha=0;
    maskView.tag = TAGKEY;
    [snapshotView addSubview:maskView];
    
    [model.containerView addSubview:model.toView];
    [keyWindow addSubview:snapshotView];
    [keyWindow bringSubviewToFront:baseView];
    
    
    CGRect originalFrame = baseView.frame;
    CGRect newFrame = baseView.frame;
    newFrame.origin.x = newFrame.origin.x + newFrame.size.width;
    baseView.frame=newFrame;
    
    
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -1.0/750;
    transform = CATransform3DTranslate(transform, 0, 0, -50);
    
    [UIView animateWithDuration:[self animatorDuration] animations:^{
        
        baseView.frame=originalFrame;
        snapshotView.layer.transform=transform;
        maskView.alpha=0.35;
        
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
            snapshot.snapshotView=snapshotView;
        }else{
            snapshot=[[TLSnapshotModel alloc]init];
            snapshot.snapshotView=snapshotView;
            snapshot.viewcontroller=model.fromViewController;
            [self.snapshots addObject:snapshot];
        }
        [context completeTransition:![context transitionWasCancelled]];
    }];
    
}

-(void)popOperation:(TransitionModel *)model context:(id<UIViewControllerContextTransitioning>)context{
    UIWindow *keyWindow = model.fromView.window;
    UIView *baseView = [keyWindow subviews].firstObject;
    
    TLSnapshotModel *result = nil;
    for (int i = self.snapshots.count-1; i>=0; i--) {
        TLSnapshotModel *snapshot = self.snapshots[i];
        if(snapshot.viewcontroller == model.toViewController){
            result=snapshot;
            break;
        }
    }
    
    if(result){
        NSUInteger index = [self.snapshots indexOfObject:result];
        [self.snapshots removeObjectsInRange:NSMakeRange(index, self.snapshots.count-index)];
        
        if(result.snapshotView.frame.size.width == baseView.frame.size.height ||
           result.snapshotView.frame.size.height == baseView.frame.size.width){
            result=nil;
        }
    }
    
    if(result){
        UIView *snapshotView = result.snapshotView;
        UIView *maskView = [snapshotView viewWithTag:TAGKEY];
        
        
        [keyWindow addSubview:snapshotView];
        [keyWindow bringSubviewToFront:baseView];
        
        CGRect originalFrame = baseView.frame;
        CGRect newFrame = baseView.frame;
        newFrame.origin.x = newFrame.origin.x + newFrame.size.width;
        
        
        [UIView animateWithDuration:[self animatorDuration] animations:^{
            
            maskView.alpha =0;
            snapshotView.layer.transform=CATransform3DIdentity;
            baseView.frame=newFrame;
            
        } completion:^(BOOL finished) {
            
            baseView.frame=originalFrame;
            [model.containerView addSubview:model.toView];
            [snapshotView removeFromSuperview];
            [context completeTransition:![context transitionWasCancelled]];
            
        }];
    }

}
@end
