//
//  TLTransitionProxy.m
//  Pods
//
//  Created by Andrew on 16/5/2.
//
//

#import "TLTransitionProxy.h"
#import "TLAnimatorStyle.h"
#import "TLAnimator.h"
#import "TLFadeAnimator.h"

@interface TLTransitionProxy()
@property (nonatomic,weak)id<UINavigationControllerDelegate> delegate;
@property (nonatomic,strong)TLAnimator *tlAnimator;

@property (nonatomic,assign)TLAnimatorStyle animatorStyle;

/**
 *  自定义的Animator
 */
@property (nonatomic,strong)TLFadeAnimator *tlfadeAnimator;
@end

@implementation TLTransitionProxy
-(instancetype)init{
    if(self){
        _delegate=nil;
    }
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
            
        default:
            break;
    }
    
    return _tlAnimator;
}

-(TLFadeAnimator *)tlfadeAnimator{
    if(!_tlfadeAnimator){
        _tlfadeAnimator=[[TLFadeAnimator alloc]init];
    }
    return _tlfadeAnimator;
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









