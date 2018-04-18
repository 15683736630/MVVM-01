//
//  SingCellViewController.m
//  MVVM-01
//
//  Created by 黄宏盛 on 2018/4/15.
//  Copyright © 2018年 黄宏盛. All rights reserved.
//

#import "SingCellViewController.h"
#import "TestModel.h"
#import <MJExtension.h>
@interface SingCellViewController ()<MVVMManagerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)  MVVMManager  *manager;
@end

@implementation SingCellViewController

-(MVVMManager *)manager{
    if (!_manager) {
        _manager = [[MVVMManager alloc]init];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    Teacher *ss =  [Teacher mj_objectWithKeyValues:@{@"name":@"fsdfs",@"content":@"fff"}];
    self.title = @"单层Cell测试";
    self.tableView.dataSource = self.manager;
    self.tableView.delegate   = self.manager;
    self.manager.delegate = self;
    [self.manager setCallBackblock:^(UITableViewCell *cell, MVVMManagerCellEntity *entity, NSIndexPath *indexPath) {
        TestModel  *model = (TestModel*)entity.dataList[indexPath.section];
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.text = model.content;
        
    }];
    self.manager.didClickblock = ^(UITableViewCell *cell, MVVMManagerCellEntity *model, NSIndexPath *indexPath) {
        NSLog(@"点击了cell%@",indexPath);
    };
    // 模仿网络请求获取数据
    [self performSelector:@selector(HH_ConfigurationData) withObject:nil afterDelay:0.2];
}

-(void)HH_ConfigurationData{
    MVVMManagerCellEntity *entity = [[MVVMManagerCellEntity alloc]init];
    NSMutableArray  *mAry = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i < 20; i ++) {
        TestModel  *model = [[TestModel alloc]init];
        model.content = [self randomCreatChinese:arc4random_uniform(200)];
        [mAry addObject:model];
    }
    entity.dataList = mAry.copy;
    [self.manager addMVVMManagerCellEntity:entity registeredCellWithTableView:self.tableView];
}
#pragma mark --  MVVMManagerDelegate

-(void)noticeDataChange{
    [self.tableView reloadData];
}

@end


@implementation Teacher


@end

