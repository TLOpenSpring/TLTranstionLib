//
//  TLAnimatorStyle.h
//  Pods
//
//  Created by Andrew on 16/5/2.
//
//

#ifndef TLAnimatorStyle_h
#define TLAnimatorStyle_h


typedef NS_ENUM (NSInteger, TLAnimatorStyle) {
    TLAnmimatorStyleSystem  =   1 << 0,
    TLAnmimatorStyleFade    =   1 << 1,
    TLAnmimatorStyleDivide  =   1 << 2,
    TLAnmimatorStyleFromTop =   1 << 3,
    TLAnmimatorStyleFromLeft=   1 << 4,
    TLAnmimatorStyleFlipOver=   1 << 5,
    TLAnmimatorStyleCoverVerticalFromTop=   1 << 6,
    TLAnmimatorStyleCoverVerticalFromBottom=   1 << 7,
    TLAnmimatorStyleCube=   1 << 8,
    TLAnmimatorStylePortal=   1 << 9,
    TLAnmimatorStyleCard=   1 << 10,
    TLAnmimatorStyleFold=   1 << 11,
    TLAnmimatorStyleExplode=   1 << 12,
    TLAnmimatorStyleTurn=   1 << 13,
    TLAnmimatorStyleGeo=   1 << 14,
    TLAnmimatorStyleFlip=   1 << 15,
    TLAnmimatorStyleNone = 1 << 100
};

#endif /* TLAnimatorStyle_h */
