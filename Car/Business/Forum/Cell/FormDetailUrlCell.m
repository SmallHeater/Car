//
//  FormDetailUrlCell.m
//  Car
//
//  Created by mac on 2019/11/3.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "FormDetailUrlCell.h"
#import "SHBaseWKWebViewController.h"


@interface FormDetailUrlCell ()<UITextViewDelegate>

//超链接点击好实现
@property (nonatomic,strong) UITextView * contentTF;

@end

@implementation FormDetailUrlCell

#pragma mark  ----  懒加载

-(UITextView *)contentTF{
    
    if (!_contentTF) {
        
        _contentTF = [[UITextView alloc] init];
        _contentTF.textColor = Color_333333;
        _contentTF.font = FONT16;
        _contentTF.delegate = self;
        _contentTF.userInteractionEnabled = YES;
        _contentTF.editable = NO;
        _contentTF.scrollEnabled = NO;
    }
    return _contentTF;
}

#pragma mark  ----  生命周期函数

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self drawUI];
    }
    return self;
}

#pragma mark  ----  UITextViewDelegate

-(BOOL)textView:(UITextView *)textView shouldInteractWithURL:(nonnull NSURL *)URL inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction{
    
    if ([[URL scheme] isEqualToString:@"chaolianjie"]) {
        
        NSString * str = URL.absoluteString;
        NSString * urlStr = [str substringFromIndex:14];
        SHBaseWKWebViewController * vc = [[SHBaseWKWebViewController alloc] initWithTitle:@"" andIsShowBackBtn:YES andURLStr:urlStr];
        vc.modalPresentationStyle = UIModalPresentationFullScreen;
        UIViewController * topVc = [UIViewController topMostController];
        if (topVc.navigationController) {
            
            [topVc.navigationController pushViewController:vc animated:YES];
        }
        else{
            
            UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:vc];
            [topVc presentViewController:nav animated:YES completion:nil];
        }
        return NO;
    }
    return YES;
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
    
    [self addSubview:self.contentTF];
    [self.contentTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(16);
        make.right.offset(-16);
        make.top.offset(10);
        make.bottom.offset(-10);
    }];
}

-(void)show:(ContentListItemModel *)model{
    
    if (![NSString strIsEmpty:model.title]) {
        
        //超链接类型
        NSString * tempContent = model.content;
        NSUInteger start = model.start;
        NSUInteger end = model.end;
        NSString * title = model.title;
        NSString * showContent = [tempContent stringByReplacingCharactersInRange:NSMakeRange(start, end - start) withString:title];
        
        //创建富文本，并且将超链接文本设置为蓝色+下划线
        NSMutableAttributedString * content = [[NSMutableAttributedString alloc] initWithString:showContent];
        NSRange range = [showContent rangeOfString:title];
        [content addAttributes: @{ NSForegroundColorAttributeName: [UIColor blueColor] } range: range];
        [content addAttributes: @{ NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle) } range: range];
        
        // 1.必须要用前缀（chaolianjie，secondPerson），随便写但是要有
        // 2.要有后面的方法，如果含有中文，url会无效，所以转码
            NSString *valueString1 = [[NSString stringWithFormat:@"chaolianjie://%@",model.href] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
            [content addAttribute:NSLinkAttributeName value:valueString1 range:range];
        
        self.contentTF.attributedText = content;
    }
    else{
        
        NSString * content = model.content;
        self.contentTF.text = content;
    }
}

@end
