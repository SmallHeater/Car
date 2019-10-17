//
//  ProductStatementCell.h
//  Car
//
//  Created by mac on 2019/10/17.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  产品声明，法律声明cell

#import "SHBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProductStatementCell : SHBaseTableViewCell

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier andShowBottomLine:(BOOL)show;
-(void)show:(NSString *)title content:(NSString *)content;

@end

NS_ASSUME_NONNULL_END
