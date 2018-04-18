//
//  MVVMViewController.m
//  MVVM-01
//
//  Created by 黄宏盛 on 2018/4/11.
//  Copyright © 2018年 黄宏盛. All rights reserved.
//

#import "MVVMViewController.h"
#import "MVVMManager.h"
#import "OneCell.h"
#import "TwoCell.h"
#import "ThreeCell.h"
#import "TestModel.h"
#import "MVVMDataController.h"

@interface MVVMViewController ()<MVVMManagerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property  (nonatomic,strong)  MVVMManager  *manager;
@property  (nonatomic,copy)    NSArray <MVVMManagerCellEntity*>     *dataList;
@end

@implementation MVVMViewController

-(MVVMManager *)manager{
    if (!_manager) {
        _manager = [[MVVMManager alloc]init];
    }
    return _manager;
}
-(void)dealloc{
    NSLog(@"%@释放了",NSStringFromClass([self class]));
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"MVVM测试";
    self.tableView.dataSource = self.manager;
    self.tableView.delegate   = self.manager;
    self.tableView.estimatedRowHeight = UITableViewAutomaticDimension;
    self.tableView.rowHeight = 100;
    self.manager.delegate = self;
    [self HH_ConfigurationData];
    __weak __typeof__(self) weakSelf = self;
    [self.manager setCallBackblock:^(UITableViewCell *cell, MVVMManagerCellEntity *entity, NSIndexPath *indexPath) {
        TestModel  *model = (TestModel*)entity.dataList[indexPath.row];
        if ([entity.Identifier isEqualToString:NSStringFromClass([OneCell class])]) {
            ((OneCell*)cell).nameLabel.text = model.name;
            ((OneCell*)cell).contentLabel.text = model.content;
            ((OneCell*)cell).delegate = weakSelf;
        }else if ([entity.Identifier isEqualToString:NSStringFromClass([UITableViewCell class])]){
              cell.textLabel.text = model.content;
              cell.textLabel.numberOfLines = 0;
        }
        
    }];
    self.manager.didClickblock = ^(UITableViewCell *cell, MVVMManagerCellEntity *model, NSIndexPath *indexPath) {
        NSLog(@"点击了cell%@",indexPath);
    };
}
- (void)HH_ConfigurationData{
    [MVVMDataController requetNetWorkCallBlock:^(NSArray *datas) {
        [self.manager addDatas:datas registeredCellWithTableView:self.tableView];
    }];
}
- (IBAction)refreshData:(id)sender {
    [self HH_ConfigurationData];
}

#pragma mark --  MVVMManagerDelegate

-(void)noticeDataChange{
    [self.tableView reloadData];
}
-(void)randomChangeData{
    [self HH_ConfigurationData];
}

@end
