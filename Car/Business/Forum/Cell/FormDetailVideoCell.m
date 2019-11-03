//
//  FormDetailVideoCell.m
//  Car
//
//  Created by mac on 2019/11/2.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "FormDetailVideoCell.h"
#import <AVKit/AVKit.h>


@interface FormDetailVideoCell ()

@property (nonatomic,strong) AVPlayerViewController * playController;


@end

@implementation FormDetailVideoCell

#pragma mark  ----  懒加载

-(AVPlayerViewController *)playController{
    
    if (!_playController) {
        
        _playController = [[AVPlayerViewController alloc] init];
    }
    return _playController;
}

#pragma mark  ----  生命周期函数

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self drawUI];
    }
    return self;
}

#pragma mark  ----  自定义函数

-(void)drawUI{
    
    [self addSubview:self.self.playController.view];
    [self.playController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(16);
        make.right.offset(-16);
        make.top.offset(10);
        make.bottom.offset(-10);
    }];
}

-(void)showUrl:(NSString *)str{
    
    self.playController.player = [[AVPlayer alloc] initWithURL:[NSURL URLWithString:[NSString repleaseNilOrNull:str]]];
    [self.playController.player play];
    [self.playController.player pause];
}

@end
