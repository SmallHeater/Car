//
//  SHQRCodeLibrary.m
//  SHQRCodeLibrary
//
//  Created by xianjunwang on 2018/4/16.
//  Copyright © 2018年 xianjunwang. All rights reserved.
//

#import "SHQRCodeLibrary.h"
#import "QRCodeVC.h"
#import "UIViewController+SHTool.h"

@implementation SHQRCodeLibrary

//得到扫描结果
+(void)scanBlock:(void(^)(NSString * result))resultBlock{
    
    QRCodeVC * qrCodeVC = [[QRCodeVC alloc] init];
    qrCodeVC.modalPresentationStyle = UIModalPresentationFullScreen;
    qrCodeVC.resultBlock = resultBlock;
    [[UIViewController topMostController] presentViewController:qrCodeVC animated:YES completion:^{
        
    }];
}

@end
