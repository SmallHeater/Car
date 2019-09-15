//
//  PublicRequest.m
//  Car
//
//  Created by mac on 2019/9/12.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "PublicRequest.h"
#import "UserInforController.h"
#import "VehicleFileModel.h"

@implementation PublicRequest

#pragma mark  ----  生命周期函数

+(PublicRequest *)sharedManager{
    
    static PublicRequest * request = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        request = [[PublicRequest alloc] init];
    });
    
    return request;
}


#pragma mark  ----  自定义函数

//请求接口，判断车牌档案是否已存在
-(void)requestIsExistedLicenseNumber:(NSString *)license_number callBack:(void(^)(BOOL isExisted,VehicleFileModel * model,NSString * msg))callBack{
    
    NSDictionary * bodyParameters = @{@"license_number":license_number,@"user_id":[UserInforController sharedManager].userInforModel.userID};
    NSDictionary * configurationDic = @{@"requestUrlStr":Checkcar,@"bodyParameters":bodyParameters};
    
    [SHRoutingComponent openURL:REQUESTDATA withParameter:configurationDic callBack:^(NSDictionary *resultDic) {
        
        if (![resultDic.allKeys containsObject:@"error"]) {
            
            //成功的
            NSHTTPURLResponse * response = (NSHTTPURLResponse *)resultDic[@"response"];
            if (response && [response isKindOfClass:[NSHTTPURLResponse class]] && response.statusCode == 200) {
                
                id dataId = resultDic[@"dataId"];
                NSDictionary * dic = (NSDictionary *)dataId;
                NSNumber * code = dic[@"code"];
                
                if (code.integerValue == 1) {
                    
                    NSDictionary * dataDic = dic[@"data"];
                    NSArray * carArray = dataDic[@"car"];
                    NSDictionary * modelDic = carArray[0];
                    VehicleFileModel * model = [VehicleFileModel mj_objectWithKeyValues:modelDic];
                    //成功
                    callBack(YES,model,@"");
                }
                else{
                    
                    callBack(NO,nil,dic[@"msg"]);
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
