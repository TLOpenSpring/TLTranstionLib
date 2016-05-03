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
    TLAnmimatorStyleNone = 1 << 100
};

#endif /* TLAnimatorStyle_h */
