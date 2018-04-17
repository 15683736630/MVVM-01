//
//  NSObject+random.h
//  MVVM-01
//
//  Created by 黄宏盛 on 2018/4/15.
//  Copyright © 2018年 黄宏盛. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (random)

- (NSMutableString*)randomCreatChinese:(NSInteger)count;
+ (instancetype)HH_ObjectlWithDictionary:(NSDictionary *)dict;
+ (NSMutableArray*)HH_objectArrayWithKeyValuesArray:(NSArray<NSDictionary*>*)arr;
@end
