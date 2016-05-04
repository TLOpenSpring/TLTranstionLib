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
#import "TLAnimatorStyle.h"
#import "TLAnimator.h"
#import "TLFadeAnimator.h"
#import "TLDivideAnimator.h"
#import "TLFromTopAnimator.h"
#import "TLFromLeftAnimator.h"
#import "TLFlipOverAnimator.h"
#import "TLCoverVerticalAnimator.h"

@interface TLTransitionProxy : NSProxy<UINavigationControllerDelegate>
@property (nonatomic,weak)id<UINavigationControllerDelegate> delegate;
@property (nonatomic,strong)TLAnimator *tlAnimator;
@property (nonatomic,assign)TLAnimatorStyle animatorStyle;

/**
 *  自定义的Animator
 */
@property (nonatomic,strong)TLFadeAnimator *tlfadeAnimator;
@property (nonatomic,strong)TLDivideAnimator *tlDivideAnimator;
@property (nonatomic,strong)TLFromTopAnimator *tlfromTopAnimator;
@property (nonatomic,strong)TLFromLeftAnimator *tlFromLeftAnimator;
@property (nonatomic,strong)TLFlipOverAnimator *tlFlipOverAnimator;
@property (nonatomic,strong)TLCoverVerticalAnimator *tlCoverVerticalAnimator;
-(instancetype)init;
@end
