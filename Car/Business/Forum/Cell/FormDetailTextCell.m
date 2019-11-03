//
//  FormDetailTextCell.m
//  Car
//
//  Created by mac on 2019/11/2.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "FormDetailTextCell.h"


@interface FormDetailTextCell ()

@property (nonatomic,strong) UILabel * contentLabel;

@end

@implementation FormDetailTextCell

#pragma mark  ----  懒加载

-(UILabel *)contentLabel{
    
    if (!_contentLabel) {
        
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.font = FONT16;
        _contentLabel.textColor = Color_333333;
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
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

+(float)cellHeight:(ContentListItemModel *)model{
    
    NSString * content = @"";
    if (![NSString strIsEmpty:model.title]) {
        
        //超链接类型
        NSString * tempContent = model.content;
        NSUInteger start = model.start;
        NSUInteger end = model.end;
        NSString * title = model.title;
        content = [tempContent stringByReplacingCharactersInRange:NSMakeRange(start, end - start) withString:title];
    }
    else{
        
        content = model.content;
    }

    return [content heightWithFont:FONT16 andWidth:MAINWIDTH - 16 *2] + 20;
}

-(void)drawUI{
    
    [self addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(16);
        make.right.offset(-16);
        make.top.offset(10);
        make.bottom.offset(-10);
    }];
}

-(void)show:(ContentListItemModel *)model{
    
    self.contentLabel.text = [NSString repleaseNilOrNull:model.content];
}

@end
