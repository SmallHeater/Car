//
//  ItemListCollectionViewCell.m
//  Car
//
//  Created by xianjun wang on 2019/9/19.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "ItemListCollectionViewCell.h"
#import "UserInforController.h"
#import "CarItemNewModel.h"
#import "CarItemSingleCell.h"
#import "CarItemVideoCell.h"
#import "CarItemThreeCell.h"

static NSString * CarItemSingleCellID = @"CarItemSingleCell";
static NSString * CarItemVideoCellID = @"CarItemVideoCell";
static NSString * CarItemThreeCellID = @"CarItemThreeCell";


@interface ItemListCollectionViewCell ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) SHBaseTableView * tableView;

@property (nonatomic,strong) NSMutableArray<CarItemNewModel *> * dataArray;

@end

@implementation ItemListCollectionViewCell

#pragma mark  ----  懒加载

-(SHBaseTableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[SHBaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

-(NSMutableArray<CarItemNewModel *> *)dataArray{
    
    if (!_dataArray) {
        
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

#pragma mark  ----  生命周期函数

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self drawUI];
    }
    
    return self;
}

#pragma mark  ----  代理

#pragma mark  ----  UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    float cellHeight = 0;
    CarItemNewModel * model = self.dataArray[indexPath.row];
    if ([model.type isEqualToString:@"single"]) {
        
        cellHeight = 130;
    }
    else if ([model.type isEqualToString:@"three"]) {
        
        cellHeight = 222;
    }
    else if ([model.type isEqualToString:@"video"]) {
        
        cellHeight = [CarItemVideoCell cellHeightWithTitle:model.title];
    }
    
    return cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark  ----  UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSUInteger rows = self.dataArray.count;
    return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CarItemNewModel * model = self.dataArray[indexPath.row];
    if ([model.type isEqualToString:@"single"]) {
        
        CarItemSingleCell * cell = [tableView dequeueReusableCellWithIdentifier:CarItemSingleCellID];
        if (!cell) {
            
            cell = [[CarItemSingleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CarItemSingleCellID];
        }
        
        [cell show:model];
        return cell;
    }
    else if ([model.type isEqualToString:@"three"]){
        
        CarItemThreeCell * cell = [tableView dequeueReusableCellWithIdentifier:CarItemThreeCellID];
        if (!cell) {
            
            cell = [[CarItemThreeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CarItemThreeCellID];
        }
        
        [cell show:model];
        return cell;
    }
    else if ([model.type isEqualToString:@"video"]){
        
        CarItemVideoCell * cell = [tableView dequeueReusableCellWithIdentifier:CarItemVideoCellID];
        if (!cell) {
            
            cell = [[CarItemVideoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CarItemVideoCellID];
        }
        
        [cell show:model];
        return cell;
    }
    
    return nil;
}

#pragma mark  ----  自定义函数

-(void)drawUI{
    
    [self addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.top.bottom.offset(0);
    }];
}

//请求数据
-(void)requestWithTabID:(NSString *)tabID{

    //如果已经有数据，则不再请求
    if (self.dataArray.count == 0) {
     
        NSDictionary * bodyParameters = @{@"user_id":[UserInforController sharedManager].userInforModel.userID,@"tab_id":[NSString repleaseNilOrNull:tabID]};
        NSDictionary * configurationDic = @{@"requestUrlStr":GetArticles,@"bodyParameters":bodyParameters};
        __weak typeof(self) weakSelf = self;
        [SHRoutingComponent openURL:REQUESTDATA withParameter:configurationDic callBack:^(NSDictionary *resultDic) {
            
            if (![resultDic.allKeys containsObject:@"error"]) {
                
                //成功的
                NSHTTPURLResponse * response = (NSHTTPURLResponse *)resultDic[@"response"];
                if (response && [response isKindOfClass:[NSHTTPURLResponse class]] && response.statusCode == 200) {
                    
                    id dataId = resultDic[@"dataId"];
                    NSDictionary * dic = (NSDictionary *)dataId;
                    NSDictionary * dataDic = dic[@"data"];
                    NSNumber * code = dic[@"code"];
                    
                    [weakSelf.dataArray removeAllObjects];
                    if (code.integerValue == 1) {
                        
                        //成功
                        if (dataDic && [dataDic isKindOfClass:[NSDictionary class]]) {
                            
                            NSArray * arr = dataDic[@"articles"];
                            if (arr && [arr isKindOfClass:[NSArray class]]) {
                                
                                for (NSDictionary * dic in arr) {
                                    
                                    CarItemNewModel * model = [CarItemNewModel mj_objectWithKeyValues:dic];
                                    [weakSelf.dataArray addObject:model];
                                }
                            }
                        }
                    }
                    else{
                        
                        //异常
                    }
                    [weakSelf.tableView reloadData];
                    //如果内容少，则不滑动
                    if (weakSelf.tableView.contentSize.height < weakSelf.tableView.bounds.size.height) {
                        
                        weakSelf.tableView.scrollEnabled = NO;
                    }
                    else{
                        
                        weakSelf.tableView.scrollEnabled = YES;
                    }
                }
                else{
                }
            }
            else{
                
                //失败的
            }
        }];
    }
}

@end
