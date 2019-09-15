//
//  CustomerManagementCell.h
//  Car
//
//  Created by mac on 2019/8/24.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  客户管理cell

NS_ASSUME_NONNULL_BEGIN

@protocol CustomerManagementCellDelegate <NSObject>

-(void)itemClickedWithItemID:(NSString *)itemId;

@end


@interface CustomerManagementCell : SHBaseTableViewCell

@property (nonatomic,weak) id<CustomerManagementCellDelegate>delegate;

//title,cell标题;btnDicArray,按钮字典数组;imageName,图片名字;imageWidth,图片宽度;imageHeight,图片高度;btnTitle,按钮标题;
-(void)showData:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
