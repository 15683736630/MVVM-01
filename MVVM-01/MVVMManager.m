//
//  MVVMManager.m
//  MVVM-01
//
//  Created by 黄宏盛 on 2018/4/8.
//  Copyright © 2018年 黄宏盛. All rights reserved.
//

#import "MVVMManager.h"

@interface MVVMManager ()

@property  (nonatomic,copy)  NSArray     *datas;
@property  (nonatomic,assign)   BOOL   isManyCellStyle; //是否是多种样式的Cell
@property  (nonatomic,strong)   MVVMManagerCellEntity   *singleEntity; //单种样式的时候用到

@end

@implementation MVVMManager



- (instancetype)init
{
    self = [super init];
    if (self) {
        [RACObserve(self, datas) subscribeNext:^(id  _Nullable x) {
            if ([self.delegate respondsToSelector:@selector(noticeDataChange)]) {
                [self.delegate noticeDataChange];//数据源改变通知刷新TableView
            }
        }];
    }
    return self;
}

// 多层级
- (void)addDatas:(NSArray<MVVMManagerCellEntity*>*)datas registeredCellWithTableView:(UITableView *)tableView{
    // 只注册一遍
    if (self.datas.count == 0) {
        for (MVVMManagerCellEntity *entity in datas) {
            if ([entity.Identifier isEqualToString:@"UITableViewCell"]) {
                [tableView registerClass:NSClassFromString(entity.Identifier) forCellReuseIdentifier:entity.Identifier];
            }else{
                
                [tableView registerNib:[UINib nibWithNibName:entity.Identifier bundle:nil] forCellReuseIdentifier:entity.Identifier];
            }
            
        }
    }
    
    self.datas = datas;
    self.isManyCellStyle = YES;
}
// 一层层级
-(void)addMVVMManagerCellEntity:(MVVMManagerCellEntity *)entity registeredCellWithTableView:(UITableView *)tableView{
    // 只注册一遍
    if (self.datas.count == 0) {
        if ([entity.Identifier isEqualToString:@"UITableViewCell"]) {
            [tableView registerClass:NSClassFromString(entity.Identifier) forCellReuseIdentifier:entity.Identifier];
        }else{
            
            [tableView registerNib:[UINib nibWithNibName:entity.Identifier bundle:nil] forCellReuseIdentifier:entity.Identifier];
        }
    }
    self.isManyCellStyle = NO;
    self.datas = entity.dataList;
    self.singleEntity = entity;
}
#pragma mark -- UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return  self.datas.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return  self.isManyCellStyle ? ((MVVMManagerCellEntity*)self.datas[section]).dataList.count:1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MVVMManagerCellEntity *entity;
    if (self.isManyCellStyle) {
        entity   = self.datas[indexPath.section];
    }else{
        entity   = self.singleEntity ?:self.datas.firstObject;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:entity.Identifier forIndexPath:indexPath];
    if (self.CallBackblock) {
        self.CallBackblock(cell, entity, indexPath);
    }
    return cell;
}

#pragma mark -- UITableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.isManyCellStyle) {
        MVVMManagerCellEntity *entity = self.datas[indexPath.section];
        if ([entity.Identifier isEqualToString:NSStringFromClass([UITableViewCell class])]) {
            return UITableViewAutomaticDimension;
        }
        return ((MVVMBaseSectionModel*)entity.dataList[indexPath.row]).cellHeight ?:UITableViewAutomaticDimension;
    }
    MVVMBaseSectionModel  *sectionModel = self.datas[indexPath.section];
    return sectionModel.cellHeight ?:UITableViewAutomaticDimension;
}


-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    cell.selectionStyle = 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    MVVMManagerCellEntity *entity;
    if (self.isManyCellStyle) {
        entity   = self.datas[section];
    }else{
        entity   = self.singleEntity ?:self.datas.firstObject;
    }
    return entity.footerView?:nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    MVVMManagerCellEntity *entity;
    if (self.isManyCellStyle) {
        entity   = self.datas[section];
    }else{
        entity   = self.singleEntity ?:self.datas.firstObject;
    }
    return entity.cellFooterHeight ?:0.01;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    MVVMManagerCellEntity *entity;
    if (self.isManyCellStyle) {
        entity   = self.datas[section];
    }else{
        entity   = self.singleEntity ?:self.datas.firstObject;
    }
    return entity.headerView?:nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    MVVMManagerCellEntity *entity;
    if (self.isManyCellStyle) {
        entity   = self.datas[section];
    }else{
        entity   = self.singleEntity ?:self.datas.firstObject;
    }
    return entity.cellHeaderHeight ?:0.01;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MVVMManagerCellEntity *entity;
    if (self.isManyCellStyle) {
        entity   = self.datas[indexPath.section];
    }else{
        entity   = self.singleEntity ?:self.datas.firstObject;
    }
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (self.didClickblock) {
        self.didClickblock(cell, entity, indexPath);
    }
}

@end



@implementation MVVMManagerCellEntity

+(instancetype)newInstantiationEmtityWithIdentifier:(NSString *)cellIdentifier DataList:(NSArray<MVVMBaseSectionModel *> *)data_List{
    MVVMManagerCellEntity  *entity = [MVVMManagerCellEntity new];
    entity.Identifier = cellIdentifier;
    entity.dataList = data_List;
    return entity;
}

-(NSString *)Identifier{
    if (!_Identifier) {
        return NSStringFromClass([UITableViewCell class]);
    }
    return _Identifier;
}


@end

