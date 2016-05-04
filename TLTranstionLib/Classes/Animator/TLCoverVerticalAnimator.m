//
//  TLCoverVerticalAnimator.m
//  Pods
//
//  Created by Andrew on 16/5/4.
//
//

#import "TLCoverVerticalAnimator.h"
#import "TLSnapshotModel.h"
#import "TransitionModel.h"

@interface TLCoverVerticalAnimator()
@property (nonatomic, strong) NSMutableArray *snapshots;
@end


@implementation TLCoverVerticalAnimator

-(NSMutableArray*)snapshots{
    if(!_snapshots){
        _snapshots=[[NSMutableArray alloc]init];
    }
    return _snapshots;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    TransitionModel *model=[[TransitionModel alloc]initWithTransitionContext:transitionContext];
    
    if(self.operation == UINavigationControllerOperationPush){
        [self pushOperation:model context:transitionContext];
    }else if(self.operation == UINavigationControllerOperationPop){
        [self popOperation:model context:transitionContext];
    }else{
        [super animateTransition:transitionContext];
    }
}

-(void)pushOperation:(TransitionModel*)model context:(id<UIViewControllerContextTransitioning>)context{
    UIWindow *keyWindow = model.fromView.window;
    UIView *baseView = [[keyWindow subviews] firstObject];
    
    UIColor *originalColor = keyWindow.backgroundColor;
    UIColor *newColor = model.toView.backgroundColor;
    
    CGFloat ratio = 0.5;
    CGFloat offset = 4;
    
    keyWindow.backgroundColor=newColor;
    UIView *snapshotView = [baseView snapshotViewAfterScreenUpdates:NO];
    snapshotView.frame=baseView.frame;
    
    [keyWindow addSubview:snapshotView];
    [keyWindow bringSubviewToFront:baseView];
    
    //把目标View添加到容器中
    [model.containerView addSubview:model.toView];
    
    CGRect originFrame = baseView.frame;
    CGRect newFrame = baseView.frame;
    if(self.tldirection == TLCoverDirectionFromTop){
        newFrame.origin.y -= newFrame.size.height;
    }else if(self.tldirection == TLCoverDirectionFromBottom){
        newFrame.origin.y += newFrame.size.height;
    }
    
    baseView.frame=newFrame;
    
    [UIView animateWithDuration:[self transitionDuration:context] animations:^{
        
        CGRect frame = snapshotView.frame;
        if(self.tldirection == TLCoverDirectionFromTop){
            frame.origin.y += frame.size.height;
        }else if(self.tldirection == TLCoverDirectionFromBottom){
            frame.origin.y -= frame.size.height;
        }
        snapshotView.frame=frame;
        
        frame=originFrame;
        if(self.tldirection == TLCoverDirectionFromTop){
            frame.origin.y += offset;
        }else if(self.tldirection == TLCoverDirectionFromBottom){
            frame.origin.y -= offset;
        }
        baseView.frame = frame;
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:[self transitionDuration:context]*(1-ratio) animations:^{
            //回复原状
            baseView.frame=originFrame;
            
        } completion:^(BOOL finished) {
            keyWindow.backgroundColor=originalColor;
            [snapshotView removeFromSuperview];
            
            TLSnapshotModel *snapshot = nil;
            for (TLSnapshotModel *sp in self.snapshots) {
                if(sp.viewcontroller == model.fromViewController){
                    snapshot = sp;
                    break;
                }
            }
            
            if(snapshot){
                snapshot.snapshotView = snapshotView;
            }else{
                snapshot=[[TLSnapshotModel alloc]init];
                snapshot.viewcontroller=model.fromViewController;
                snapshot.snapshotView=snapshotView;
                [self.snapshots addObject:snapshot];
                
                [context completeTransition:![context transitionWasCancelled]];
            }
        }];
    }];
    
}

-(void)popOperation:(TransitionModel*)model context:(id<UIViewControllerContextTransitioning>)context{
    UIWindow *keyWindow = model.fromView.window;
    UIView *baseView = [[keyWindow subviews] firstObject];
    UIColor *originalColor = keyWindow.backgroundColor;
    UIColor *newColor = model.toView.backgroundColor;
    
    CGFloat ratio = 0.5;
    CGFloat offset = 4;
    
    TLSnapshotModel *result = nil;
    for (int i = self.snapshots.count-1; i>=0; i--) {
        TLSnapshotModel *snapshot = self.snapshots[i];
        if(snapshot.viewcontroller == model.toViewController){
            result=snapshot;
            break;
        }
    }
    
    if(result){
        NSUInteger index=[self.snapshots indexOfObject:result];
        [self.snapshots removeObjectsInRange:NSMakeRange(index, self.snapshots.count-index)];
        if(result.snapshotView.frame.size.width==baseView.frame.size.height ||
           result.snapshotView.frame.size.height == baseView.frame.size.width){
            result=nil;
        }
    }
    
    if(result){
        keyWindow.backgroundColor=newColor;
        UIView *snapshotView = result.snapshotView;
        [keyWindow addSubview:snapshotView];
        
        CGRect originalFrame = baseView.frame;
        CGRect newFrame = baseView.frame;
        
        if(self.tldirection == TLCoverDirectionFromTop){
            newFrame.origin.y += newFrame.size.height;
        }else if(self.tldirection ==TLCoverDirectionFromBottom){
            newFrame.origin.y -= newFrame.size.height;
        }
        snapshotView.frame=newFrame;
        
        [UIView animateWithDuration:[self transitionDuration:context] animations:^{
            CGRect frame = baseView.frame;
            if(self.tldirection == TLCoverDirectionFromTop){
                frame.origin.y -= newFrame.size.height;
            }else if(self.tldirection ==TLCoverDirectionFromBottom){
                frame.origin.y += newFrame.size.height;
            }
            baseView.frame=frame;
            
            frame=originalFrame;
            if(self.tldirection == TLCoverDirectionFromTop){
                frame.origin.y -= offset;
            }else if(self.tldirection ==TLCoverDirectionFromBottom){
                frame.origin.y += offset;
            }
            snapshotView.frame=frame;
            
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:[self transitionDuration:context]*(1-ratio) animations:^{
                snapshotView.frame=originalFrame;
            } completion:^(BOOL finished) {
                keyWindow.backgroundColor=originalColor;
                
                baseView.frame=originalFrame;
                [model.containerView addSubview:model.toView];
                
                [snapshotView removeFromSuperview];
                
                [context completeTransition:![context transitionWasCancelled]];
            }];
        }];
    }
    
}
@end











