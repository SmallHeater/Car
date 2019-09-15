//
//  MaintenanceRecordsCell.h
//  Car
//
//  Created by mac on 2019/8/27.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  维修记录cell

NS_ASSUME_NONNULL_BEGIN

@interface MaintenanceRecordsCell : SHBaseTableViewCell

//返回cell高度
+(float)cellHeightWithContent:(NSString *)content;

//展示数据:numberPlate:车牌;name:姓名;carModel:车型号;phoneNumber:电话;content:维修内容;
-(void)showDataWithDic:(NSDictionary *)dic;

-(void)test;

@end

NS_ASSUME_NONNULL_END
