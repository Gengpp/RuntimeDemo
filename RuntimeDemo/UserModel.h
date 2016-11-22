//
//  UserModel.h
//  RuntimeDemo
//
//  Created by 彭彭 耿 on 22/11/2016.
//  Copyright © 2016 China M-World Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject

@property (nonatomic,copy) NSString *userid;
@property (nonatomic,assign) NSUInteger age;
@property (nonatomic,copy) NSString *userImgUrl;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,strong) NSArray *myOrder;



@end
