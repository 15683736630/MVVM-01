//
//  OneCell.h
//  MVVM-01
//
//  Created by 黄宏盛 on 2018/4/11.
//  Copyright © 2018年 黄宏盛. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MVVMManager.h"

@interface OneCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;

@property (nonatomic,assign)  id<MVVMManagerDelegate>  delegate;

@end
