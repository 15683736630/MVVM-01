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

    void(^resolveInstanceBlock)(id, SEL) = ^(id objc_self,SEL objc_cmd){
        NSLog(@"如果实例方法未实现则会执行此方法");
    };
    class_addMethod([self class], sel, imp_implementationWithBlock(resolveInstanceBlock), "v@:");
    printf("%s\n",sel_getName(sel));
    return YES;
    
}
+(BOOL)resolveClassMethod:(SEL)sel{
    void(^resoveClassMethod)(id,SEL) = ^(id objc_self,SEL objc_cmd){
        NSLog(@"未实现的类方法，在这里执行");
    };
    class_addMethod(object_getClass([self class]), sel, imp_implementationWithBlock(resoveClassMethod), "v@:");
    printf("%s\n",sel_getName(sel));
    return YES;
}


@end
