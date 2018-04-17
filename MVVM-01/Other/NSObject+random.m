//
//  NSObject+random.m
//  MVVM-01
//
//  Created by 黄宏盛 on 2018/4/15.
//  Copyright © 2018年 黄宏盛. All rights reserved.
//

#import "NSObject+random.h"
#import <objc/runtime.h>

@implementation NSObject (random)


- (NSMutableString*)randomCreatChinese:(NSInteger)count{
    
    NSMutableString*randomChineseString =@"".mutableCopy;
    
    for(NSInteger i =0; i < count; i++){
        
        NSStringEncoding gbkEncoding =CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
        
        //随机生成汉字高位
        
        NSInteger randomH =0xA1+arc4random()%((0xFE)-0xA1+1);
        
        //随机生成汉子低位
        
        NSInteger randomL =0xB0+arc4random()%(0xF7-0xB0+1);
        
        //组合生成随机汉字
        
        NSInteger number = (randomH<<8)+randomL;
        
        NSData*data = [NSData dataWithBytes:&number length:2];
        
        NSString*string = [[NSString alloc]initWithData:data encoding:gbkEncoding];
        
        [randomChineseString appendString:string];
        
    }
    
    return randomChineseString;
    
}


- (NSArray *)getAllProperties
{
    u_int count;
    
    objc_property_t *properties  =class_copyPropertyList([self class], &count);
    
    NSMutableArray *propertiesArray = [NSMutableArray arrayWithCapacity:count];
    
    for (int i = 0; i < count ; i++)
    {
        const char* propertyName =property_getName(properties[i]);
        [propertiesArray addObject: [NSString stringWithUTF8String: propertyName]];
    }
    
    free(properties);
    
    return propertiesArray;
}


+(NSMutableArray*)HH_objectArrayWithKeyValuesArray:(NSArray<NSDictionary*>*)arr{
    NSMutableArray  *mAry = [NSMutableArray arrayWithCapacity:0];
    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [mAry addObject:[NSObject HH_ObjectlWithDictionary:obj]];
    }];
    return mAry;
}

+(instancetype)HH_ObjectlWithDictionary:(NSDictionary *)dict{
    Class  class = [self class];
    NSObject  *obj = [[class alloc]init];
    [[obj getAllProperties] enumerateObjectsUsingBlock:^(NSString*  _Nonnull key, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([dict.allKeys containsObject:key]) {
            if ([dict objectForKey:key]) {
                [obj setValue:[NSString stringWithFormat:@"%@",dict[key]] forKey:key];
            }else{
                   [obj setValue:@"" forKey:key];
            }
        }
    }];
    return obj;
}


@end
