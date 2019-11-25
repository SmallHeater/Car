//
//  VideoPlayCell.m
//  Car
//
//  Created by mac on 2019/11/14.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "VideoPlayCell.h"
#import "SHImageAndTitleBtn.h"
#import  <AVFoundation/AVFoundation.h>
#import "UserInforController.h"


@interface VideoPlayCell ()

@property (nonatomic,strong) UIImageView * bgImageView;
//停止播放
@property (nonatomic,strong) UIButton * stopPlayBtn;
//开始播放按钮
@property (nonatomic,strong) UIButton * startPlayBtn;
//头像
@property (nonatomic,strong) UIImageView * avaterImageView;
//点赞按钮
@property (nonatomic,strong) SHImageAndTitleBtn * collectBtn;
//播放次数
@property (nonatomic,strong) SHImageAndTitleBtn * praiseBtn;
//分享
@property (nonatomic,strong) SHImageAndTitleBtn * shareBtn;
//昵称
@property (nonatomic,strong) UILabel * nickNameLabel;
//标题
@property (nonatomic,strong) UILabel * titleLabel;
@property (nonatomic,strong)AVPlayer *player;//播放器对象
@property (nonatomic, strong) AVPlayerLayer *playerLayer;
@property (nonatomic,strong)AVPlayerItem *currentPlayerItem;
@property (nonatomic,strong)UIView *containerView;
@property (nonatomic,strong)VideoModel * currentModel;

@end

@implementation VideoPlayCell

#pragma mark  ----  懒加载

-(UIImageView *)bgImageView{
    
    if (!_bgImageView) {
        
        _bgImageView = [[UIImageView alloc] init];
        _bgImageView.userInteractionEnabled = YES;
        
        [_bgImageView addSubview:self.startPlayBtn];
        __weak typeof(self) weakSelf = self;
        [self.startPlayBtn mas_makeConstraints:^(MASConstraintMaker *make) {

            make.width.offset(43);
            make.height.offset(46.5);
            make.centerX.equalTo(weakSelf.bgImageView.mas_centerX);
            make.centerY.equalTo(weakSelf.bgImageView.mas_centerY);
        }];

        [_bgImageView addSubview:self.stopPlayBtn];
        [self.stopPlayBtn mas_makeConstraints:^(MASConstraintMaker *make) {

            make.left.right.top.bottom.offset(0);
        }];

        [_bgImageView addSubview:self.shareBtn];
        [self.shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {

            make.bottom.offset(-30 - [SHUIScreenControl bottomSafeHeight]);
            make.right.offset(-20);
            make.width.offset(26);
            make.height.offset(45);
        }];

        [_bgImageView addSubview:self.praiseBtn];
        [self.praiseBtn mas_makeConstraints:^(MASConstraintMaker *make) {

            make.bottom.equalTo(weakSelf.shareBtn.mas_top).offset(-20);
            make.right.equalTo(weakSelf.shareBtn.mas_right);
            make.width.equalTo(weakSelf.shareBtn.mas_width);
            make.height.equalTo(weakSelf.shareBtn.mas_height);
        }];

        [_bgImageView addSubview:self.collectBtn];
        [self.collectBtn mas_makeConstraints:^(MASConstraintMaker *make) {

            make.bottom.equalTo(weakSelf.praiseBtn.mas_top).offset(-20);
            make.right.equalTo(weakSelf.praiseBtn.mas_right);
            make.width.equalTo(weakSelf.praiseBtn.mas_width);
            make.height.equalTo(weakSelf.praiseBtn.mas_height);
        }];

        [_bgImageView addSubview:self.avaterImageView];
        [self.avaterImageView mas_makeConstraints:^(MASConstraintMaker *make) {

            make.bottom.equalTo(weakSelf.collectBtn.mas_top).offset(-36);
            make.right.offset(-10);
            make.width.height.offset(48);
        }];

        [_bgImageView addSubview:self.titleLabel];
        [_bgImageView addSubview:self.nickNameLabel];
        [self.nickNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {

            make.left.offset(15);
            make.bottom.offset(-74);
            make.height.offset(20);
            make.width.offset(200);
        }];
    }
    return _bgImageView;
}

-(UIButton *)stopPlayBtn{
    
    if (!_stopPlayBtn) {
        
        _stopPlayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        __weak typeof(self) weakSelf = self;
        [[_stopPlayBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            
            weakSelf.stopPlayBtn.hidden = YES;
            weakSelf.startPlayBtn.hidden = NO;
            [weakSelf.player pause];
        }];
    }
    return _stopPlayBtn;
}

-(UIButton *)startPlayBtn{
    
    if (!_startPlayBtn) {
        
        _startPlayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_startPlayBtn setImage:[UIImage imageNamed:@"kaishiluzhi"] forState:UIControlStateNormal];
        _startPlayBtn.hidden = YES;
        __weak typeof(self) weakSelf = self;
        [[_startPlayBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            
            weakSelf.startPlayBtn.hidden = YES;
            weakSelf.stopPlayBtn.hidden = NO;
            [weakSelf.player play];
        }];
    }
    return _startPlayBtn;
}

-(UIImageView *)avaterImageView{
    
    if (!_avaterImageView) {
        
        _avaterImageView = [[UIImageView alloc] init];
        _avaterImageView.layer.cornerRadius = 24;
        _avaterImageView.layer.masksToBounds = YES;
    }
    return _avaterImageView;
}

-(SHImageAndTitleBtn *)collectBtn{
    
    if (!_collectBtn) {
        
        NSUInteger btnWidth = 26;
        _collectBtn = [[SHImageAndTitleBtn alloc] initWithFrame:CGRectZero andImageFrame:CGRectMake((btnWidth - 26) / 2, 0, 26, 26) andTitleFrame:CGRectMake(0, 33, btnWidth, 12) andImageName:@"shoucangbaise" andSelectedImageName:@"shoucangbaise" andTitle:@"0"];
        [_collectBtn refreshColor:[UIColor whiteColor]];
        __weak typeof(self) weakSelf = self;
        [[_collectBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            
            x.selected = !x.selected;
            [weakSelf videoThum:weakSelf.currentModel];
        }];
    }
    return _collectBtn;
}

-(SHImageAndTitleBtn *)praiseBtn{
    
    if (!_praiseBtn) {
        
        NSUInteger btnWidth = 26;
        _praiseBtn = [[SHImageAndTitleBtn alloc] initWithFrame:CGRectZero andImageFrame:CGRectMake((btnWidth - 26) / 2, 0, 26, 26) andTitleFrame:CGRectMake(0, 33, btnWidth, 12) andImageName:@"zan" andSelectedImageName:@"zan" andTitle:@"0"];
        _praiseBtn.userInteractionEnabled = NO;
        [_praiseBtn refreshColor:[UIColor whiteColor]];
    }
    return _praiseBtn;
}

-(SHImageAndTitleBtn *)shareBtn{
    
    if (!_shareBtn) {
        
        NSUInteger btnWidth = 26;
        _shareBtn = [[SHImageAndTitleBtn alloc] initWithFrame:CGRectZero andImageFrame:CGRectMake((btnWidth - 26) / 2, 0, 26, 26) andTitleFrame:CGRectMake(0, 33, btnWidth, 12) andImageName:@"fenxiangbaise" andSelectedImageName:@"fenxiangbaise" andTitle:@"0"];
        [_shareBtn refreshColor:[UIColor whiteColor]];
    }
    return _shareBtn;
}

-(UILabel *)nickNameLabel{
    
    if (!_nickNameLabel) {
        
        _nickNameLabel = [[UILabel alloc] init];
        _nickNameLabel.font = BOLDFONT16;
        _nickNameLabel.textColor = [UIColor whiteColor];
    }
    return _nickNameLabel;
}

-(UILabel *)titleLabel{
    
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = BOLDFONT16;
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}

#pragma mark  ----  生命周期函数

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)dealloc{

}

//监听状态回调方法

-(void)observeValueForKeyPath:(NSString*)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void*)context{
    
    if ([keyPath isEqualToString:@"status"]) {
        
        //取出status的新值
        AVPlayerItemStatus status = [change[NSKeyValueChangeNewKey] intValue];
                switch(status) {
                
                            case AVPlayerItemStatusFailed:
                //失败 做相关失败操作
                                break;
                            case AVPlayerItemStatusReadyToPlay:
                //成功开始播放
                                [self.player play];
                                break;
                            case AVPlayerItemStatusUnknown:
                
                                NSLog(@"视频资源出现未知错误");
                
                                break;
                
                            default:
                
                                break;
                    }
    }
    
    //移除监听（观察者）
    [object removeObserver:self forKeyPath:@"status"];
}

#pragma mark  ----  自定义函数

//增加浏览量
-(void)addArticlePV:(VideoModel *)video{
    
    NSDictionary * bodyParameters = @{@"user_id":[UserInforController sharedManager].userInforModel.userID,@"article_id":[NSString stringWithFormat:@"%ld",video.videoId]};
    NSDictionary * configurationDic = @{@"requestUrlStr":ArticlePV,@"bodyParameters":bodyParameters};
    [SHRoutingComponent openURL:REQUESTDATA withParameter:configurationDic callBack:^(NSDictionary *resultDic) {
        
        if (![resultDic.allKeys containsObject:@"error"]) {
            
            //成功的
            NSHTTPURLResponse * response = (NSHTTPURLResponse *)resultDic[@"response"];
            if (response && [response isKindOfClass:[NSHTTPURLResponse class]] && response.statusCode == 200) {
            }
            else{
            }
        }
        else{
            
            //失败的
        }
    }];
}

//视频点赞
-(void)videoThum:(VideoModel *)video{
    
    NSDictionary * bodyParameters = @{@"user_id":[UserInforController sharedManager].userInforModel.userID,@"video_id":[NSString stringWithFormat:@"%ld",video.videoId]};
    NSDictionary * configurationDic = @{@"requestUrlStr":VideoThumb,@"bodyParameters":bodyParameters};
    [SHRoutingComponent openURL:REQUESTDATA withParameter:configurationDic callBack:^(NSDictionary *resultDic) {
        
        if (![resultDic.allKeys containsObject:@"error"]) {
            
            //成功的
            NSHTTPURLResponse * response = (NSHTTPURLResponse *)resultDic[@"response"];
            if (response && [response isKindOfClass:[NSHTTPURLResponse class]] && response.statusCode == 200) {
            }
            else{
            }
        }
        else{
            
            //失败的
        }
    }];
}

-(void)playVideo:(VideoModel *)video{
    
    if (video && [video isKindOfClass:[VideoModel class]]) {
     
        self.currentModel = video;
        if (self.playerLayer) {

            [self.playerLayer removeFromSuperlayer];
            self.currentPlayerItem = nil;
            self.player = nil;
            self.playerLayer = nil;

            [self.bgImageView removeFromSuperview];
        }
    
        [self addArticlePV:video];
        [self videoThum:video];
        
        self.currentPlayerItem = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:video.href]];
//        通过KVO来观察status属性的变化，来获得播放之前的错误信息
        [self.currentPlayerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
        self.player = [AVPlayer playerWithPlayerItem:self.currentPlayerItem];
        self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
        self.playerLayer.backgroundColor = [UIColor blackColor].CGColor;
        self.playerLayer.frame = CGRectMake(0, 0,MAINWIDTH,MAINHEIGHT);
        [self.layer addSublayer:self.playerLayer];
        [self.player play];
        
        [self addSubview:self.bgImageView];
        [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {

            make.left.right.top.bottom.offset(0);
        }];

        [self.avaterImageView sd_setImageWithURL:[NSURL URLWithString:video.avatar]];
        self.collectBtn.selected = video.thumbed;
        [self.collectBtn refreshTitle:[NSString stringWithFormat:@"%ld",video.thumbs]];
        [self.praiseBtn refreshTitle:[NSString stringWithFormat:@"%ld",video.views]];
        [self.shareBtn refreshTitle:[NSString stringWithFormat:@"%ld",video.shares]];
        self.nickNameLabel.text = [NSString stringWithFormat:@"@%@",video.shop_name];
        self.titleLabel.text = video.name;
    }
}

@end
