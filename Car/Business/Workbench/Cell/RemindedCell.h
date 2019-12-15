//
//  UnpaidCell.h
//  Car
//
//  Created by mac on 2019/9/2.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  已提醒cell

NS_ASSUME_NONNULL_BEGIN

@interface RemindedCell : SHBaseTableViewCell

+(float)cellHeightWithContent:(NSString *)content;

//@"numberPlate":车牌,@"name":联系人,@"carModel":车型号,@"phoneNumber":联系电话,@"content",维修内容;"date":回访日期;
-(void)showDataWithDic:(NSDictionary *)dic;
-(void)test;

@end

NS_ASSUME_NONNULL_END
