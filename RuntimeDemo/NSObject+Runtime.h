//
//  NSObject+Runtime.h
//  RuntimeDemo
//
//  Created by 彭彭 耿 on 22/11/2016.
//  Copyright © 2016 China M-World Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface NSObject (Runtime)

/**
 给定一个字典，创建self类 对用的对象
 
 @param dic 字典
 
 @return 对象
 */
+ (instancetype) runtime_objWithDic:(NSDictionary *)dic;

/**
 获取类的属性列表数组
 
 @return 类的属性列表数组
 */
+ (NSArray *) runtime_objPropertyArr;

/**
 *  归档
 */
- (void)encode:(NSCoder *)aCoder;

/**
 *  解档
 */
- (void)decode:(NSCoder *)aDecoder;

/**
 *  这个数组中的成员变量名将会被忽略：不进行归档
 */
@property (nonatomic, strong) NSArray *ignoredIvarNames;


@end
