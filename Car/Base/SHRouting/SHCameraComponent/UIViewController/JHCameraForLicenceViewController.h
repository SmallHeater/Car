//
//  JHCameraForLicenceViewController.h
//  TestWebView
//
//  Created by pk on 2018/10/15.
//  Copyright © 2018年 pk. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^GetImageFromCamera)(UIImage * cutImage);

@interface JHCameraForLicenceViewController : UIViewController

@property (nonatomic,copy)GetImageFromCamera imageCallBack;

@end

NS_ASSUME_NONNULL_END
