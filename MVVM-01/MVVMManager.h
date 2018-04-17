//
//  MVVMManager.h
//  MVVM-01
//
//  Created by 黄宏盛 on 2018/4/8.
//  Copyright © 2018年 黄宏盛. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@class MVVMManagerCellEntity;

@protocol  MVVMManagerDelegate <NSObject>

@optional
// 数据源发生变化通知
- (void)noticeDataChange;
// 随机更改数据源
- (void)randomChangeData;
@end

@interface MVVMManager : NSObject<UITableViewDataSource,UITableViewDelegate>

@property  (nonatomic,copy) void (^CallBackblock)(UITableViewCell *cell , MVVMManagerCellEntity *entity ,NSIndexPath *indexPath);
@property  (nonatomic,copy) void (^didClickblock)(UITableViewCell *cell , MVVMManagerCellEntity *model ,NSIndexPath *indexPath);
@property (nonatomic,assign)  id<MVVMManagerDelegate>  delegate;

- (void)addDatas:(NSArray<MVVMManagerCellEntity*>*)datas registeredCellWithTableView:(UITableView *)tableView;
- (void)addMVVMManagerCellEntity:(MVVMManagerCellEntity*)entity registeredCellWithTableView:(UITableView *)tableView;
@end

@interface MVVMManagerCellEntity :NSObject

@property (nonatomic,copy)     NSArray   <MVVMBaseSectionModel*>*dataList;
@property (nonatomic,copy)     NSString  *Identifier;
@property  (nonatomic,assign)  CGFloat   cellHeaderHeight;
@property  (nonatomic,assign)  CGFloat   cellFooterHeight;
@property  (nonatomic,strong)  UIView    *headerView;
@property  (nonatomic,strong)  UIView    *footerView;

+(instancetype)newInstantiationEmtityWithIdentifier:(NSString *)cellIdentifier DataList:(NSArray<MVVMBaseSectionModel *> *)data_List;

@end

