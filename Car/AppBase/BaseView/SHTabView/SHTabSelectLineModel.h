//
//  SHTabSelectLineModel.h
//  Car
//
//  Created by mac on 2019/9/24.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  页签项横线配置模型

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SHTabSelectLineModel : NSObject

//是否显示选中横线
@property (nonatomic,assign) BOOL isShowSelectedLine;
//横线宽度
@property (nonatomic,assign) float lineWidth;
//横线高度
@property (nonatomic,assign) float lineHeight;
//横线圆角
@property (nonatomic,assign) float lineCornerRadio;

@end

NS_ASSUME_NONNULL_END
