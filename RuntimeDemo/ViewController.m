//
//  ViewController.m
//  RuntimeDemo
//
//  Created by 彭彭 耿 on 22/11/2016.
//  Copyright © 2016 China M-World Co.,Ltd. All rights reserved.
//

#import "ViewController.h"
#import "UserModel.h"
#import "NSObject+Runtime.h"

@interface ViewController ()

@end

@implementation ViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //字典转模型
    UserModel *user = [UserModel runtime_objWithDic:@{@"userid":@"userid3456786556789",@"name": @"张三", @"age": @23, @"userImgUrl": @"http://img", @"myOrder": @[@{@"orderid":@"id0956772dhdhhd7222"}]}];
    NSLog(@"%@",user);

    
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)dealloc{
    NSLog(@"%s----------dealloc",__func__);
}





@end
