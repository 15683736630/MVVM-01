//
//  HeaderView.m
//  MVVM-01
//
//  Created by 黄宏盛 on 2018/4/16.
//  Copyright © 2018年 黄宏盛. All rights reserved.
//

#import "HeaderView.h"

@implementation HeaderView

- (instancetype)init
{
    self = [super init];
    if (self) {
         self = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self.class) owner:nil options:nil]firstObject];
    }
    return self;
}

@end
