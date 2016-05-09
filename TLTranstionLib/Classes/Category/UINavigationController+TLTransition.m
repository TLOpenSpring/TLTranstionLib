//
//  UINavigationController+TLTransition.m
//  Pods
//
//  Created by Andrew on 16/4/29.
//
//

#import "UINavigationController+TLTransition.h"
#import "TLTransitionProxy.h"

@interface UINavigationController()<UIGestureRecognizerDelegate>
@property (nonatomic,strong)TLTransitionProxy *proxy;

@end

@implementation UINavigationController (TLTransition)
+ (void)load {
    // Method Swizzling
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        NSArray *originalSelectors = @[@"viewDidLoad", @"setDelegate:", @"delegate"];
        NSArray *swizzledSelectors = @[@"tl_viewDidLoad", @"tl_setDelegate:", @"tl_delegate"];
        
        for (int i = 0; i < originalSelectors.count; i++) {
            SEL originalSelector = NSSelectorFromString([originalSelectors objectAtIndex:i]);
            SEL swizzledSelector = NSSelectorFromString([swizzledSelectors objectAtIndex:i]);
            
            Method originalMethod = class_getInstanceMethod(class, originalSelector);
            Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
              /**
              *  动态的添加方法
              *
              *  @param class          向指定的类添加方法
              *  @param originalMethod 可以理解为方法名，这个貌似随便起名，比如我们这里叫‘sayHello2’
              *  @param swizzledMethod 实现这个方法的函数
              *  @param method_getTypeEncoding(originalMethod) 一个定义该函数返回值类型和参数类型的字符串
              *  @return 动态方法是否添加成功
              */
            BOOL result = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
            if (result) {
                /**
                 *  动态的替换类中指定的方法
                 *
                 *  @param class          指定的类
                 *  @param swizzledMethod 目标要被替换的方法
                 *  @param originalMethod 用这个实现方法去替换
                 *
                 *  @return
                 */
                class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
            } else {
                method_exchangeImplementations(originalMethod, swizzledMethod);
            }
        }
    });
}


#pragma mark method swizzling
-(void)tl_viewDidLoad{
    [self tl_viewDidLoad];
    self.interactivePopGestureRecognizer.delegate=self;
    self.delegate = self.delegate;
}

-(void)tl_setDelegate:(id<UINavigationControllerDelegate>)delegate{
    self.proxy.delegate=delegate;
    [self tl_setDelegate:self.proxy];
}

-(id<UINavigationControllerDelegate>)tl_delegate{
    return self.proxy.delegate;
}

#pragma mark 属性设置
-(TLTransitionProxy *)proxy{
    TLTransitionProxy *proxy = objc_getAssociatedObject(self, @selector(proxy));
    
    if(!proxy){
        proxy = [[TLTransitionProxy alloc]init];
        self.proxy=proxy;
    }
    return proxy;
}

-(void)setProxy:(TLTransitionProxy *)proxy{
    objc_setAssociatedObject(self, @selector(proxy), proxy, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(TLAnimatorStyle)animatorStyle{
    return self.proxy.animatorStyle;
}

-(void)setAnimatorStyle:(TLAnimatorStyle)animatorStyle{
    if(animatorStyle == TLAnmimatorStyleNone){
        animatorStyle=TLAnmimatorStyleSystem;
    }
    self.proxy.animatorStyle = animatorStyle;
}




-(void)setAnimatorDuration:(NSTimeInterval)animatorDuration{
    self.proxy.tlDuration=animatorDuration;
}


@end
