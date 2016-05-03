//
//  TLSnapshotModel.h
//  Pods
//
//  Created by Andrew on 16/5/3.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TLSnapshotModel : NSObject
@property (nonatomic,weak)UIViewController *viewcontroller;
/**
 *  屏幕快照的顶部视图
 */
@property (nonatomic,strong)UIView *snapshotTopView;
/**
 *  屏幕快照的底部视图
 */
@property (nonatomic,strong)UIView *snapshotBottomView;


/**
 *  整个屏幕快照
 */
@property (nonnull,strong)UIView *snapshotView;
@end
