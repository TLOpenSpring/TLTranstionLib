//
//  TLTest2Ctrl.m
//  TLTranstionLib
//
//  Created by Andrew on 16/5/3.
//  Copyright © 2016年 Andrew. All rights reserved.
//

#import "TLTest2Ctrl.h"
#import "TLTest3Ctrl.h"

@implementation TLTest2Ctrl
-(void)viewDidLoad{
    [super viewDidLoad];
    self.title=@"Second";
    
    self.bgIv.image=[UIImage imageNamed:@"2"];
    self.view.backgroundColor=[UIColor grayColor];

}

-(UIViewController *)getCurrentVC{
    return [[TLTest3Ctrl alloc]init];
}
@end
