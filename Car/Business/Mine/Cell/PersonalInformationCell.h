//
//  PersonalInformationCell.h
//  Car
//
//  Created by mac on 2019/10/21.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  个人资料cell

#import "SHBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger,CellType){
    
    CellType_Avater = 0,//头像样式
    CellType_LabelAndLabel = 1,//标题，内容样式
    CellType_LabelAndLabelWithoutLine = 2,//标题，内容样式,无底部横线
    CellType_LabelAndLabelWarning = 3,//标题，内容样式，内容为红色
    CellType_LabelAndLabelWithoutArrow = 4, //标题，内容样式，无箭头
    CellType_LabelAndLabelWithoutArrowLine = 5//标题，内容样式，无箭头,无底部横线
};

@interface PersonalInformationCell : SHBaseTableViewCell

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier andCellType:(CellType)cellType;
-(void)show:(NSString *)title andAvater:(NSString *)avater andContent:(NSString *)content;

@end

NS_ASSUME_NONNULL_END
