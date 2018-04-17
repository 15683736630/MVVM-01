//
//  OneCell.m
//  MVVM-01
//
//  Created by 黄宏盛 on 2018/4/11.
//  Copyright © 2018年 黄宏盛. All rights reserved.
//

#import "OneCell.h"

@implementation OneCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)refreshData:(id)sender {
    if ([self.delegate respondsToSelector:@selector(randomChangeData)]) {
        [self.delegate randomChangeData];
    }
}


@end
