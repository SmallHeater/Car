//
//  PostViewController.m
//  Car
//
//  Created by mac on 2019/10/6.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "PostViewController.h"
#import "SHTextView.h"
#import "SHImageAndTitleBtn.h"
#import "UserInforController.h"
#import "TopicForumViewController.h"
#import "SHLocatingManager.h"
#import "SHBaiDuBosControl.h"
#import "SHImageCompressionController.h"
#import "YYAnimatedImageView.h"
#import "YYImage.h"

@interface PostViewController ()<UITextFieldDelegate>

//发布按钮
@property (nonatomic,strong) UIButton * postBtn;
//标题输入框
@property (nonatomic,strong) UITextField * titleTF;
//分割线
@property (nonatomic,strong) UILabel * lineLabel;
@property (nonatomic,strong) YYTextView * contentTF;
//底部view
@property (nonatomic,strong) UIView * bottomView;
//论坛ID
@property (nonatomic,strong) NSString * section_id;

@end

@implementation PostViewController

#pragma mark  ----  懒加载

-(UIButton *)postBtn{
    
    if (!_postBtn) {
        
        _postBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_postBtn setTitle:@"发布" forState:UIControlStateNormal];
        [_postBtn setTitleColor:Color_0072FF forState:UIControlStateNormal];
        _postBtn.titleLabel.font = FONT15;
        __weak typeof(self) weakSelf = self;
        [[_postBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            
            NSString * showStr;
            if ([NSString strIsEmpty:weakSelf.titleTF.text]) {
                
                showStr = @"请输入标题";
            }
            else if ([NSString strIsEmpty:weakSelf.contentTF.text]){

                showStr = @"请输入正文";
            }
            else if ([NSString strIsEmpty:weakSelf.section_id]){
                
                showStr = @"请选择论坛";
            }
            
            if ([NSString strIsEmpty:showStr]) {
                
                NSString * contentStr;
                NSString * str = self.contentTF.text;
                NSArray *attachments = self.contentTF.textLayout.attachments;
                if (attachments.count > 0) {
                    
                    //获取图片资源
                    NSMutableArray * imageUrlArray = [[NSMutableArray alloc] init];
                    for(YYTextAttachment *attachment in attachments)
                    {
                        YYAnimatedImageView *imageView = attachment.content;
                        YYImage *image = (YYImage *)imageView.image;
                        NSData * imageData = UIImageJPEGRepresentation(image,1);
                        if (!imageData) {
                            
                            imageData = UIImagePNGRepresentation(image);
                        }
                        //压缩
                        float length = [imageData length] / 1000.0;
                        float ratio = [SHImageCompressionController getCompressionFactorWithLength:length andExpextLength:600];
                        NSData * usedImageData = UIImageJPEGRepresentation(image, ratio);
                        UIImage * usedImage = [UIImage imageWithData:usedImageData];
                        [[SHBaiDuBosControl sharedManager] uploadImage:usedImage callBack:^(NSString * _Nonnull imagePath) {
                            
                            [imageUrlArray addObject:imagePath];
                        }];
                    }
                    
                    //存储每段纯文字的数组
                    NSMutableArray * strArray = [[NSMutableArray alloc] init];
                    NSArray *attachmentRanges = self.contentTF.textLayout.attachmentRanges;
                    for (NSUInteger i = 0; i < attachmentRanges.count; i++) {
                        
                        NSValue * range = attachmentRanges[i];
                        NSRange r = [range rangeValue];
                        if (r.location == 0) {
                            
                            if (attachmentRanges.count == 1) {
                                
                                NSString * tempStr = [str substringFromIndex:1];
                                [strArray addObject:tempStr];
                            }
                            else{
                             
                                continue;
                            }
                        }
                        else
                        {
                            
                            NSString * tempStr = [str substringWithRange:NSMakeRange(i, r.location)];
                            [strArray addObject:tempStr];
                        }
                    }
                    
                    NSMutableString * tempStr = [[NSMutableString alloc] init];
                    for (NSUInteger i = 0; i < strArray.count; i++) {
                        
                        [tempStr appendString:strArray[i]];
                        if (i < strArray.count) {
                         
                            [tempStr appendString:imageUrlArray[i]];
                        }
                    }
                    
                    contentStr = tempStr;
                }
                else{
                    
                    //无图片
                    contentStr = str;
                }
                [weakSelf postWithContent:contentStr];
            }
            else{
                
                [MBProgressHUD wj_showError:showStr];
            }
        }];
    }
    return _postBtn;
}

-(UITextField *)titleTF{
    
    if (!_titleTF) {
        
        _titleTF = [[UITextField alloc] init];
        _titleTF.delegate = self;
        _titleTF.placeholder = @"标题（6-30字之间）";
        _titleTF.font = FONT15;
        _titleTF.returnKeyType = UIReturnKeyDone;
        _titleTF.textColor = Color_333333;
        UIView * leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 51)];
        _titleTF.leftView = leftView;
        _titleTF.leftViewMode = UITextFieldViewModeAlways;
    }
    return _titleTF;
}

-(UILabel *)lineLabel{
    
    if (!_lineLabel) {
        
        _lineLabel = [[UILabel alloc] init];
        _lineLabel.backgroundColor = Color_EEEEEE;
    }
    return _lineLabel;
}

//-(SHTextView *)contentTF{
//
//    if (!_contentTF) {
//
//        _contentTF = [[SHTextView alloc] init];
//        _contentTF.placeholder = @"    请输入正文，字数小于10000字";
//        _contentTF.placeholderColor = Color_999999;
//        _contentTF.textFont = FONT14;
//        _contentTF.textColor = Color_333333;
//        _contentTF.canWrap = YES;
//        _contentTF.returnKeyType = UIReturnKeyDefault;
//    }
//    return _contentTF;
//}

-(YYTextView *)contentTF{
    
    if (!_contentTF) {
        
        _contentTF = [[YYTextView alloc] init];
        _contentTF.placeholderText = @"    请输入正文，字数小于10000字";
        _contentTF.placeholderTextColor = Color_999999;
        _contentTF.font = FONT14;
        _contentTF.placeholderFont = FONT14;
        _contentTF.contentSize = CGSizeMake(MAINWIDTH, MAINHEIGHT * 3);
    }
    return _contentTF;
}

-(UIView *)bottomView{
    
    if (!_bottomView) {
        
        _bottomView = [[UIView alloc] init];
        //选中一个论坛按钮
        SHImageAndTitleBtn * seleceForumBtn = [[SHImageAndTitleBtn alloc] initWithFrame:CGRectMake(15, 0, 122, 30) andImageFrame:CGRectMake(103, 10, 10, 10) andTitleFrame:CGRectMake(10, 0, 90, 30) andImageName:@"youjiantou" andSelectedImageName:@"youjiantou" andTitle:@"选中一个论坛"];
        seleceForumBtn.layer.masksToBounds = YES;
        seleceForumBtn.layer.cornerRadius = 15;
        seleceForumBtn.layer.borderWidth = 1;
        seleceForumBtn.layer.borderColor = Color_DEDEDE.CGColor;
        [_bottomView addSubview:seleceForumBtn];
        __weak typeof(self) weakSelf = self;
        [[seleceForumBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
           
            TopicForumViewController * vc = [[TopicForumViewController alloc] initWithTitle:@"主题论坛" andShowNavgationBar:YES andIsShowBackBtn:YES andTableViewStyle:UITableViewStylePlain];
            
            [[vc rac_valuesForKeyPath:@"forumStr" observer:weakSelf] subscribeNext:^(id  _Nullable x) {
                
                if ([x isKindOfClass:[NSString class]] && ![NSString strIsEmpty:x]) {
                    
                    [seleceForumBtn refreshTitle:x];
                }
            }];
            
            [[vc rac_valuesForKeyPath:@"forumId" observer:weakSelf] subscribeNext:^(id  _Nullable x) {
                
                if ([x isKindOfClass:[NSString class]] && ![NSString strIsEmpty:x]) {
                    
                    weakSelf.section_id = x;
                }
            }];
            
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }];
        
        UIView * whiteView = [[UIView alloc] init];
        whiteView.layer.shadowColor = [UIColor colorWithRed:97/255.0 green:97/255.0 blue:97/255.0 alpha:0.16].CGColor;
        whiteView.layer.shadowOffset = CGSizeMake(0,-3);
        whiteView.layer.shadowOpacity = 1;
        whiteView.layer.shadowRadius = 9;
        whiteView.backgroundColor = [UIColor whiteColor];
        [_bottomView addSubview:whiteView];
        [whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.right.bottom.offset(0);
            make.height.offset(49);
        }];
        
        /*
         表情，定位，这一期先不要
        //表情按钮
        UIButton * expressionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [expressionButton setImage:[UIImage imageNamed:@"biaoqing"] forState:UIControlStateNormal];
        [whiteView addSubview:expressionButton];
        [expressionButton mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.offset(15);
            make.top.offset(15);
            make.width.height.offset(22);
        }];
         */
        //拍照按钮
        UIButton * photoButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [photoButton setImage:[UIImage imageNamed:@"xiangji2"] forState:UIControlStateNormal];
        [photoButton addTarget:self action:@selector(takePhoto:) forControlEvents:UIControlEventTouchUpInside];
        [whiteView addSubview:photoButton];
        [photoButton mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.offset(15);
            make.top.offset(15);
            make.width.height.offset(22);
        }];
        //相册按钮
        UIButton * albumButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [albumButton setImage:[UIImage imageNamed:@"xiangce"] forState:UIControlStateNormal];
        [albumButton addTarget:self action:@selector(gotoAlbum:) forControlEvents:UIControlEventTouchUpInside];
        [whiteView addSubview:albumButton];
        [albumButton mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(photoButton.mas_right).offset(15);
            make.top.offset(15);
            make.width.height.offset(22);
        }];
        /*
        //定位按钮
        UIButton * locationButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [locationButton setImage:[UIImage imageNamed:@"dingwei"] forState:UIControlStateNormal];
        [locationButton addTarget:self action:@selector(location:) forControlEvents:UIControlEventTouchUpInside];
        [whiteView addSubview:locationButton];
        [locationButton mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(albumButton.mas_right).offset(15);
            make.top.offset(15);
            make.width.height.offset(22);
        }];
         */
        //弹/收键盘按钮
        UIButton * keyboardButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [keyboardButton setImage:[UIImage imageNamed:@"jianpan"] forState:UIControlStateNormal];
        [[keyboardButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
           
            x.selected = !x.selected;
            if (x.selected) {
                
                [weakSelf.contentTF becomeFirstResponder];
            }
            else{
                
                [weakSelf.view endEditing:YES];
            }
        }];
        [whiteView addSubview:keyboardButton];
        [keyboardButton mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.offset(-17);
            make.top.offset(14);
            make.width.height.offset(24);
        }];
        
    }
    return _bottomView;
}

#pragma mark  ----  生命周期函数

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self drawUI];
    [self registrationNotice];
}

#pragma mark  ----  代理

#pragma mark  ----  UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}

#pragma mark  ----  自定义函数

-(void)drawUI{
    
    
    [self.navigationbar addSubview:self.postBtn];
    [self.postBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.bottom.offset(0);
        make.width.offset(61);
        make.height.offset(46);
    }];
    
    [self.view addSubview:self.titleTF];
    [self.titleTF mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.offset(0);
        make.top.equalTo(self.navigationbar.mas_bottom).offset(0);
        make.height.offset(52);
    }];
    
    [self.view addSubview:self.lineLabel];
    [self.lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.offset(0);
        make.top.equalTo(self.titleTF.mas_bottom).offset(0);
        make.height.offset(1);
    }];
    
    [self.view addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.offset(0);
        make.bottom.offset(-[SHUIScreenControl bottomSafeHeight]);
        make.height.offset(103);
    }];
    
    [self.view addSubview:self.contentTF];
    [self.contentTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.offset(0);
        make.top.equalTo(self.lineLabel.mas_bottom);
        make.bottom.equalTo(self.bottomView.mas_top);
    }];
}

//注册通知
-(void)registrationNotice{
    
    //键盘监听
    __weak typeof(self) weakSelf = self;
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardWillShowNotification object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        
        NSDictionary *userInfo = [x userInfo];
        CGFloat duration = [[userInfo objectForKey:@"UIKeyboardAnimationDurationUserInfoKey"] doubleValue];
        CGRect rect = [[userInfo objectForKey:@"UIKeyboardFrameEndUserInfoKey"]CGRectValue];
        [UIView animateWithDuration:duration animations:^{
            
            [weakSelf.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
                
                make.left.right.offset(0);
                make.height.offset(103);
                make.bottom.offset(-rect.size.height);
            }];
        }];
    }];
    
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardWillHideNotification object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        
        [weakSelf.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.right.offset(0);
            make.bottom.offset(-[SHUIScreenControl bottomSafeHeight]);
            make.height.offset(103);
        }];
    }];
}

//发帖
-(void)postWithContent:(NSString *)contentStr{

    NSDictionary * bodyParameters = @{@"user_id":[UserInforController sharedManager].userInforModel.userID,@"title":self.titleTF.text,@"content":contentStr,@"section_id":self.section_id};
    NSDictionary * configurationDic = @{@"requestUrlStr":PostArticle,@"bodyParameters":bodyParameters};
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
                    [MBProgressHUD wj_showSuccess:@"发帖成功"];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        
                        [weakSelf backBtnClicked:nil];
                    });
                }
                else{
                    
                    //异常
                    [MBProgressHUD wj_showError:dic[@"msg"]];
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

//去拍照
-(void)takePhoto:(UIButton *)button{
    
    button.userInteractionEnabled = NO;
    __weak typeof(self) weakSelf = self;
    [SHRoutingComponent openURL:TAKEPHOTO withParameter:@{@"cameraType":[NSNumber numberWithInteger:0]} callBack:^(NSDictionary *resultDic) {
        
        button.userInteractionEnabled = YES;
        if ([resultDic.allKeys containsObject:@"error"]) {
            
            //异常
            NSLog(@"异常");
        }
        else if ([resultDic.allKeys containsObject:@"image"]){
            
            UIImage * image = resultDic[@"image"];
            [weakSelf createStrWithImages:@[image]];
        }
    }];
}

//去相册
-(void)gotoAlbum:(UIButton *)btn{
    
    btn.userInteractionEnabled = NO;
    __weak typeof(self) weakSelf = self;
    [SHRoutingComponent openURL:GETIMAGE withParameter:@{@"tkCamareType":[NSNumber numberWithInteger:0],@"canSelectImageCount":[NSNumber numberWithInteger:9],@"sourceType":[NSNumber numberWithInteger:0]} callBack:^(NSDictionary *resultDic) {
        
        btn.userInteractionEnabled = YES;
        if (resultDic && [resultDic isKindOfClass:[NSDictionary class]]) {
            
            NSArray * dataArray = resultDic[@"data"];
            NSMutableArray * imageArray = [[NSMutableArray alloc] init];
            for (NSDictionary * dic in dataArray) {
                
                UIImage * image = dic[@"screenSizeImage"];
                [imageArray addObject:image];
            }
            [weakSelf createStrWithImages:imageArray];
        }
    }];
}

//定位
-(void)location:(UIButton *)btn{
    
    btn.userInteractionEnabled = YES;
    [[SHLocatingManager sharedManager] startLocating:^(NSDictionary * _Nonnull resultDic) {
        
    }];
    btn.userInteractionEnabled = NO;
}

//创建富文本
-(void)createStrWithImages:(NSMutableArray<UIImage *> *)images{

    //2.初始化富文本对象
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.contentTF.attributedText];
    [attributedString yy_appendString:@"\n"];
    for (UIImage * image in images) {
        
        //3.初始化NSTextAttachment对象
        float imageHeight = image.size.height / image.size.width * MAINWIDTH;
        YYAnimatedImageView *imageView = [[YYAnimatedImageView alloc] initWithImage:image];
        imageView.layer.borderColor = Color_333333.CGColor;
        imageView.layer.borderWidth = 1;
        imageView.frame = CGRectMake(0, 0,MAINWIDTH,imageHeight);
        NSMutableAttributedString *attachText = [NSMutableAttributedString yy_attachmentStringWithContent:imageView contentMode:UIViewContentModeScaleAspectFit attachmentSize:CGSizeMake(MAINWIDTH, imageHeight) alignToFont:nil alignment:YYTextVerticalAlignmentCenter];
        [attributedString appendAttributedString:attachText];
        [attributedString yy_appendString:@"\n"];
    }
    //5.用label的attributedText属性来使用富文本
    self.contentTF.attributedText = attributedString;
}

@end
