//
//  TLTest4Ctrl.m
//  TLTranstionLib
//
//  Created by Andrew on 16/5/3.
//  Copyright © 2016年 Andrew. All rights reserved.
//

#import "TLTest4Ctrl.h"

@implementation TLTest4Ctrl
-(void)viewDidLoad{
    [super viewDidLoad];
     self.title=@"Four";
    
    [self setRootRightBarItem];
    
    self.bgIv.image=[UIImage imageNamed:@"4"];
    self.view.backgroundColor=[UIColor yellowColor];
}

-(void)viewDidAppear:(BOOL)animated{
}

-(void)setRootRightBarItem{
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"回到首页" style:UIBarButtonItemStylePlain target:self action:@selector(goRoot:)];
}
-(void)goRoot:(id)sender{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
