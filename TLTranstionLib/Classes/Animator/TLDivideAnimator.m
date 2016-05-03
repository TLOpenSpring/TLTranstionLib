//
//  TLDivideAnimator.m
//  Pods
//
//  Created by Andrew on 16/5/3.
//
//

#import "TLDivideAnimator.h"
#import "TransitionModel.h"
#import "TLSnapshotModel.h"


@interface TLDivideAnimator ()
/**
 *  屏幕截图/快照
 */
@property (nonatomic,strong)NSMutableArray *snapshots;

@end

@implementation TLDivideAnimator

-(NSMutableArray *)snapshots{
    if(!_snapshots){
        _snapshots = [[NSMutableArray alloc]init];
    }
    return _snapshots;
}

/**
 *  实现动画
 *
 *  @param transitionContext 上下文
 */
-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
     TransitionModel *model=[[TransitionModel alloc]initWithTransitionContext:transitionContext];
    
    UIView *baseView = [model.fromView.window subviews].firstObject;
    CGFloat width = baseView.bounds.size.width;
    CGFloat height = baseView.bounds.size.height;
    
    if(self.operation == UINavigationControllerOperationPush){
        CGFloat position = height / 2;
        
        CGRect topFrame = CGRectMake(0, 0, width, position);
        CGRect bottomFrame = CGRectMake(0, position, width, height-position);
        
        
        UIView *snapshotTop = [baseView resizableSnapshotViewFromRect:topFrame afterScreenUpdates:NO withCapInsets:UIEdgeInsetsZero];
        UIView *snapshotBottom =[baseView resizableSnapshotViewFromRect:bottomFrame afterScreenUpdates:NO withCapInsets:UIEdgeInsetsZero];
        
        snapshotTop.frame=topFrame;
        snapshotBottom.frame=bottomFrame;
        
        [baseView addSubview:snapshotTop];
        [baseView addSubview:snapshotBottom];
    
        [model.containerView addSubview:model.toView];
        
        topFrame.origin.y=-topFrame.size.height;
        bottomFrame.origin.y=baseView.bounds.size.height;
        
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            snapshotTop.frame=topFrame;
            snapshotTop.alpha=0;
            
            snapshotBottom.frame = bottomFrame;
            snapshotBottom.alpha=0;
            
        } completion:^(BOOL finished) {
            [snapshotBottom removeFromSuperview];
            [snapshotTop removeFromSuperview];
            
            
            TLSnapshotModel *snapshot = nil;
            for (TLSnapshotModel *sp in self.snapshots) {
                if(sp.viewcontroller == model.fromViewController){
                    snapshot=sp;
                    break;
                }
            }
            
            if(snapshot){
                snapshot.snapshotTopView=snapshotTop;
                snapshot.snapshotBottomView=snapshotBottom;
            }else{
                snapshot=[[TLSnapshotModel alloc]init];
                snapshot.viewcontroller=model.fromViewController;
                snapshot.snapshotTopView=snapshotTop;
                snapshot.snapshotBottomView=snapshotBottom;
                [self.snapshots addObject:snapshot];
            }
            
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            
        }];
        
    }else if(self.operation == UINavigationControllerOperationPop){
        
        TLSnapshotModel *result = nil;
        //倒序，依次把Navigationcontroller栈中的控制器移除
        for (int i =self.snapshots.count-1; i>=0; i--) {
            TLSnapshotModel *sp = self.snapshots[i];
            if(sp.viewcontroller == model.toViewController){
                result=sp;
                break;
            }
        }
        
        if(result){
            NSUInteger index = [self.snapshots indexOfObject:result];
            [self.snapshots removeObjectsInRange:NSMakeRange(index, self.snapshots.count-index)];
            if(result.snapshotTopView.frame.size.width == baseView.frame.size.height || result.snapshotBottomView.frame.size.height == baseView.frame.size.width){
                result = nil;
            }
            
        }
        if(result){
            UIView *snapshotTop = result.snapshotTopView;
            UIView *snapshotBottom = result.snapshotBottomView;
            
            CGRect topFrame = snapshotTop.frame;
            CGRect bottomFrame = snapshotBottom.frame;
            
            snapshotBottom.alpha=0;
            snapshotTop.alpha=0;
            
            [baseView addSubview:snapshotTop];
            [baseView addSubview:snapshotBottom];
            
            topFrame.origin.y=0;
            bottomFrame.origin.y=height-bottomFrame.size.height;
            
            
            [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
                
                snapshotTop.frame=topFrame;
                snapshotBottom.frame=bottomFrame;
                
                snapshotBottom.alpha=1;
                snapshotTop.alpha=1;
            } completion:^(BOOL finished) {
                [model.containerView addSubview:model.toView];
                
                [snapshotTop removeFromSuperview];
                [snapshotBottom removeFromSuperview];
                
                //设置上下文的完成状态
                [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            }];
        }
        
       
    }else{
      [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }
}


@end
