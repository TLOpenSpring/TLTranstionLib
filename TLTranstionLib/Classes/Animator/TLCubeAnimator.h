//
//  TLCubeAnimator.h
//  Pods
//
//  Created by Andrew on 16/5/4.
//
//

#import "TLAnimator.h"

/**
 翻转方向
 */
typedef enum {
  TLCubeHorizontal,
  TLCubeVertical
}TLCubeDirecation;

/**
 翻转类型
 */
typedef enum {
    TLCubeTypeInverse,
    TLCubeTypeNormal
}TLCubeType;

@interface TLCubeAnimator : TLAnimator
@property (nonatomic,assign)TLCubeType cubetype;
@property (nonatomic,assign)TLCubeDirecation cubeDirection;
@end
