//
//  SHSearchTF.m
//  Car
//
//  Created by xianjun wang on 2019/9/16.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "FrameNumberTF.h"
#import <AipOcrSdk/AipOcrService.h>
#import <AipOcrSdk/AipCaptureCardVC.h>


@interface FrameNumberTF ()

@end

@implementation FrameNumberTF

#pragma mark  ----  生命周期函数

-(instancetype)init{
    
    self = [super init];
    if (self) {
        
        self.returnKeyType = UIReturnKeySearch;
        self.backgroundColor = [UIColor whiteColor];
        self.layer.shadowColor = [UIColor colorWithRed:66/255.0 green:66/255.0 blue:66/255.0 alpha:0.29].CGColor;
        self.layer.shadowOffset = CGSizeMake(1,1);
        self.layer.shadowOpacity = 1;
        self.layer.shadowRadius = 5;
        self.layer.cornerRadius = 20;
        self.clearButtonMode = UITextFieldViewModeWhileEditing;
        UIView * leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 45, 40)];
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"xiangji"] forState:UIControlStateNormal];
        btn.imageEdgeInsets = UIEdgeInsetsMake(11, 0, 11, 13);
        [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
#if TARGET_IPHONE_SIMULATOR
            
#else
            [[AipOcrService shardService] authWithAK:@"aWPDQqSndeWBNp3tlynb5S2a" andSK:@"RHxOyurd1nud4nAlCakIQMe93wc1UIMd"];
            __weak typeof(self) weakSelf = self;
            [SHRoutingComponent openURL:TAKEPHOTO withParameter:@{@"cameraType":[NSNumber numberWithInteger:2]} callBack:^(NSDictionary *resultDic) {
                
                if ([resultDic.allKeys containsObject:@"error"]) {
                    
                    //异常
                    NSLog(@"行驶证识别异常");
                }
                else if ([resultDic.allKeys containsObject:@"image"]){
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        [MBProgressHUD wj_showActivityLoading:@"识别中" toView:[UIApplication sharedApplication].keyWindow];
                    });
                    
                    UIImage * image = resultDic[@"image"];
                    [[AipOcrService shardService] detectVehicleLicenseFromImage:image withOptions:nil successHandler:^(id result) {
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            
                            [MBProgressHUD wj_hideHUDForView:[UIApplication sharedApplication].keyWindow];
                        });
                        
                        if (result && [result isKindOfClass:[NSDictionary class]]) {
                            
                            NSDictionary * workResultDic = result[@"words_result"];
                            NSDictionary * seventhDic = workResultDic[@"车辆识别代号"];
                            //车辆识别代号
                            NSString * vin = seventhDic[@"words"];
                            dispatch_async(dispatch_get_main_queue(), ^{
                                
                                weakSelf.text = vin;
                                if (weakSelf.callBack) {
                                    
                                    weakSelf.callBack();
                                }
                            });
                        }
                    } failHandler:^(NSError *err) {
                        
                        NSLog(@"失败:%@", err);
                        dispatch_async(dispatch_get_main_queue(), ^{
                            
                            [MBProgressHUD wj_hideHUDForView:[UIApplication sharedApplication].keyWindow];
                            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                
                                [MBProgressHUD wj_showError:@"识别失败，请输入"];
                            });
                        });
                    }];
                }
            }];
#endif
            

        }];
        [leftView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {

            make.left.offset(14);
            make.top.bottom.right.offset(0);
        }];
        self.leftView = leftView;
        self.leftViewMode = UITextFieldViewModeAlways;
        
        UIView * rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 46, 40)];
        UILabel * rightLineLabel = [[UILabel alloc] init];
        rightLineLabel.backgroundColor = Color_DEDEDE;
        [rightView addSubview:rightLineLabel];
        [rightLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.offset(0);
            make.top.offset(13);
            make.bottom.offset(-13);
            make.width.offset(1);
        }];
        UIButton * searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [searchBtn setImage:[UIImage imageNamed:@"sousuolan"] forState:UIControlStateNormal];
        searchBtn.imageEdgeInsets = UIEdgeInsetsMake(12, 11, 11, 17);
        
        __weak typeof(self) weakSelf = self;
        [[searchBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            
            if (weakSelf.callBack) {
                
                weakSelf.callBack();
            }
        }];
        [rightView addSubview:searchBtn];
        [searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(rightLineLabel.mas_right).offset(0);
            make.top.bottom.right.offset(0);
        }];
        self.rightView = rightView;
        self.rightViewMode = UITextFieldViewModeAlways;
    }
    return self;
}

@end
