//
//  SHCarMaterViewController.h
//  Car
//
//  Created by mac on 2019/12/8.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  车店大师行驶证识别页面

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^GetClearImage)(UIImage * image);

@interface SHCarMaterViewController : UIViewController

@property(nonatomic,copy) GetClearImage getImageCallBack;

@end

NS_ASSUME_NONNULL_END
