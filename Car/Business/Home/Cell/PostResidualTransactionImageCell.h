//
//  PostResidualTransactionImageCell.h
//  Car
//
//  Created by mac on 2019/10/10.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  发布残值交易图片cell，高度430

#import "SHBaseTableViewCell.h"

typedef void(^CallBack)(NSString * _Nullable imagesUrl);

NS_ASSUME_NONNULL_BEGIN

@interface PostResidualTransactionImageCell : SHBaseTableViewCell

//主动上传图片
-(void)uploadImageCallBack:(CallBack)callBack;

@end

NS_ASSUME_NONNULL_END
