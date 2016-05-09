//
//  TLTurnAnimator.h
//  Pods
//
//  Created by Andrew on 16/5/9.
//
//

#import "TLAnimator.h"

typedef NS_ENUM(NSInteger,TLDirection){
    TLDirection_Horizontal,
    TLDirection_Vertical
};


@interface TLTurnAnimator : TLAnimator

@property (nonatomic)TLDirection flipDirection;
@end
