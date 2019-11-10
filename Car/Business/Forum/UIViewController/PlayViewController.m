//
//  PushAndPlayViewController.m
//  Car
//
//  Created by mac on 2019/10/29.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "PlayViewController.h"
#import "SHImageAndTitleBtn.h"
#import  <AVFoundation/AVFoundation.h>
#import "SmallVideoViewController.h"

@interface PlayViewController ()

@property (nonatomic,strong) UIImageView * bgImageView;
//停止播放
@property (nonatomic,strong) UIButton * stopPlayBtn;
//关闭按钮
@property (nonatomic,strong) UIButton * clostBtn;
//发布按钮
@property (nonatomic,strong) SHImageAndTitleBtn * publishBtn;
//我发布的
@property (nonatomic,strong) SHImageAndTitleBtn * myPublish;
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
@property (nonatomic,strong) VideoModel * model;

@property (nonatomic,strong)AVPlayer *player;//播放器对象

@property (nonatomic, strong) AVPlayerLayer *playerLayer;

@property (nonatomic,strong)AVPlayerItem *currentPlayerItem;

@property (nonatomic,strong)UIView *containerView;


@end

@implementation PlayViewController

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
        
        [_bgImageView addSubview:self.myPublish];
        [self.myPublish mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.top.offset(27 + [SHUIScreenControl liuHaiHeight]);
            make.right.offset(-11);
            make.width.offset(60);
            make.height.offset(34);
        }];
        
        [_bgImageView addSubview:self.publishBtn];
        [self.publishBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.top.equalTo(self.myPublish.mas_top);
            make.right.equalTo(self.myPublish.mas_left).offset(-20);
            make.width.offset(30);
            make.height.equalTo(self.myPublish.mas_height);
        }];
        
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
           
            make.bottom.equalTo(self.shareBtn.mas_top).offset(-20);
            make.right.equalTo(self.shareBtn.mas_right);
            make.width.equalTo(self.shareBtn.mas_width);
            make.height.equalTo(self.shareBtn.mas_height);
        }];
        
        [_bgImageView addSubview:self.collectBtn];
        [self.collectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.bottom.equalTo(self.praiseBtn.mas_top).offset(-20);
            make.right.equalTo(self.praiseBtn.mas_right);
            make.width.equalTo(self.praiseBtn.mas_width);
            make.height.equalTo(self.praiseBtn.mas_height);
        }];
        
        [_bgImageView addSubview:self.avaterImageView];
        [self.avaterImageView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.bottom.equalTo(self.collectBtn.mas_top).offset(-36);
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
        //播放，发布分离
        _publishBtn.hidden = YES;
    }
    return _publishBtn;
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

-(SHImageAndTitleBtn *)myPublish{
    
    if (!_myPublish) {
        
        NSUInteger btnWidth = 60;
        _myPublish = [[SHImageAndTitleBtn alloc] initWithFrame:CGRectZero andImageFrame:CGRectMake((btnWidth - 17) / 2, 0, 17, 17) andTitleFrame:CGRectMake(0, 22, btnWidth, 12) andImageName:@"wofabude" andSelectedImageName:@"wofabude" andTitle:@"我发布的"];
        [_myPublish refreshColor:[UIColor whiteColor]];
        __weak typeof(self) weakSelf = self;
        [[_myPublish rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
           
            SmallVideoViewController * vc = [[SmallVideoViewController alloc] initWithType:VCType_MyVideos];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }];
    }
    return _myPublish;
}

-(UIImageView *)avaterImageView{
    
    if (!_avaterImageView) {
        
        _avaterImageView = [[UIImageView alloc] init];
        _avaterImageView.layer.cornerRadius = 24;
        _avaterImageView.layer.masksToBounds = YES;
        [_avaterImageView sd_setImageWithURL:[NSURL URLWithString:self.model.avatar]];
    }
    return _avaterImageView;
}

-(SHImageAndTitleBtn *)collectBtn{
    
    if (!_collectBtn) {
        
        NSUInteger btnWidth = 26;
        _collectBtn = [[SHImageAndTitleBtn alloc] initWithFrame:CGRectZero andImageFrame:CGRectMake((btnWidth - 26) / 2, 0, 26, 26) andTitleFrame:CGRectMake(0, 33, btnWidth, 12) andImageName:@"shoucangbaise" andSelectedImageName:@"shoucangbaise" andTitle:@"0"];
        [_collectBtn refreshColor:[UIColor whiteColor]];
        [_collectBtn refreshTitle:[NSString stringWithFormat:@"%ld",self.model.likes]];
    }
    return _collectBtn;
}

-(SHImageAndTitleBtn *)praiseBtn{
    
    if (!_praiseBtn) {
        
        NSUInteger btnWidth = 26;
        _praiseBtn = [[SHImageAndTitleBtn alloc] initWithFrame:CGRectZero andImageFrame:CGRectMake((btnWidth - 26) / 2, 0, 26, 26) andTitleFrame:CGRectMake(0, 33, btnWidth, 12) andImageName:@"zan" andSelectedImageName:@"zan" andTitle:@"0"];
        _praiseBtn.userInteractionEnabled = NO;
        [_praiseBtn refreshColor:[UIColor whiteColor]];
        [_praiseBtn refreshTitle:[NSString stringWithFormat:@"%ld",self.model.views]];
    }
    return _praiseBtn;
}

-(SHImageAndTitleBtn *)shareBtn{
    
    if (!_shareBtn) {
        
        NSUInteger btnWidth = 26;
        _shareBtn = [[SHImageAndTitleBtn alloc] initWithFrame:CGRectZero andImageFrame:CGRectMake((btnWidth - 26) / 2, 0, 26, 26) andTitleFrame:CGRectMake(0, 33, btnWidth, 12) andImageName:@"fenxiangbaise" andSelectedImageName:@"fenxiangbaise" andTitle:@"0"];
        [_shareBtn refreshColor:[UIColor whiteColor]];
        [_shareBtn refreshTitle:[NSString stringWithFormat:@"%ld",self.model.shares]];
    }
    return _shareBtn;
}

-(UILabel *)nickNameLabel{
    
    if (!_nickNameLabel) {
        
        _nickNameLabel = [[UILabel alloc] init];
        _nickNameLabel.font = BOLDFONT16;
        _nickNameLabel.textColor = [UIColor whiteColor];
        _nickNameLabel.text = [NSString stringWithFormat:@"@%@",self.model.shop_name];
    }
    return _nickNameLabel;
}

-(UILabel *)titleLabel{
    
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = BOLDFONT16;
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.numberOfLines = 0;
        _titleLabel.text = self.model.name;
    }
    return _titleLabel;
}

-(AVPlayerItem *)currentPlayerItem{
    
    if (!_currentPlayerItem) {
        
        _currentPlayerItem = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:self.model.href]];
        //通过KVO来观察status属性的变化，来获得播放之前的错误信息
        [_currentPlayerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    }
    return _currentPlayerItem;
}

-(AVPlayer *)player{
    
    if (!_player) {
        
        _player = [AVPlayer playerWithPlayerItem:self.currentPlayerItem];
    }
    return _player;
}

-(AVPlayerLayer *)playerLayer{
    
    if (!_playerLayer) {
        
        _playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
        self.playerLayer.backgroundColor = [UIColor blackColor].CGColor;
        _playerLayer.frame = CGRectMake(0, 0,MAINWIDTH,MAINHEIGHT);
        [self.player play];
    }
    return _playerLayer;
}

#pragma mark  ----  生命周期函数

-(instancetype)initWithVideoModel:(VideoModel *)model{
    
    self = [super init];
    if (self) {
        
        if (model && [model isKindOfClass:[VideoModel class]]) {
            
            self.model = model;
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self drawUI];
}

#pragma mark  ----  代理

#pragma mark  ----  自定义函数

-(void)drawUI{
    
    [self.view.layer addSublayer:self.playerLayer];
    
    [self.view addSubview:self.bgImageView];
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.top.bottom.offset(0);
    }];
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

@end
