//
//  MVVMDataController.m
//  MVVM-01
//
//  Created by 黄宏盛 on 2018/4/16.
//  Copyright © 2018年 黄宏盛. All rights reserved.
//

#import "MVVMDataController.h"
#import "TestModel.h"
#import "HeaderView.h"


@implementation MVVMDataController

+(void)requetNetWorkCallBlock:(void (^)(NSArray *))callBlock{
    NSMutableArray *entitys = [NSMutableArray arrayWithCapacity:0];
    MVVMManagerCellEntity *entity1 = [[MVVMManagerCellEntity alloc]init];
    entity1.Identifier = @"OneCell";
    NSDictionary  *dic = @{@"name":@(111),@"content":@"大家都拉开始就暗示健康大了空间大撒来得及阿来得及阿斯兰的骄傲手榴弹"};
    TestModel  *ts = [TestModel HH_ObjectlWithDictionary:dic];
    ts.cellHeight = 140;
   // ts.content = @"大家都拉开始就暗示健康大了空间大撒来得及阿来得及阿斯兰的骄傲手榴弹";
    entity1.dataList = @[ts];
    [entitys addObject:entity1];
    
    [entitys addObject:[MVVMManagerCellEntity newInstantiationEmtityWithIdentifier:@"TwoCell" DataList:@[ts]]];
    [entitys addObject:[MVVMManagerCellEntity newInstantiationEmtityWithIdentifier:@"ThreeCell" DataList:@[ts]]];
    MVVMManagerCellEntity *entity = [[MVVMManagerCellEntity alloc]init];
    NSMutableArray  *mAry = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i < 10; i ++) {
        TestModel  *model = [[TestModel alloc]init];
        model.content = [self randomCreatChinese:arc4random_uniform(200)];
        [mAry addObject:model];
    }
    entity.dataList = mAry.copy;
    [entitys addObject:entity];
    [entitys enumerateObjectsUsingBlock:^(MVVMManagerCellEntity *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.headerView = [[HeaderView alloc]init];
        obj.headerView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,45);
        obj.cellHeaderHeight = 45;
        obj.cellFooterHeight = 10;
        ((HeaderView*)obj.headerView).titleLabel.text = [NSString stringWithFormat:@"第%ld行Section",idx];
    }];
    
    if (callBlock) {
        callBlock(entitys.copy);
    }
}



@end
