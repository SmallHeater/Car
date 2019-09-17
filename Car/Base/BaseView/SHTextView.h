//
//  JHTextView.h
//  JHLivePlayLibrary
//
//  Created by xianjunwang on 2018/4/21.
//  带placehold的textView

#import <UIKit/UIKit.h>

typedef void(^ReturnBlock)(NSString * str);

@protocol SHTextViewDelegate<NSObject>

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text;
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView;
- (BOOL)textViewShouldEndEditing:(UITextView *)textView;
- (void)textViewDidEndEditing:(UITextView *)textView;
- (void)textViewDidChangeSelection:(UITextView *)textView;
@end

@interface SHTextView : UIView

@property(nonatomic,copy) NSString *text;
@property(nonatomic,strong) UIColor * textColor;
//默认placeHold
@property (nonatomic,strong) NSString * placeholder;
@property (nonatomic,strong) UIColor * placeholderColor;
//最大字数
@property (nonatomic,assign) NSUInteger maxCount;
//输入完成的回调
@property (nonatomic,copy) ReturnBlock block;
@property(nonatomic,weak) id<SHTextViewDelegate>delegate;

@property (nonatomic, copy) UITextRange *selectedTextRange;
@property(nonatomic) NSRange selectedRange;

@property (nullable, readwrite, strong) UIView *inputAccessoryView;

@property (nonatomic,strong) UIFont * textFont;

@property(nonatomic,assign) UIReturnKeyType returnKeyType;

//是否支持点击键盘右下角按钮换行(默认是NO)
@property (nonatomic,assign) BOOL canWrap;



- (instancetype)initWithFrame:(CGRect)frame;

- (BOOL)becomeFirstResponder;

//插入文字
-(void)insertText:(NSString *)text atIndex:(NSUInteger)index;

@end

