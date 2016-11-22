//
//  NSObject+Runtime.m
//  RuntimeDemo
//
//  Created by 彭彭 耿 on 22/11/2016.
//  Copyright © 2016 China M-World Co.,Ltd. All rights reserved.
//

#import "NSObject+Runtime.h"

@implementation NSObject (Runtime)
+ (instancetype)runtime_objWithDic:(NSDictionary *)dic {
    //实例化对象
    id object = [[self alloc] init];
    //使用字典使用对象信息
    //获取self 是属性列表
    NSArray *proArr = [self runtime_objPropertyArr];
    //遍历字典的方法
    [dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSLog(@"key %@, value %@",key,obj);
        //判断key 是否在proArr中
        if ([proArr containsObject:key]) {
            //属性存在KVC 赋值
            [object setValue:obj forKey:key];
        }
    }];
    return object;
}

const char *KPropertyListKey = "YWPropertyListKey";
+ (NSArray *)runtime_objPropertyArr {
    
    //从关联对象 中获取对象属性，如果有，直接返回
    /**
     参数：
     1 对象 self
     2 动态属性的key
     返回值 id 动态添加的 属性值
     */
    NSArray *ptyList = objc_getAssociatedObject(self, KPropertyListKey);
    if (ptyList) {
        return ptyList;
    }
    
    //调用运行时的方法，取得类的属性列表
    // Ivar 成员变量
    // Method 方法
    // Property 属性
    // Protocol 协议
    
    /**
     获取属性列表
     1.要获取的类
     2.类属性的个数指针
     返回值：所有的属性数组 C语言中，数组的名字，就是指向第一个元素的地址
     在OC 中使用C的时候晕倒 retain/create/copy 等 需要release
     */
    unsigned int count = 0;
    //C语言数组 需要 * 符号
    objc_property_t *proArr = class_copyPropertyList([self class], &count);
    NSLog(@"属性的数量%d",count);
    //创建数组
    NSMutableArray *MArr = [NSMutableArray array];
    //遍历所有的属性
    for (unsigned int i = 0; i < count; i++) {
        //从数组中取得属性
        // C语言结构体指针，不要 *
        objc_property_t pty = proArr[i];
        //从pty 中获取属性的名称
        const char *cName = property_getName(pty);
        NSString *name = [NSString stringWithCString:cName encoding:NSUTF8StringEncoding];
        //添加到数组
        [MArr addObject:name];
    }
    //释放数组
    free(proArr);
    
    //到此为止，对象的属性数组获取完毕，利用灌篮对象，动态的添加属性
    /**
     1.对象 self
     2.动态添加属性的key，获取值的时候使用
     3.动态添加属性值
     4.对象的引用关系
     */
    objc_setAssociatedObject(self, KPropertyListKey, MArr.copy, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    return MArr.copy;
}

///归档
- (void)encode:(NSCoder *)aCoder{
    unsigned int outCount = 0;
    Ivar *ivars = class_copyIvarList([self class], &outCount);
    for (unsigned int i = 0; i < outCount; i++)
    {
        Ivar ivar = ivars[i];
        NSString *key = [NSString stringWithUTF8String:ivar_getName(ivar)];
        if ([self.ignoredIvarNames containsObject:key])
        {
            continue;
        }
        id value = [self valueForKey:key];
        [aCoder encodeObject:value forKey:key];
    }
    free(ivars);
}
///解档
- (void)decode:(NSCoder *)aDecoder{
    unsigned int outCount = 0;
    Ivar *ivars = class_copyIvarList([self class], &outCount);
    for (unsigned int i = 0; i < outCount; i++)
    {
        Ivar ivar = ivars[i];
        NSString *key = [NSString stringWithUTF8String:ivar_getName(ivar)];
        if ([self.ignoredIvarNames containsObject:key])
        {
            continue;
        }
        id value = [aDecoder decodeObjectForKey:key];
        [self setValue:value forKey:key];
    }
    free(ivars);
}
///忽略数组
- (void)setIgnoredIvarNames:(NSArray *)ignoredIvarNames{
    objc_setAssociatedObject(self,
                             @selector(ignoredIvarNames),
                             ignoredIvarNames,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSArray *)ignoredIvarNames{
    return objc_getAssociatedObject(self, _cmd);
}

@end
