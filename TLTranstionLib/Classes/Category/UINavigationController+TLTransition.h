//
//  UINavigationController+TLTransition.h
//  Pods
//
//  Created by Andrew on 16/4/29.
//
//

#import <UIKit/UIKit.h>
#import "UIViewController+TLTransition.h"
#import "TLAnimatorStyle.h"

@interface UINavigationController (TLTransition)
@property (nonatomic,assign)TLAnimatorStyle animatorStyle;
@end
