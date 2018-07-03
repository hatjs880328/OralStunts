//
//  IIModuleInvocation.m
//  OralStunts
//
//  Created by Noah_Shan on 2018/6/8.
//  Copyright © 2018年 Inspur. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IIModuleInvocation.h"

@implementation IIModuleInvocation


- (id)invokingMethod:(NSObject *)mateClass selector: (SEL)realSelector params:(NSMutableDictionary *)paramsDic {
    NSMethodSignature *sin = [[mateClass class] instanceMethodSignatureForSelector:realSelector];
    NSInvocation *invok = [NSInvocation invocationWithMethodSignature: sin];
    [invok setTarget:mateClass];
    [invok setSelector:realSelector];
    [invok setArgument:&paramsDic atIndex:2];
    [invok retainArguments];
    [invok invoke];
    
    
    [self methodSignature:invok];
    
    id tempResultSet;
    [invok getReturnValue:&tempResultSet];
    
    return tempResultSet;
}


// NSMethodSignature的使用
- (void)methodSignature:(NSInvocation *)invocation {
    
    // 获取方法签名对象
    NSMethodSignature *signature = invocation.methodSignature;
    
    // 获取方法所占字节数
    NSUInteger frameLength = signature.frameLength;
    NSLog(@"frameLength ---- %ld",frameLength);
    
    // 获取方法返回值所占字节数
    // 这里只对数值型的类型有效，OC类型打印都是8字节
    NSUInteger returnLength = signature.methodReturnLength;
    NSLog(@"returnLength ---- %ld",returnLength);
    
    // 判断方法是否是单向
    NSString *oneWay =  [signature isOneway] ? @"是" : @"不是";
    NSLog(@"方法%@单向", oneWay);
    
    // 获取参数个数
    NSInteger count = signature.numberOfArguments;
    
    // 打印所有参数类型，
    // 这里打印的结果是  @ : i i i  它们是Objective-C类型编码
    // @ 表示 NSObject* 或 id 类型
    // : 表示 SEL 类型
    // i 表示 int 类型
    for (int i = 0; i < (int)count; i++) {
        const char *argTybe = [signature getArgumentTypeAtIndex:i];
        NSLog(@"参数类型 %s",argTybe);
    }
    
    // 获取返回值的类型
    const char *returnType = [signature methodReturnType];
    NSLog(@"返回值的类型 %s",returnType);
    
}

@end
