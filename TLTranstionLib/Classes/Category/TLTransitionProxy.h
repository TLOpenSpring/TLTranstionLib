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
#import "TLPortalAnimator.h"
#import "TLCubeAnimator.h"
#import "TLCardAnimator.h"
#import "TLFoldAnimator.h"
#import "TLExplodeAnimator.h"
#import "TLTurnAnimator.h"
#import "TLGeoAnimaotor.h"

@interface TLTransitionProxy : NSProxy<UINavigationControllerDelegate>
@property (nonatomic,weak)id<UINavigationControllerDelegate> delegate;
@property (nonatomic,strong)TLAnimator *tlAnimator;
@property (nonatomic,assign)TLAnimatorStyle animatorStyle;

@property NSTimeInterval tlDuration;

/**
 *  自定义的Animator
 */
@property (nonatomic,strong)TLFadeAnimator *tlfadeAnimator;
@property (nonatomic,strong)TLDivideAnimator *tlDivideAnimator;
@property (nonatomic,strong)TLFromTopAnimator *tlfromTopAnimator;
@property (nonatomic,strong)TLFromLeftAnimator *tlFromLeftAnimator;
@property (nonatomic,strong)TLFlipOverAnimator *tlFlipOverAnimator;
@property (nonatomic,strong)TLCoverVerticalAnimator *tlCoverVerticalAnimator;
@property (nonatomic,strong)TLPortalAnimator *tlPortalAnimator;
@property (nonatomic,strong)TLCubeAnimator *tlCubeAnimator;
@property (nonatomic,strong)TLCardAnimator *tlCardAnimator;
@property (nonatomic,strong)TLFoldAnimator *tlFoldAnimator;
@property (nonatomic,strong)TLExplodeAnimator *tlExplodeAnimator;
@property (nonatomic,strong)TLTurnAnimator *tlTurnAnimator;
@property (nonatomic,strong)TLGeoAnimaotor *tlGeoAnimator;
-(instancetype)init;
@end
