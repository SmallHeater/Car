//
//  SHSearchTF.h
//  Car
//
//  Created by xianjun wang on 2019/9/16.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  左侧带搜索图片，右侧带别的图片的view

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^CallBack)();

@interface SHSearchTF : UITextField

//右侧view的响应
@property (nonatomic,copy) CallBack rightViewCallback;

//右侧没有view则不填
-(instancetype)initWithRightImageName:(NSString *)rightImageName;

@end

NS_ASSUME_NONNULL_END
