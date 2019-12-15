//
//  MotorOilMonopolyHeaderView.m
//  Car
//
//  Created by xianjun wang on 2019/10/14.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "MotorOilMonopolyHeaderView.h"
#import "SHImageViewAndLabelView.h"


@interface MotorOilMonopolyHeaderView ()

@property (nonatomic,strong) UIImageView * imageView;
@property (nonatomic,strong) UIView * whiteView;
//门店名
@property (nonatomic,strong) UILabel * shopNameLabel;
//门店图片
@property (nonatomic,strong) UIImageView * avaterImageView;
//公告label
@property (nonatomic,strong) UILabel * announcementLabel;

@end

@implementation MotorOilMonopolyHeaderView

#pragma mark  ----  懒加载

-(UIImageView *)imageView{
    
    if (!_imageView) {
        
        _imageView = [[UIImageView alloc] init];
    }
    return _imageView;
}

-(UILabel *)shopNameLabel{
    
    if (!_shopNameLabel) {
        
        _shopNameLabel = [[UILabel alloc] init];
        _shopNameLabel.font = BOLDFONT18;
        _shopNameLabel.textColor = Color_333333;
    }
    return _shopNameLabel;
}

-(UIImageView *)avaterImageView{
    
    if (!_avaterImageView) {
        
        _avaterImageView = [[UIImageView alloc] init];
        _avaterImageView.layer.cornerRadius = 4;
    }
    return _avaterImageView;
}

-(UILabel *)announcementLabel{
    
    if (!_announcementLabel) {
        
        _announcementLabel = [[UILabel alloc] init];
        _announcementLabel.font = FONT11;
        _announcementLabel.textColor = Color_999999;
    }
    return _announcementLabel;
}

-(UIView *)whiteView{
    
    if (!_whiteView) {
        
        _whiteView = [[UIView alloc] init];
        _whiteView.backgroundColor = [UIColor whiteColor];
        _whiteView.layer.cornerRadius = 4;
        _whiteView.layer.shadowColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:0.4].CGColor;
        _whiteView.layer.shadowOffset = CGSizeMake(0,2);
        _whiteView.layer.shadowOpacity = 1;
        _whiteView.layer.shadowRadius = 10;
        
        [_whiteView addSubview:self.shopNameLabel];
        [self.shopNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.offset(12);
            make.top.offset(0);
            make.height.offset(33);
            make.right.offset(-64);
        }];
        
        [_whiteView addSubview:self.avaterImageView];
        [self.avaterImageView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.top.offset(-22);
            make.right.offset(-11);
            make.width.height.offset(53);
        }];
        
        [_whiteView addSubview:self.announcementLabel];
        [self.announcementLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.equalTo(self.shopNameLabel.mas_left);
            make.bottom.offset(-9);
            make.right.offset(0);
            make.height.offset(14);
        }];
    }
    return _whiteView;
}

#pragma mark  ----  生命周期函数

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        [self drawUI];
    }
    return self;
}

#pragma mark  ----  自定义函数

-(void)drawUI{
 
    [self addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.top.right.offset(0);
        make.height.offset(144);
    }];
    
    [self addSubview:self.whiteView];
    [self.whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(9);
        make.right.offset(-9);
        make.bottom.offset(-8);
        make.height.offset(79);
    }];
}

-(void)show:(ShopModel *)model{
    
    if (model && [model isKindOfClass:[ShopModel class]]) {
        
        if (model.images && [model.images isKindOfClass:[NSArray class]] && model.images.count > 0) {
            
            NSString * imgUrlStr = model.images[0];
            [self.imageView sd_setImageWithURL:[NSURL URLWithString:imgUrlStr]];
        }
        
        self.shopNameLabel.text = [NSString repleaseNilOrNull:model.name];
        [self.avaterImageView sd_setImageWithURL:[NSURL URLWithString:model.avatar]];
        
        if (model.tabs && [model.tabs isKindOfClass:[NSArray class]] && model.tabs.count > 0) {
            
            float imgAndLabelViewX = 12;
            for (NSUInteger i = 0; i < model.tabs.count; i++) {
                
                BOOL isShowLine = YES;
                if (i == model.tabs.count - 1) {
                    
                    isShowLine = NO;
                }
                ShopTabModel * tabModel = model.tabs[i];
                NSString * str = [NSString repleaseNilOrNull:tabModel.name];
                SHImageViewAndLabelView * imgAndLabelView = [[SHImageViewAndLabelView alloc] initWithImageUrlStr:tabModel.image andText:str andShowLine:isShowLine];
                float imgAndLabelViewWidth = [str widthWithFont:FONT11 andHeight:14] + 15 + 5;
                [self.whiteView addSubview:imgAndLabelView];
                [imgAndLabelView mas_makeConstraints:^(MASConstraintMaker *make) {
                   
                    make.left.offset(imgAndLabelViewX);
                    make.top.equalTo(self.shopNameLabel.mas_bottom);
                    make.width.offset(imgAndLabelViewWidth);
                    make.height.offset(14);
                }];
                imgAndLabelViewX += imgAndLabelViewWidth + 5;
            }
        }
        
        self.announcementLabel.text = [[NSString alloc] initWithFormat:@"公告:%@",[NSString repleaseNilOrNull:model.notice]];
    }
}

@end
