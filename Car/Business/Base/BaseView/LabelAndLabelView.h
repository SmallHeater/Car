//
//  LabelAndLabelView.h
//  JHLivePlayLibrary
//
//  Created by xianjunwang on 2018/4/26.
//  Copyright © 2018年 pk. All rights reserved.
//  上面label，下面label的view。上面的label和下面的label高度比为3：5。上面的label，默认12号字，普通字体，色值333333，居中显示,背景色e7e7e7e7。下面的label，默认16号字，加粗字体，色值333333，居中显示，背景色ffffff。

#import <UIKit/UIKit.h>

@interface LabelAndLabelView : UIView

//上面的label
@property (nonatomic,strong) UILabel * aboveLabel;
//下面的label
@property (nonatomic,strong) UILabel * belowLabel;

-(instancetype)initWithFrame:(CGRect)frame andAboveLabelText:(NSString * )aboveLabelText andBelowLabelText:(NSString *)belowLabelText;

//刷新上面和下面label的显示内容,若传入参数为nil,则不刷新对应的label
-(void)refreshAboveLabelText:(NSString *)aboveLabelText belowLabelText:(NSString *)belowLabelText;

@end
