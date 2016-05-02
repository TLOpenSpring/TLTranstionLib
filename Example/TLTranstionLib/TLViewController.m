//
//  TLViewController.m
//  TLTranstionLib
//
//  Created by Andrew on 04/29/2016.
//  Copyright (c) 2016 Andrew. All rights reserved.
//

#import "TLViewController.h"
#import <TLTranstionLib/UINavigationController+TLTransition.h>
#import "TLDetailViewController.h"

@interface TLViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)NSArray *arrayData;
@end

@implementation TLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _arrayData=@[@"System",@"fade"];
    [self initialization];
    
    [self.tableView reloadData];
}

-(void)initialization{

    self.navigationController.navigationAnimatorStyle = TLAnmimatorStyleFade;
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
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TLDetailViewController *detailvc=[[TLDetailViewController alloc]init];
    [self.navigationController pushViewController:detailvc animated:YES];
}




@end
