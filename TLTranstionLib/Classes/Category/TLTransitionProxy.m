//
//  TLTransitionProxy.m
//  Pods
//
//  Created by Andrew on 16/5/2.
//
//

#import "TLTransitionProxy.h"
#import "TLDivideAnimator.h"


@interface TLTransitionProxy()

@end

@implementation TLTransitionProxy
-(instancetype)init{
  
    _delegate=nil;
    
    return self;
}

/**
 *  触发代理的方法
 *
 *  @param invocation 一种消息传递机制
 */
-(void)forwardInvocation:(NSInvocation *)invocation{
    [invocation setTarget:self.delegate];
    [invocation invoke];
    return;
    
}
/**
 *  methodSignatureForSelector:的作用在于为另一个类实现的消息创建一个有效的方法签名，必须实现，并且返回不为空的methodSignature，否则会crash
 *
 *  @param sel  消息
 *
 *  @return 返回一个方法签名
 */
-(NSMethodSignature*)methodSignatureForSelector:(SEL)sel{
    return [(id)self.delegate methodSignatureForSelector:sel];
}
/**
 *  是否响应消息传来的方法
 *
 *  @param aSelector 消息传来的方法调用
 *
 *  @return 是否响应
 */
-(BOOL)respondsToSelector:(SEL)aSelector{
    if(sel_isEqual(aSelector, @selector(navigationController:animationControllerForOperation:fromViewController:toViewController:))||
       sel_isEqual(aSelector, @selector(navigationController:interactionControllerForAnimationController:))){
        return YES;
    }
    return [self.delegate respondsToSelector:aSelector];
}

-(void)setAnimatorStyle:(TLAnimatorStyle)animatorStyle{
    _animatorStyle=animatorStyle;
    self.tlAnimator=[self TL_animatorTransitionForStyle:animatorStyle];
}

-(void)setTlDuration:(NSTimeInterval)tlDuration{
    _tlDuration=tlDuration;
    self.tlAnimator.animatorDuration=tlDuration;
    
}

/**
 *  根据设置的动画样式设置动画类型
 *
 *  @param style 转场样式
 *
 *  @return 转场动画类型
 */
-(TLAnimator*)TL_animatorTransitionForStyle:(TLAnimatorStyle)style{
    
    TLAnimator *baseAnimator=nil;
    
    switch (style) {
        case TLAnmimatorStyleFade:
            baseAnimator=[self tlfadeAnimator];
            break;
        case TLAnmimatorStyleDivide:
            baseAnimator=[self tlDivideAnimator];
            break;
        case TLAnmimatorStyleFromTop:
            baseAnimator=[self tlfromTopAnimator];
            break;
        case TLAnmimatorStyleFromLeft:
            baseAnimator=[self tlFromLeftAnimator];
            break;
        case TLAnmimatorStyleFlipOver:
            baseAnimator=[self tlFlipOverAnimator];
            break;
        case TLAnmimatorStyleCoverVerticalFromTop:
        {
            TLCoverVerticalAnimator *coverAnimator=[self tlCoverVerticalAnimator];
            coverAnimator.tldirection=TLCoverDirectionFromTop;
            baseAnimator=coverAnimator;
        }
            break;
        case TLAnmimatorStyleCoverVerticalFromBottom:
        {
            TLCoverVerticalAnimator *coverAnimator=[self tlCoverVerticalAnimator];
            coverAnimator.tldirection=TLCoverDirectionFromBottom;
            baseAnimator=coverAnimator;
        }
            break;
            
        case TLAnmimatorStyleCube:
            baseAnimator=[self tlCubeAnimator];
            break;
        case TLAnmimatorStylePortal:
            baseAnimator=[self tlPortalAnimator];
            break;
        case TLAnmimatorStyleCard:
            baseAnimator=[self tlCardAnimator];
            break;
        case TLAnmimatorStyleFold:
            baseAnimator=[self tlFoldAnimator];
            break;
        case TLAnmimatorStyleExplode:
            baseAnimator=[self tlExplodeAnimator];
            break;
        case TLAnmimatorStyleTurn:
            baseAnimator=[self tlTurnAnimator];
            break;
        case TLAnmimatorStyleGeo:
            baseAnimator=[self tlGeoAnimator];
            break;
        case TLAnmimatorStyleFlip:
            baseAnimator=[self tlFlipAnimator];
            break;
        default:
            break;
    }
    
    return baseAnimator;
}

#pragma mark 
#pragma mark 自定义的转场动画
-(TLFadeAnimator *)tlfadeAnimator{
    if(!_tlfadeAnimator){
        _tlfadeAnimator=[[TLFadeAnimator alloc]init];
    }
    return _tlfadeAnimator;
}
-(TLFlipAnimator*)tlFlipAnimator{
    if(!_tlFlipAnimator){
        _tlFlipAnimator = [[TLFlipAnimator alloc]init];
    }
    return _tlFlipAnimator;
}

-(TLDivideAnimator*)tlDivideAnimator{
    if(!_tlDivideAnimator){
        _tlDivideAnimator=[[TLDivideAnimator alloc]init];
    }
    return _tlDivideAnimator;
}
-(TLFromTopAnimator *)tlfromTopAnimator{
    if(!_tlfromTopAnimator){
        _tlfromTopAnimator=[[TLFromTopAnimator alloc]init];
    }
    return _tlfromTopAnimator;
}
-(TLFromLeftAnimator*)tlFromLeftAnimator{
    if(!_tlFromLeftAnimator){
        _tlFromLeftAnimator=[[TLFromLeftAnimator alloc]init];
    }
    return _tlFromLeftAnimator;
}

-(TLFlipOverAnimator *)tlFlipOverAnimator{
    if(!_tlFlipOverAnimator){
        _tlFlipOverAnimator=[[TLFlipOverAnimator alloc]init];
    }
    return _tlFlipOverAnimator;
}
-(TLCoverVerticalAnimator *)tlCoverVerticalAnimator{
    if(!_tlCoverVerticalAnimator){
        _tlCoverVerticalAnimator=[[TLCoverVerticalAnimator alloc]init];
    }
    return _tlCoverVerticalAnimator;
}
-(TLCubeAnimator*)tlCubeAnimator{
    if(!_tlCubeAnimator){
        _tlCubeAnimator=[[TLCubeAnimator alloc]init];
    }
    return _tlCubeAnimator;
}
-(TLPortalAnimator*)tlPortalAnimator{
    if(!_tlPortalAnimator){
        _tlPortalAnimator=[[TLPortalAnimator alloc]init];
    }
    return _tlPortalAnimator;
}
-(TLCardAnimator *)tlCardAnimator{
    if(!_tlCardAnimator){
        _tlCardAnimator=[[TLCardAnimator alloc]init];
     }
    return _tlCardAnimator;
}
-(TLFoldAnimator *)tlFoldAnimator{
    if(!_tlFoldAnimator){
        _tlFoldAnimator=[[TLFoldAnimator alloc]init];
    }
    return _tlFoldAnimator;
}
-(TLExplodeAnimator*)tlExplodeAnimator{
    if(!_tlExplodeAnimator){
        _tlExplodeAnimator = [[TLExplodeAnimator alloc]init];
    }
    return _tlExplodeAnimator;
}

-(TLTurnAnimator*)tlTurnAnimator{
    if(!_tlTurnAnimator){
            _tlTurnAnimator = [[TLTurnAnimator alloc]init];
    }
    return _tlTurnAnimator;
}

-(TLGeoAnimaotor*)tlGeoAnimator{
    if(!_tlGeoAnimator){
        _tlGeoAnimator = [[TLGeoAnimaotor alloc]init];
    }
    return _tlGeoAnimator;
}


#pragma mark -- UINavigationControllerDelegate
-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{

    id<UIViewControllerAnimatedTransitioning> animatorTransitioning=nil;
    //如果程序中调用了这个代理方法
    if([self.delegate respondsToSelector:_cmd]){
        animatorTransitioning=[self.delegate navigationController:navigationController animationControllerForOperation:operation fromViewController:fromVC toViewController:toVC];
        if(animatorTransitioning){
            return animatorTransitioning;
        }
    }
    
    switch (operation) {
        case UINavigationControllerOperationNone:
            animatorTransitioning=nil;
            return animatorTransitioning;
            break;
            
        default:
        {
            TLAnimatorStyle style=fromVC.navigationAnimatorStyle;
            
            if(style != TLAnmimatorStyleNone){
                TLAnimator *baseAnimator = [self TL_animatorTransitionForStyle:style];
                baseAnimator.operation=operation;
                animatorTransitioning =baseAnimator;
            }else{
                self.tlAnimator.operation=operation;
                animatorTransitioning=_tlAnimator;
            }
            return animatorTransitioning;
        }
            break;
    }
    
    return animatorTransitioning;
}

-(id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController{
    return nil;
}

@end









