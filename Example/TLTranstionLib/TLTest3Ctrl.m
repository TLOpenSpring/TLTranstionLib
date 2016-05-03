//
//  TLTest3Ctrl.m
//  TLTranstionLib
//
//  Created by Andrew on 16/5/3.
//  Copyright © 2016年 Andrew. All rights reserved.
//

#import "TLTest3Ctrl.h"
#import "TLTest4Ctrl.h"

@implementation TLTest3Ctrl
-(void)viewDidLoad{
    [super viewDidLoad];
    self.title=@"Three";
    
    self.bgIv.image=[UIImage imageNamed:@"3"];
}

-(UIViewController *)getCurrentVC{
    return [[TLTest4Ctrl alloc]init];
}
@end
