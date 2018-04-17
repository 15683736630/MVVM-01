//
//  MVVMDataController.h
//  MVVM-01
//
//  Created by 黄宏盛 on 2018/4/16.
//  Copyright © 2018年 黄宏盛. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MVVMDataController : NSObject

+ (void)requetNetWorkCallBlock:(void(^)(NSArray *datas))callBlock;

@end
