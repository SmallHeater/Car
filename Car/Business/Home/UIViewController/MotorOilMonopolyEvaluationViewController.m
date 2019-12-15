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

- (void)setOffsetY:(CGFloat)offsetY{
    
    self.tableView.contentOffset = CGPointMake(0, offsetY);
}

- (CGFloat)offsetY{
    
    return self.tableView.contentOffset.y;
}

- (void)setIsCanScroll:(BOOL)isCanScroll{
    
    if (isCanScroll == YES){
        
        [self.tableView setContentOffset:CGPointMake(0, self.offsetY) animated:NO];
    }
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

#pragma mark  ----  UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    if ([self.scrollDelegate respondsToSelector:@selector(hoverChildViewController:scrollViewDidScroll:)]){
        [self.scrollDelegate hoverChildViewController:self scrollViewDidScroll:scrollView];
    }
}

#pragma mark  ----  UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MotorOilCommentModel * model = self.dataArray[indexPath.row];
    float cellHeight = [MotorOilCommentCell cellHeightWithModel:model];
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
        
        make.left.top.offset(0);
        make.width.offset(MAINWIDTH);
        make.bottom.offset(-10);
    }];
    self.scrollView = self.tableView;
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
                            
                            if (weakSelf.callBack) {
                                
                                weakSelf.callBack(weakSelf.dataArray.count);
                            }
                        }
                    }
                }
                else{
                    
                    //异常
                }
                [weakSelf.tableView reloadData];
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
