//
//  SingCellViewController.h
//  MVVM-01
//
//  Created by 黄宏盛 on 2018/4/15.
//  Copyright © 2018年 黄宏盛. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Teacher;

@interface SingCellViewController : UIViewController

@end


@interface Teacher  :NSObject

@property   (nonatomic,copy)   NSString  *name;
@property   (nonatomic,copy)   NSString  *content;

@end
