//
//  JHTextView.m
//  JHLivePlayLibrary
//
//  Created by xianjunwang on 2018/4/21.
//

#import "SHTextView.h"
#import "MBProgressHUD.h"

@interface SHTextView ()<UITextViewDelegate>{
    
    NSString * lastContentText;//记录上一次输入框内容
    BOOL isSetSelectedRange;
    BOOL isNeedSetSelectedRange;
    NSRange selectRange;
}

@property (nonatomic,strong) UITextView * evaTextView;


@end

@implementation SHTextView

#pragma mark  ----  懒加载

-(UITextView *)evaTextView{
    
    if (!_evaTextView) {
        
        _evaTextView = [[UITextView alloc] init];
        _evaTextView.scrollEnabled = NO;
        _evaTextView.delegate = self;
        _evaTextView.font = [UIFont systemFontOfSize:14.0];
        _evaTextView.backgroundColor = [UIColor whiteColor];
        _evaTextView.returnKeyType = UIReturnKeyDone;
        _evaTextView.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0);
//        _evaTextView.backgroundColor = [UIColor greenColor];
    }
    return _evaTextView;
}

-(NSString *)text{
    
    return self.evaTextView.text;
}

-(UITextRange *)selectedTextRange{
    
    return self.evaTextView.selectedTextRange;
}

-(NSRange)selectedRange{
    
    return self.evaTextView.selectedRange;
}

#pragma mark  ----  SET

-(void)setText:(NSString *)text{
    
    self.evaTextView.text = text;
    self.evaTextView.textColor = self.textColor;
}

-(void)setPlaceholder:(NSString *)placeholder{
    
    _placeholder = placeholder;
    self.evaTextView.text = _placeholder;
    self.evaTextView.textColor = self.placeholderColor;
}

-(void)setBackgroundColor:(UIColor *)backgroundColor{
    
    super.backgroundColor = backgroundColor;
    self.evaTextView.backgroundColor = backgroundColor;
}

-(void)setInputAccessoryView:(UIView *)inputAccessoryView{
    
    self.evaTextView.inputAccessoryView = inputAccessoryView;
}

-(void)setSelectedRange:(NSRange)selectedRange{
    
    //    dispatch_async(dispatch_get_main_queue(), ^{
    
    _evaTextView.selectedRange = selectedRange;
    //    });
}

-(void)setSelectedTextRange:(UITextRange *)selectedTextRange{
    
    self.evaTextView.selectedTextRange = selectedTextRange;
}

-(void)setTextFont:(UIFont *)textFont{
    
    self.evaTextView.font = textFont;
}

-(void)setReturnKeyType:(UIReturnKeyType)returnKeyType{
    
    self.evaTextView.returnKeyType = returnKeyType;
}

-(void)setPlaceholderColor:(UIColor *)placeholderColor{
    
    _placeholderColor = placeholderColor;
    self.evaTextView.textColor = placeholderColor;
}

-(void)setTextColor:(UIColor *)textColor{
    
    _textColor = textColor;
}

#pragma mark  ----  生命周期函数
- (instancetype)init{
    
    self = [super init];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.evaTextView];
        [self.evaTextView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.right.top.bottom.offset(0);
        }];
    }
    return self;
}

#pragma mark  ----  代理函数

#pragma mark  ----  UITextViewDelegate

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    lastContentText = textView.text;
    
    //禁止输入表情
    if (![[UIApplication sharedApplication] textInputMode].primaryLanguage) {
        
        [MBProgressHUD wj_showError:@"不能输入特殊表情。"];
        return NO;
    }
    
    if ([text isEqualToString:@"☻"]) {
        
        [MBProgressHUD wj_showError:@"不能输入特殊表情。"];
        return NO;
    }
    
    if (!self.canWrap) {
        
        if ([text isEqualToString:@"\n"]) {
            
            [textView resignFirstResponder];
            return NO;
        }
    }
    
    //九宫格输入码误判为表情，处理
    if ([text isEqualToString:@"➋"] || [text isEqualToString:@"➌"] || [text isEqualToString:@"➍"] || [text isEqualToString:@"➎"] || [text isEqualToString:@"➏"] || [text isEqualToString:@"➐"] || [text isEqualToString:@"➑"] || [text isEqualToString:@"➒"]) {
        
        return YES;
    }
    
    NSString * str = textView.text;
    //表情过滤
    NSString * tempStr = [self stringContainsEmoji:text];
    NSString * newStr = [[NSString alloc] initWithFormat:@"%@%@",str,tempStr];
    if (text.length == tempStr.length) {
        
        if (self.maxCount > 0) {
            
            if (newStr.length > self.maxCount) {
                
                [MBProgressHUD wj_showError:@"您输入超过最大长度"];
                NSString * newText = [newStr substringWithRange:NSMakeRange(0, self.maxCount)];
                self.evaTextView.text = newText;
                return NO;
            }
            else{
                
                
            }
        }
        else{
            
            
        }
    }
    else{
        
        //有表情符号
        if (self.maxCount > 0) {
            
            if (newStr.length > self.maxCount) {
                
                [MBProgressHUD wj_showError:@"您输入超过最大长度"];
                NSString * newText = [newStr substringWithRange:NSMakeRange(0, self.maxCount)];
                self.evaTextView.text = newText;
                return NO;
            }
            else{
                
                self.evaTextView.text = newStr;
                [MBProgressHUD wj_showError:@"不能输入特殊表情。"];
                return NO;
            }
        }
        else{
            
            self.evaTextView.text = newStr;
            [MBProgressHUD wj_showError:@"不能输入特殊表情。"];
            return NO;
        }
    }
    
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(textView:shouldChangeTextInRange:replacementText:)]) {
         [self.delegate textView:textView shouldChangeTextInRange:range replacementText:text];
    }
    
    return YES;
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    
    if ([textView.text isEqualToString:self.placeholder]) {
        
        textView.text = @"";
        textView.textColor = self.textColor;
    }
    
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(textViewShouldBeginEditing:)]) {
            [self.delegate textViewShouldBeginEditing:textView];
        }
    }
    
    return YES;
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView{
    
    if (textView.text.length == 0) {
        
        textView.text = self.placeholder;
        textView.textColor = self.placeholderColor;
    }
    [self endEditing:YES];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(textViewShouldEndEditing:)]) {
        [self.delegate textViewShouldEndEditing:textView];
    }
    
    return YES;
}

-(void)textViewDidEndEditing:(UITextView *)textView{
    
    if (textView.text.length > 0) {
        
        if (![textView.text isEqualToString:self.placeholder]) {
            
            if (self.block) {
                
                self.block(textView.text);
            }
        }
        else{
            
            if (self.block) {
                
                self.block(@"");
            }
        }
        
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(textViewDidEndEditing:)]) {
        [self.delegate textViewDidEndEditing:textView];
    }
}

- (void)textViewDidChangeSelection:(UITextView *)textView{

    NSString * tempsStr = textView.text;
    NSString * tempTwoStr = [self stringContainsEmoji:tempsStr];
    if (tempsStr.length != tempTwoStr.length) {
        
        //有表情
        
        if (self.maxCount > 0) {
            
            if (tempTwoStr.length > self.maxCount) {
                
                [MBProgressHUD wj_showError:@"您输入超过最大长度"];
                NSString * newText = [tempTwoStr substringWithRange:NSMakeRange(0, self.maxCount)];
                self.evaTextView.text = newText;
            }
            else{
                
                
                self.evaTextView.text = tempTwoStr;
            }
        }
        else{
            
            self.evaTextView.text = tempTwoStr;
        }
        
        [MBProgressHUD wj_showError:@"不能输入特殊表情。"];
    }
    else{
        
        if (self.maxCount > 0) {
            
            if (tempTwoStr.length > self.maxCount) {
                
                [MBProgressHUD wj_showError:@"您输入超过最大长度"];
                NSString * newText = [tempTwoStr substringWithRange:NSMakeRange(0, self.maxCount)];
                self.evaTextView.text = newText;
            }
        }
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(textViewDidChangeSelection:)]) {
        
        [self.delegate textViewDidChangeSelection:textView];
    }
}


#pragma mark  ----  自定义函数
-(void)insertText:(NSString *)text atIndex:(NSUInteger)index{
    
    if (text) {
     
        //去掉默认内容
        if ([self.evaTextView.text isEqualToString:self.placeholder]) {
            
            self.evaTextView.text = @"";
            self.evaTextView.textColor = self.textColor;
        }
        
        NSString * content = self.evaTextView.text;
        NSMutableString * tempContent = [[NSMutableString alloc] initWithString:content];
        if (content.length >= index) {
            
            [tempContent insertString:text atIndex:index];
        }
        else{
            
            [tempContent insertString:text atIndex:0];
        }
        self.evaTextView.text = tempContent;
        self.evaTextView.selectedRange = NSMakeRange(index + text.length, 0);
    }
}

//去除emoji
- (NSString *)stringContainsEmoji:(NSString *)string {
    
    __block NSString *change = string;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                const unichar high = [substring characterAtIndex: 0];
                                
                                // Surrogate pair (U+1D000-1F9FF)
                                if (0xD800 <= high && high <= 0xDBFF) {
                                    const unichar low = [substring characterAtIndex: 1];
                                    const int codepoint = ((high - 0xD800) * 0x400) + (low - 0xDC00) + 0x10000;
                                    
                                    if (0x1D000 <= codepoint && codepoint <= 0x1F9FF){
                                        change = [change stringByReplacingOccurrencesOfString:substring withString:@""];
                                        //returnValue = YES;
                                    }
                                    
                                    // Not surrogate pair (U+2100-27BF)
                                } else {
                                    if (0x2100 <= high && high <= 0x27BF){
                                        change = [change stringByReplacingOccurrencesOfString:substring withString:@""];
                                        //returnValue = YES;
          }
        }
    }];
    return change;
}

- (BOOL)becomeFirstResponder{
    
    return [self.evaTextView becomeFirstResponder];
}

@end
