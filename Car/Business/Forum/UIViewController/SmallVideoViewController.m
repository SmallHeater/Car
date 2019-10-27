//
//  SmallVideoViewController.m
//  Car
//
//  Created by mac on 2019/10/27.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "SmallVideoViewController.h"
#import "UserInforController.h"
#import "VideoModel.h"
#import "SHBaseCollectionView.h"
#import "VideoCollectionViewCell.h"

@interface SmallVideoViewController ()

@property (nonatomic,strong) NSMutableArray<VideoModel *> * dataArray;

@end

@implementation SmallVideoViewController

#pragma mark  ----  懒加载

-(NSMutableArray<VideoModel *> *)dataArray{
    
    if (!_dataArray) {
        
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

#pragma mark  ----  生命周期函数

- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestData];
}


#pragma mark  ----  自定义函数

-(void)requestData{
    
    //position_id:首页：3，论坛页：2
    NSDictionary * bodyParameters = @{@"user_id":[UserInforController sharedManager].userInforModel.userID,@"position_id":@"2"};
    NSDictionary * configurationDic = @{@"requestUrlStr":GetVideos,@"bodyParameters":bodyParameters};
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
                    if (dataDic && [dataDic isKindOfClass:[NSDictionary class]]) {
                        
                        if ([dataDic.allKeys containsObject:@"videos"]) {
                         
                            NSArray * array = dataDic[@"videos"];
                            if (array && [array isKindOfClass:[NSArray class]]) {
                                
                                for (NSDictionary * dic in array) {
                                    
                                    VideoModel * model = [VideoModel mj_objectWithKeyValues:dic];
                                    [weakSelf.dataArray addObject:model];
                                }
                            }
                        }
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
