//
//  TLFlipOverAnimator.m
//  Pods
//
//  Created by Andrew on 16/5/3.
//
//

#import "TLFlipOverAnimator.h"
#import "TransitionModel.h"
#import "TLSnapshotModel.h"


#define TAG 12306

@interface TLFlipOverAnimator ()
@property (nonatomic,strong)NSMutableArray *snapshots;
@end

@implementation TLFlipOverAnimator

-(NSMutableArray *)snapshots{
    if(!_snapshots){
        _snapshots=[[NSMutableArray alloc]init];
    }
    return _snapshots;
}
/**
 *  执行动画
 *
 *  @param transitionContext <#transitionContext description#>
 */
-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
 
    TransitionModel *model=[[TransitionModel alloc]initWithTransitionContext:transitionContext];
    if(self.operation==UINavigationControllerOperationPush){
        [self pushOperation:model context:transitionContext];
    }else{
        [super animateTransition:transitionContext];
    }
    
}

-(void)pushOperation:(TransitionModel *)model context:(id<UIViewControllerContextTransitioning>)context{
    UIWindow *keyWindow = model.fromView.window;
    UIView *baseView = [[keyWindow subviews] firstObject];
    
    CGFloat m34 = -1/5000.0;
    CATransform3D startTransform = CATransform3DIdentity;
    
    startTransform.m34=m34;
    startTransform=CATransform3DRotate(startTransform, M_PI/2.0, 0, 1, 0);
    
    CATransform3D endTranssform =CATransform3DIdentity;
    endTranssform.m34=m34;
    
    UIView *snapshotView = [baseView snapshotViewAfterScreenUpdates:NO];
    snapshotView.frame=baseView.frame;
    
    UIView *maskView = [[UIView alloc]initWithFrame:snapshotView.bounds];
    maskView.backgroundColor=[UIColor blackColor];
    maskView.alpha=0;
    maskView.tag=TAG;
    [snapshotView addSubview:maskView];
    
    [model.containerView addSubview:model.toView];
    
    [keyWindow addSubview:snapshotView];
    [keyWindow bringSubviewToFront:baseView];
    
    
    CGPoint anchorPoint = baseView.layer.anchorPoint;
    CGPoint position = baseView.layer.position;
    baseView.layer.anchorPoint=CGPointMake(1, 0.5);
    baseView.layer.position = CGPointMake(position.x+baseView.layer.bounds.size.width/2, position.y);
    baseView.layer.transform=startTransform;
    
    
    [UIView animateWithDuration:3 animations:^{
        baseView.layer.transform=endTranssform;
        maskView.alpha=0.35;
        
    } completion:^(BOOL finished) {
        [snapshotView removeFromSuperview];
        
        baseView.layer.transform=CATransform3DIdentity;
        baseView.layer.anchorPoint = anchorPoint;
        baseView.layer.position=position;
        
        TLSnapshotModel *snapshot = nil;
        for (TLSnapshotModel *sp in self.snapshots) {
            if(sp.viewcontroller == model.fromViewController){
                snapshot=sp;
                break;
            }
        }
        
        if(snapshot){
            snapshot.snapshotView=snapshotView;
        }else{
            snapshot=[[TLSnapshotModel alloc]init];
            snapshot.viewcontroller=model.fromViewController;
            snapshot.snapshotView=snapshotView;
            [self.snapshots addObject:snapshot];
        }
        
        [context completeTransition:![context transitionWasCancelled]];
    }];
    
}

-(void)popOperation:(TransitionModel *)model context:(id<UIViewControllerContextTransitioning>)context{
    UIWindow *keyWindow = model.fromView.window;
    UIView *baseView = [[keyWindow subviews] firstObject];
}
@end
