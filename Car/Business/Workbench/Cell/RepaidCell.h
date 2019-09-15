//
//  UnpaidCell.h
//  Car
//
//  Created by mac on 2019/9/2.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  已回款cell

NS_ASSUME_NONNULL_BEGIN

@interface RepaidCell : SHBaseTableViewCell

+(float)cellHeightWithContent:(NSString *)content andRepaidListCount:(NSUInteger)count;

//@"numberPlate":车牌,@"name":联系人,@"carModel":车型号,@"phoneNumber":联系电话,@"content",维修内容;"repaidList":汇款数组;
-(void)showDataWithDic:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
