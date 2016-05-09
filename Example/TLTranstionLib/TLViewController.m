//
//  TLViewController.m
//  TLTranstionLib
//
//  Created by Andrew on 04/29/2016.
//  Copyright (c) 2016 Andrew. All rights reserved.
//

#import "TLViewController.h"
#import <TLTranstionLib/UINavigationController+TLTransition.h>
#import "TLTest1Ctrl.h"

@interface TLViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)NSArray *arrayData;
@end

@implementation TLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.title=@"转场动画集合";
    
    _arrayData=@[@"System",@"Fade",@"Devide",@"FromTop",@"FromLeft",
                 @"FlipOver",@"CoverFromTop",@"CoverFromBottom",@"cube",
                 @"Portal",@"Card",@"Fold",@"Explode"];
    [self initialization];
    
    [self.tableView reloadData];
}

-(void)initialization{

  
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _arrayData.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   static NSString *cellId=@"cellId";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
    if(!cell){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    cell.textLabel.text=[_arrayData objectAtIndex:indexPath.row];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *style=[_arrayData objectAtIndex:indexPath.row];
   
    
    if([style isEqualToString:@"System"]){
        self.navigationController.animatorStyle=TLAnmimatorStyleSystem;
      
    }else if([style isEqualToString:@"Fade"]){
        self.navigationController.animatorStyle=TLAnmimatorStyleFade;
    }else if([style isEqualToString:@"Devide"]){
        self.navigationController.animatorStyle=TLAnmimatorStyleDivide;
    }else if([style isEqualToString:@"FromTop"]){
        self.navigationController.animatorStyle=TLAnmimatorStyleFromTop;
    }else if([style isEqualToString:@"FromLeft"]){
        self.navigationController.animatorStyle = TLAnmimatorStyleFromLeft;
    }else if([style isEqualToString:@"FlipOver"]){
        self.navigationController.animatorStyle=TLAnmimatorStyleFlipOver;
    }else if([style isEqualToString:@"CoverFromTop"]){
        self.navigationController.animatorStyle=TLAnmimatorStyleCoverVerticalFromTop;
    }else if([style isEqualToString:@"CoverFromBottom"]){
        self.navigationController.animatorStyle=TLAnmimatorStyleCoverVerticalFromBottom;
    }else if([style isEqualToString:@"cube"]){
        self.navigationController.animatorStyle=TLAnmimatorStyleCube;
    }else if([style isEqualToString:@"Portal"]){
        self.navigationController.animatorStyle=TLAnmimatorStylePortal;
    }else if([style isEqualToString:@"Card"]){
        self.navigationController.animatorStyle=TLAnmimatorStyleCard;
    }else if([style isEqualToString:@"Fold"]){
        self.navigationController.animatorStyle=TLAnmimatorStyleFold;
    }else if([style isEqualToString:@"Explode"]){
        self.navigationController.animatorStyle=TLAnmimatorStyleExplode;
        self.navigationController.animatorDuration=1;
    }
    
    
    TLTest1Ctrl *detailvc=[[TLTest1Ctrl alloc]init];
    [self.navigationController pushViewController:detailvc animated:YES];
}




@end
