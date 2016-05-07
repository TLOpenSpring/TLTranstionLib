//
//  TLTest1Ctrl.m
//  TLTranstionLib
//
//  Created by Andrew on 16/5/3.
//  Copyright © 2016年 Andrew. All rights reserved.
//

#import "TLTest1Ctrl.h"
#import "TLTest2Ctrl.h"

@implementation TLTest1Ctrl
-(void)viewDidLoad{
    [super viewDidLoad];
    self.title=@"First";
    
    self.bgIv.image=[UIImage imageNamed:@"1"];
    self.view.backgroundColor=[UIColor redColor];
}

-(UIViewController *)getCurrentVC{
    return [[TLTest2Ctrl alloc]init];
}
@end
