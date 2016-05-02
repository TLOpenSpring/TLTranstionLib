//
//  TLTransitionProxy.h
//  Pods
//
//  Created by Andrew on 16/5/2.
//
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "UIViewController+TLTransition.h"

@interface TLTransitionProxy : NSProxy<UINavigationControllerDelegate>

@end
