//
//  SmartCamareViewController.h
//  JHLivePlayLibrary
//
//  Created by pk on 2018/3/13.
//  Copyright © 2018年 pk. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^GetClearImage)(UIImage * image);

typedef void(^ShowSystemCamareViewCtroller)();

typedef NS_OPTIONS(NSUInteger, CameraGetPictureType) {
    CameraGetPictureType_Licence = 1 << 0,
    CameraGetPictureType_IDCard = 1 << 1
};

@interface JHSmartCamareViewController : UIViewController

@property(nonatomic,copy) GetClearImage getImageCallBack;

@property(nonatomic,copy) ShowSystemCamareViewCtroller showSysCamare;

- (instancetype)initWithType:(CameraGetPictureType)getPictureType;



@end
