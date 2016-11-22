//
//  UserModel.m
//  RuntimeDemo
//
//  Created by 彭彭 耿 on 22/11/2016.
//  Copyright © 2016 China M-World Co.,Ltd. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel
- (NSString *)description {
    NSArray *keys = @[@"userid",@"age",@"userImgUrl", @"name",@"myOrder"];
    return [NSString stringWithFormat:@"\nClass：%@\n%@",NSStringFromClass([self class]),[self dictionaryWithValuesForKeys:keys].description];
}
@end
