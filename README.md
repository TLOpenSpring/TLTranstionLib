# TLTranstionLib
<<<<<<< HEAD

[![CI Status](http://img.shields.io/travis/Andrew/TLTranstionLib.svg?style=flat)](https://travis-ci.org/Andrew/TLTranstionLib)
[![Version](https://img.shields.io/cocoapods/v/TLTranstionLib.svg?style=flat)](http://cocoapods.org/pods/TLTranstionLib)
[![License](https://img.shields.io/cocoapods/l/TLTranstionLib.svg?style=flat)](http://cocoapods.org/pods/TLTranstionLib)
[![Platform](https://img.shields.io/cocoapods/p/TLTranstionLib.svg?style=flat)](http://cocoapods.org/pods/TLTranstionLib)

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

##效果图

###System
![system](http://7xsn4e.com2.z0.glb.clouddn.com/System.gif)

###Fade
![fade](http://7xsn4e.com2.z0.glb.clouddn.com/Fade.gif)

###FromLeft
![fromLeft](http://7xsn4e.com2.z0.glb.clouddn.com/Fromleft.gif)

###FlibOver
![flibover](http://7xsn4e.com2.z0.glb.clouddn.com/Flipover.gif)

###CoverFromTop
![coverFromTop](http://7xsn4e.com2.z0.glb.clouddn.com/CoverFromTop.gif)

###Devide
![devide](http://7xsn4e.com2.z0.glb.clouddn.com/devide.gif)

###FromTop
![fromTop](http://7xsn4e.com2.z0.glb.clouddn.com/FromTop.gif)

###CoverFrombottom
![bottom](http://7xsn4e.com2.z0.glb.clouddn.com/CoverFromBottom.gif)

###Cube
![cube](http://7xsn4e.com2.z0.glb.clouddn.com/cube.gif)

###Explode
![explode](http://7xsn4e.com1.z0.glb.clouddn.com/Explode.gif)

###Card
![Card](http://7xsn4e.com1.z0.glb.clouddn.com/Card.gif)

### trun
![trun](http://7xsn4e.com1.z0.glb.clouddn.com/turn.gif)

### Flip
![flip](http://7xsn4e.com1.z0.glb.clouddn.com/Flip.gif)

### Geo
![geo](http://7xsn4e.com1.z0.glb.clouddn.com/Geo.gif)

### Portal
![Portal](http://7xsn4e.com1.z0.glb.clouddn.com/Portal.gif)

### Fold
![Fold](http://7xsn4e.com1.z0.glb.clouddn.com/Fold.gif)



## Installation

TLTranstionLib is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "TLTranstionLib"
```

## How to use

1. 首先引入类库 `#import <TLTranstionLib/UINavigationController+TLTransition.h>`
2. 指定导航控制器的转场风格:

```
//设置转场动画
self.navigationController.animatorStyle=TLAnmimatorStyleTurn;
//设置动画时间，这行代码一定要在下面
self.navigationController.animatorDuration=0.7;
```


转场动画的类型定义:

```
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
```
## Author

Andrew, anluanlu123@163.com

## License

TLTranstionLib is available under the MIT license. See the LICENSE file for more info.
=======
ViewController之间切换动画的类库，动画效果全，API简单
>>>>>>> f04060ba3b4fbb45f82cad56a2ee08b20bb1e3df
