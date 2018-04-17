//
//  MVVMBaseSectionModel.m
//  TYWithHHSProject
//
//  Created by 黄宏盛 on 2018/4/12.
//  Copyright © 2018年 黄宏盛. All rights reserved.
//

#import "MVVMBaseSectionModel.h"
#import "objc/runtime.h"

@implementation MVVMBaseSectionModel


+(BOOL)resolveInstanceMethod:(SEL)sel{
    //动态解析 实例方法
    void(^resolveInstanceBlock)(id, SEL) = ^(id objc_self,SEL objc_cmd){
        NSLog(@"如果实例方法未实现则会执行此方法");
    };
    //为本类添加实例方法
    class_addMethod([self class], sel, imp_implementationWithBlock(resolveInstanceBlock), "v@:");
    printf("%s\n",sel_getName(sel));
    return YES;
    
}
+(BOOL)resolveClassMethod:(SEL)sel{
    //动态解析 类方法
    void(^resoveClassMethod)(id,SEL) = ^(id objc_self,SEL objc_cmd){
        NSLog(@"未实现的类方法，在这里执行");
    };
    //为本类添加类方法
    class_addMethod(object_getClass([self class]), sel, imp_implementationWithBlock(resoveClassMethod), "v@:");
    return YES;
}


@end
