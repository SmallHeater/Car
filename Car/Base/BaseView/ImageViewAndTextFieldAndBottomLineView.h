//
//  ImageViewAndTextFieldAndBottomLineView.h
//  Car
//
//  Created by mac on 2019/8/22.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  坐标图标，右侧输入框，下边横线的view;高度固定为53

#import "BaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface ImageViewAndTextFieldAndBottomLineView : BaseView

//实例化方法;imageName:图片名;placeholder:默认显示文字;
-(instancetype)initWithConfigurationDic:(NSDictionary *)configurationDic;

//设置键盘样式
-(void)setKeyboardType:(UIKeyboardType)keyboardType;
//获取输入内容
-(NSString *)getInputText;

@end

NS_ASSUME_NONNULL_END
