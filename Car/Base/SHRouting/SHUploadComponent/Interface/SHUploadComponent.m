//
//  JHNewUploadComponent.m
//  JHNewUploadComponent
//
//  Created by xianjun wang on 2019/1/15.
//  Copyright © 2019 xianjunwang. All rights reserved.
//

#import "SHUploadComponent.h"
#import "NewUploadController.h"
#import "SHUploadConfigurationModel.h"
#import "SHUploadModel.h"



@implementation SHUploadComponent

#pragma mark  ----  自定义函数
+(SHUploadConfigurationModel *)getConfigurationModelWithDic:(NSDictionary *)initDic{
    
    SHUploadConfigurationModel * configurationModel = [SHUploadConfigurationModel mj_objectWithKeyValues:initDic];
    if (configurationModel) {
        
        if ([NSString strIsEmpty:configurationModel.Identification]) {
            
            NSString * taskIdentifier = [[NSUUID UUID] UUIDString];
            configurationModel.Identification = taskIdentifier;
        }
        
        if (!configurationModel.timeoutNumber || configurationModel.timeoutNumber.integerValue == 0) {
            
            configurationModel.timeoutNumber = [NSNumber numberWithInteger:300];
        }
        
        
        NSMutableArray * tempDataArray = [[NSMutableArray alloc] init];
        for (NSUInteger i = 0;i < configurationModel.datasArray.count;i++) {
            
            NSDictionary * dic = (NSDictionary *)configurationModel.datasArray[i];
            SHUploadModel * model = [[SHUploadModel alloc] init];

            if([dic.allKeys containsObject:@"uploadData"]){
                
                model.uploadData = dic[@"uploadData"];
            }
            
            if([dic.allKeys containsObject:@"uploadDataType"]){
                
                model.uploadDataType = dic[@"uploadDataType"];
            }
            
            if([dic.allKeys containsObject:@"uploadDataName"]){
                
                model.uploadDataName = dic[@"uploadDataName"];
            }
            
            if ([dic.allKeys containsObject:@"uploadDataTimeLength"]) {
                
                //秒
                model.uploadDataTimeLength = dic[@"uploadDataTimeLength"];
            }
            
            if([dic.allKeys containsObject:@"uploadDataPath"]){
                
                model.uploadDataPath = dic[@"uploadDataPath"];
            }
            
            model.uploadDataId = [[NSString alloc] initWithFormat:@"%@%lu",configurationModel.Identification,(long)i];
            
            [tempDataArray addObject:model];
        }
        
        [configurationModel.datasArray removeAllObjects];
        [configurationModel.datasArray addObjectsFromArray:tempDataArray];
        
        return configurationModel;
    }
    else{
        
        NSLog(@"异常：JHNewUploadConfigurationModel字典转模型失败");
        SHUploadConfigurationModel * configurationModel = [[SHUploadConfigurationModel alloc] init];
        return configurationModel;
    }
}

//上传图片，视频等资源的data数据
+(void)uploadDatas:(NSDictionary *)initDic callBack:(void(^)(NSDictionary *retultDic))callBack{
    
    SHUploadConfigurationModel * configurationModel = [SHUploadComponent getConfigurationModelWithDic:initDic];
    if (!configurationModel.serverUrlStr || configurationModel.serverUrlStr.length < 1) {
        
        callBack(@{@"error":@"未配置文件服务器路径"});
    }
    else if (!configurationModel.datasArray || configurationModel.datasArray.count == 0){
        
        callBack(@{@"error":@"无要上传数据"});
    }
    else{
     
        [[NewUploadController sharedManager] uploadDatasWithConfigurationModel:configurationModel callBack:callBack];
    }
}
/*
//暂停上传
+(void)suspendUploadDatas:(NSDictionary *)initDic callBack:(void(^)(NSDictionary *retultDic))callBack{
    
    JHNewUploadConfigurationModel * configurationModel = [JHNewUploadComponent getConfigurationModelWithDic:initDic];
    [[NewUploadController sharedManager] suspendUploadWithConfigurationModel:configurationModel callBack:callBack];
}
//继续上传
+(void)continueUploadDatas:(NSDictionary *)initDic callBack:(void(^)(NSDictionary *retultDic))callBack{
    
    JHNewUploadConfigurationModel * configurationModel = [JHNewUploadComponent getConfigurationModelWithDic:initDic];
    [[NewUploadController sharedManager] continueUploadWithConfigurationModel:configurationModel callBack:callBack];
}
//停止上传
+(void)stopUploadDatas:(NSDictionary *)initDic callBack:(void(^)(NSDictionary *retultDic))callBack{
    
    JHNewUploadConfigurationModel * configurationModel = [JHNewUploadComponent getConfigurationModelWithDic:initDic];
    [[NewUploadController sharedManager] stopUploadWithConfigurationModel:configurationModel callBack:callBack];
}

//得到上传列表页面指针
+(void)getUploadTableViewControllerCallBack:(void(^)(NSDictionary *retultDic))callBack{
    
    UploadTableViewController * listVC = [[UploadTableViewController alloc] initWithTitle:@"上传列表"];
    callBack(@{@"listVC":listVC});
}

//上传未上传完的数据
+(void)uploadNotFinishDatasCallBack:(void(^)(NSDictionary *retultDic))callBack{
    
    [[NewUploadController sharedManager].uploadDataModelArray removeAllObjects];
    [[NewUploadController sharedManager].uploadDataModelArray removeAllObjects];
    NSArray * arr = [[UploadDataManagerController sharedManager] getDataList];
    for (NSUInteger i = 0; i < arr.count; i++) {

        NSDictionary * dic = arr[i];
        
        NSString * EndDateStr = dic[@"EndDate"];
        if (![NSString contentIsNullORNil:EndDateStr]) {
            
            NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSDate * endDate = [formatter dateFromString:EndDateStr];
            NSDate * nowDate = [NSDate date];
            if ([nowDate compare:endDate] == NSOrderedDescending) {
             
                //缓存文件已超时，不上传，删除
                dispatch_async(dispatch_get_global_queue(0, 0), ^{
                    
                    [[UploadDataManagerController sharedManager] deleteUploadDataDic:@{@"uploadDataId":dic[@"uploadDataId"]}];
                });
                return;
            }
        }
        
        NSString * tempUploadDataPath = dic[@"uploadDataPath"];
        NSString * uploadDataPath = @"";
        if ([tempUploadDataPath containsString:@"Documents"]) {
            
            NSRange range = [tempUploadDataPath rangeOfString:@"Documents/"];
            NSString * dataNameStr = [tempUploadDataPath substringWithRange:NSMakeRange(0, range.location * range.length)];
            NSString * docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
            uploadDataPath = [[NSString alloc] initWithFormat:@"%@%@",docPath,dataNameStr];
        }
        else if ([tempUploadDataPath containsString:@"Library"]){
            
            NSRange range = [tempUploadDataPath rangeOfString:@"Library"];
            NSString * dataNameStr = [tempUploadDataPath substringFromIndex:range.location + range.length];
            NSString * docPath = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)[0];
            uploadDataPath = [[NSString alloc] initWithFormat:@"%@%@",docPath,dataNameStr];
        }
        
        //延时，解决崩溃
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(i * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            //uploadDataId比Identification多一位
            NSString * uploadDataId = dic[@"uploadDataId"];
            NSString * Identification = [uploadDataId substringToIndex:uploadDataId.length - 1];
            [JHNewUploadComponent uploadDatas:@{@"Identification":Identification,@"datasArray":@[@{@"uploadData":@"",@"uploadDataName":dic[@"uploadDataName"],@"uploadDataPath":uploadDataPath,@"uploadDataType":dic[@"uploadDataType"],@"uploadDataId":dic[@"uploadDataId"]}],@"serverUrlStr":dic[@"serverUrlStr"],@"isSingleReturn":[NSNumber numberWithBool:YES],@"isSingleThread":[NSNumber numberWithBool:NO],@"isAddUploadList":[NSNumber numberWithBool:YES]} callBack:callBack];
        });
    }
}
*/
@end
