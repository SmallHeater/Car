//
//  ContentListItemModel.h
//  Car
//
//  Created by mac on 2019/11/2.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  论坛详情文本项，图片项，视频项模型

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ContentListItemModel : NSObject

//type:text,img,video
@property (nonatomic , copy) NSString              * type;
@property (nonatomic , copy) NSString              * content;
@property (nonatomic , copy) NSString              * href;
@property (nonatomic , copy) NSString              * title;
@property (nonatomic , assign) NSInteger              start;
@property (nonatomic , assign) NSInteger              end;


//图片宽高，仅type为img有效
@property (nonatomic,assign) float imageWidth;
@property (nonatomic,assign) float imageHeight;

@end

NS_ASSUME_NONNULL_END
