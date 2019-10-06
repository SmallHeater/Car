//
//  PostJobInputCell.h
//  Car
//
//  Created by mac on 2019/10/5.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  发布招聘信息输入cell,标题，联系电话,高度51

#import "PostJobBaseCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface PostJobInputCell : PostJobBaseCell

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier andTitle:(NSString *)title andPlaceholder:(NSString *)placeholder andShowBottomLine:(BOOL)isShow;

//修改输入框键盘
-(void)refrshTFKeyboard:(UIKeyboardType)keyboardType;

@end

NS_ASSUME_NONNULL_END
