//
//  TLAnimator.h
//  Pods
//
//  Created by Andrew on 16/4/29.
//
//

#import <Foundation/Foundation.h>
#import "TransitionModel.h"

static NSTimeInterval duration = 0.3;

@interface TLAnimator : NSObject<UIViewControllerAnimatedTransitioning>

@property (nonatomic)UINavigationControllerOperation operation;


@end
