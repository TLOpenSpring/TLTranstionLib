//
//  TLCoverVerticalAnimator.h
//  Pods
//
//  Created by Andrew on 16/5/4.
//
//

#import "TLAnimator.h"

typedef enum :NSInteger{
    TLCoverDirectionFromTop,
    TLCoverDirectionFromBottom
}TLCoverDirection;

@interface TLCoverVerticalAnimator : TLAnimator

@property (nonatomic,assign)TLCoverDirection tldirection;
@end
