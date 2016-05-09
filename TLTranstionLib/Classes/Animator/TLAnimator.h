//
//  TLAnimator.h
//  Pods
//
//  Created by Andrew on 16/4/29.
//
//

#import <Foundation/Foundation.h>
#import "TransitionModel.h"



@interface TLAnimator : NSObject<UIViewControllerAnimatedTransitioning>

@property (nonatomic)UINavigationControllerOperation operation;

@property BOOL reverse;

@property NSTimeInterval animatorDuration;


@end
