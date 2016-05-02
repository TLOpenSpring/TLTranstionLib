//
//  UIViewController+TLTransition.m
//  Pods
//   运行时获取用户设置的TLAnimatorStyle
//  Created by Andrew on 16/5/2.
//
//

#import "UIViewController+TLTransition.h"
#import <objc/runtime.h>
#import "TLAnimatorStyle.h"

static char TransitionStyleKey;

@implementation UIViewController (TLTransition)
/**
 *  自定义的转场动画
 *
 *  @return 自定义的转场动画样式
 */
-(TLAnimatorStyle)navigationAnimatorStyle{
    NSNumber *style = objc_getAssociatedObject(self, &TransitionStyleKey);
    if(!style){
        style = @(TLAnmimatorStyleNone);
        self.navigationAnimatorStyle = [style unsignedIntegerValue];
    }
    
    return [style unsignedIntegerValue];
}

-(void)setNavigationAnimatorStyle:(TLAnimatorStyle)navigationAnimatorStyle{
    objc_setAssociatedObject(self, &TransitionStyleKey, @(navigationAnimatorStyle), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end
