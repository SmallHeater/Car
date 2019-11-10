//
//  PushAndPlayViewController.m
//  Car
//
//  Created by mac on 2019/10/29.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "PushViewController.h"
#import "SHImageAndTitleBtn.h"
#import "VideoRecordingView.h"
#import "SHBaiDuBosControl.h"
#import "UserInforController.h"


@interface PushViewController ()

@property (nonatomic,strong) UIImageView * bgImageView;
//停止录制
@property (nonatomic,strong) UIButton * stopRecordingBtn;
//关闭按钮
@property (nonatomic,strong) UIButton * clostBtn;
//发布按钮
@property (nonatomic,strong) SHImageAndTitleBtn * publishBtn;
//开始录制按钮
@property (nonatomic,strong) UIButton * startRecordingBtn;
//录制view
@property (nonatomic,strong) VideoRecordingView * recordingView;
//视频路径
@property (nonatomic,strong) NSString * videoPath;
//小视频标题
@property (nonatomic,strong) NSString * videoTitle;
//视频上传到服务器路径
@property (nonatomic,strong) NSString * dataPath;
//封面图路径
@property (nonatomic,strong) NSString * imagePath;

@end

@implementation PushViewController

#pragma mark  ----  懒加载

-(UIImageView *)bgImageView{
    
    if (!_bgImageView) {
        
        _bgImageView = [[UIImageView alloc] init];
        _bgImageView.userInteractionEnabled = YES;
        
        [_bgImageView addSubview:self.clostBtn];
        [self.clostBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.offset(10);
            make.top.offset(28 + [SHUIScreenControl liuHaiHeight]);
            make.width.height.offset(28);
        }];
        
        [_bgImageView addSubview:self.publishBtn];
        [self.publishBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.top.offset(27 + [SHUIScreenControl liuHaiHeight]);
            make.right.offset(-70);
            make.width.offset(30);
            make.height.offset(34);
        }];
        
        [_bgImageView addSubview:self.startRecordingBtn];
        __weak typeof(self) weakSelf = self;
        [self.startRecordingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.width.offset(43);
            make.height.offset(46.5);
            make.centerX.equalTo(weakSelf.bgImageView.mas_centerX);
            make.centerY.equalTo(weakSelf.bgImageView.mas_centerY);
        }];
    }
    return _bgImageView;
}

-(UIButton *)stopRecordingBtn{
    
    if (!_stopRecordingBtn) {
        
        _stopRecordingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        __weak typeof(self) weakSelf = self;
        [[_stopRecordingBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            
            [weakSelf.recordingView stopRunning];
            [weakSelf.recordingView stopCapture];
            [weakSelf.stopRecordingBtn removeFromSuperview];
            weakSelf.bgImageView.hidden = NO;
        }];
    }
    return _stopRecordingBtn;
}

-(UIButton *)clostBtn{
    
    if (!_clostBtn) {
        
        _clostBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_clostBtn setImage:[UIImage imageNamed:@"guanbibaise"] forState:UIControlStateNormal];
        _clostBtn.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
        __weak typeof(self) weakSelf = self;
        [[_clostBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
           
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }];
    }
    return _clostBtn;
}

-(SHImageAndTitleBtn *)publishBtn{
    
    if (!_publishBtn) {
        
        NSUInteger btnWidth = 30;
        _publishBtn = [[SHImageAndTitleBtn alloc] initWithFrame:CGRectZero andImageFrame:CGRectMake((btnWidth - 17) / 2, 0, 17, 17) andTitleFrame:CGRectMake(0, 22, btnWidth, 12) andImageName:@"fabubaise" andSelectedImageName:@"fabubaise" andTitle:@"发布"];
        [_publishBtn refreshColor:[UIColor whiteColor]];
    }
    return _publishBtn;
}

-(UIButton *)startRecordingBtn{
    
    if (!_startRecordingBtn) {
        
        _startRecordingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_startRecordingBtn setImage:[UIImage imageNamed:@"kaishiluzhi"] forState:UIControlStateNormal];
        __weak typeof(self) weakSelf = self;
        
        [[_startRecordingBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
           
            //开始录制
            [weakSelf.recordingView startCapture];
            weakSelf.bgImageView.hidden = YES;
            [[UIApplication sharedApplication].keyWindow addSubview:weakSelf.stopRecordingBtn];
            [weakSelf.stopRecordingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
               
                make.left.right.top.bottom.offset(0);
            }];
        }];
    }
    return _startRecordingBtn;
}

-(VideoRecordingView *)recordingView{
    
    if (!_recordingView) {
        
        _recordingView = [[VideoRecordingView alloc] initWithFrame:CGRectMake(0, 0, MAINWIDTH, MAINHEIGHT)];
        __weak typeof(self) weakSelf = self;
        _recordingView.pathCallBack = ^(NSString * _Nonnull path) {
            
            if (![NSString strIsEmpty:path]) {
                
                weakSelf.videoPath = path;
                //是否上传
                UIAlertController * alertControl = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否上传小视频" preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                
                UIAlertAction * sureAction = [UIAlertAction actionWithTitle:@"上传" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                    
                    [weakSelf inputVideoTitle];
                }];
                
                [alertControl addAction:cancelAction];
                [alertControl addAction:sureAction];
                [weakSelf presentViewController:alertControl animated:YES completion:nil];
            }
        };
    }
    return _recordingView;
}

#pragma mark  ----  生命周期函数

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self drawUI];
}

#pragma mark  ----  代理

#pragma mark  ----  自定义函数

-(void)drawUI{
    
    [self.view addSubview:self.recordingView];
    
    [self.view addSubview:self.bgImageView];
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.top.bottom.offset(0);
    }];
}

//输入标题
-(void)inputVideoTitle{
    
    UIAlertController * alertControl = [UIAlertController alertControllerWithTitle:@"提示" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertControl addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
       
        textField.placeholder = @"请输入小视频标题";
    }];
    
    UIAlertAction * cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    __weak typeof(self) weakSelf = self;
    UIAlertAction * sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        NSString * inputTitle;
        for (UITextField * textField in alertControl.textFields) {
           
            inputTitle = textField.text;
            break;
        }
        weakSelf.videoTitle = inputTitle;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [MBProgressHUD wj_showActivityLoading:@"上传中" toView:[UIApplication sharedApplication].keyWindow];
        });
        [[SHBaiDuBosControl sharedManager] uploadWithVideoTitle:inputTitle videoPath:weakSelf.videoPath callBack:^(NSString * _Nonnull videoPath, NSString * _Nonnull imgPath) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [MBProgressHUD wj_hideHUDForView:[UIApplication sharedApplication].keyWindow];
            });
            weakSelf.dataPath = [NSString repleaseNilOrNull:videoPath];
            weakSelf.imagePath = imgPath;
            [weakSelf submitData];
        }];
    }];
    
    [alertControl addAction:cancleAction];
    [alertControl addAction:sureAction];
    
    [self presentViewController:alertControl animated:YES completion:nil];
}

-(void)backBtnClicked:(UIButton *)btn{
    
    if (self.navigationController) {
        
        if (self.navigationController.viewControllers.count == 1) {
            
            [self.navigationController dismissViewControllerAnimated:NO completion:nil];
        }else{
            
            [self.navigationController popViewControllerAnimated:YES];
        }
    }else{
        
        [self dismissViewControllerAnimated:NO completion:nil];
    }
}

-(void)submitData{
    
    //name,标题;image,封面;href,视频地址
    NSDictionary * bodyParameters = @{@"user_id":[UserInforController sharedManager].userInforModel.userID,@"name":self.videoTitle,@"image":self.imagePath,@"href":self.videoPath};
    NSDictionary * configurationDic = @{@"requestUrlStr":PostVideo,@"bodyParameters":bodyParameters};
    __weak typeof(self) weakSelf = self;
    [SHRoutingComponent openURL:REQUESTDATA withParameter:configurationDic callBack:^(NSDictionary *resultDic) {
        
        if (![resultDic.allKeys containsObject:@"error"]) {
            
            //成功的
            NSHTTPURLResponse * response = (NSHTTPURLResponse *)resultDic[@"response"];
            if (response && [response isKindOfClass:[NSHTTPURLResponse class]] && response.statusCode == 200) {
                
                id dataId = resultDic[@"dataId"];
                NSDictionary * dic = (NSDictionary *)dataId;
                NSNumber * code = dic[@"code"];
                if (code.integerValue == 1) {
                    
                    //成功
                    [weakSelf backBtnClicked:nil];
                }
                else{
                    
                    //异常
                }
            }
            else{
            }
        }
        else{
            
            //失败的
        }
    }];
}

@end
