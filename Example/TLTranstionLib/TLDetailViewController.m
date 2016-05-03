//
//  TLDetailViewController.m
//  TLTranstionLib
//
//  Created by Andrew on 16/5/2.
//  Copyright © 2016年 Andrew. All rights reserved.
//

#import "TLDetailViewController.h"

@implementation TLDetailViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    self.title=@"TLDetailViewController";
    self.view.backgroundColor=[UIColor whiteColor];
    
    UIImage *img=[UIImage imageNamed:@"1"];
    
    self.bgIv=[[UIImageView alloc]initWithFrame:self.view.bounds];
    self.bgIv.image=img;
    self.bgIv.contentMode=UIViewContentModeScaleAspectFit;
    [self.view addSubview:self.bgIv];
    
    
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"下一步" style:UIBarButtonItemStylePlain target:self action:@selector(nextStep:)];
}



-(void)nextStep:(id)sender{
    UIViewController *vc=[self getCurrentVC];
    [self.navigationController pushViewController:vc animated:YES];
}

-(UIViewController *)getCurrentVC{
    return [[UIViewController alloc]init];
}



@end
