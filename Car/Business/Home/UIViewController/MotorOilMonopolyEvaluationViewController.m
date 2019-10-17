//
//  MotorOilMonopolyEvaluationViewController.m
//  Car
//
//  Created by mac on 2019/10/16.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "MotorOilMonopolyEvaluationViewController.h"
#import "UserInforController.h"
#import "MotorOilCommentModel.h"
#import "MotorOilCommentCell.h"

static NSString * cellId = @"MotorOilCommentCell";
@interface MotorOilMonopolyEvaluationViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) SHBaseTableView * tableView;
@property (nonatomic,strong) NSMutableArray<MotorOilCommentModel *> * dataArray;
@property (nonatomic,strong) NSString * shopId;

@end

@implementation MotorOilMonopolyEvaluationViewController

#pragma mark  ----  懒加载

-(SHBaseTableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[SHBaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

-(NSMutableArray<MotorOilCommentModel *> *)dataArray{
    
    if (!_dataArray) {
        
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

#pragma mark  ----  生命周期函数

-(instancetype)initWithShopId:(NSString *)shopId{
    
    self = [super init];
    if (self) {
        
        self.shopId = [NSString repleaseNilOrNull:shopId];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self drawUI];
    [self requestListData];
}

#pragma mark  ----  代理

#pragma mark  ----  UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    float cellHeight = 104;
    return cellHeight;
}

#pragma mark  ----  UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSUInteger rows = self.dataArray.count;
    return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MotorOilCommentCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        
        cell = [[MotorOilCommentCell alloc] initWithReuseIdentifier:cellId];
    }
    
    MotorOilCommentModel * model = self.dataArray[indexPath.row];
    [cell show:model];
    
    return cell;
}

#pragma mark  ----  自定义函数

-(void)drawUI{
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.top.bottom.right.offset(0);
    }];
}

//获取门店数据
-(void)requestListData{
    
    NSDictionary * bodyParameters = @{@"user_id":[UserInforController sharedManager].userInforModel.userID,@"shop_id":self.shopId};
    NSDictionary * configurationDic = @{@"requestUrlStr":GetShopComments,@"bodyParameters":bodyParameters};
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
                
                if (code.integerValue == 1) {
                    
                    //成功
                    if (dataDic && [dataDic isKindOfClass:[NSDictionary class]] && [dataDic.allKeys containsObject:@"comments"]) {
                        
                        NSArray * list = dataDic[@"comments"];
                        if (list && [list isKindOfClass:[NSArray class]]) {

                            for (NSDictionary * dic in list) {

                                MotorOilCommentModel * model = [MotorOilCommentModel mj_objectWithKeyValues:dic];
                                [weakSelf.dataArray addObject:model];
                            }
                        }

                        [weakSelf.tableView reloadData];
                    }
                }
                else{
                    
                    //异常
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

@end
