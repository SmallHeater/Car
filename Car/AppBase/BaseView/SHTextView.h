//
//  JHTextView.h
//  JHLivePlayLibrary
//
//  Created by xianjunwang on 2018/4/21.
//  带placehold的textView

#import <UIKit/UIKit.h>

typedef void(^ReturnBlock)(NSString * _Nullable str);

@protocol SHTextViewDelegate<NSObject>

-(BOOL)textView:(UITextView *_Nullable)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text;
- (BOOL)textViewShouldBeginEditing:(UITextView *_Nullable)textView;
- (BOOL)textViewShouldEndEditing:(UITextView *_Nullable)textView;
- (void)textViewDidEndEditing:(UITextView *_Nullable)textView;
- (void)textViewDidChangeSelection:(UITextView *_Nullable)textView;
@end

@interface SHTextView : UIView

@property(nonatomic,copy) NSString * _Nullable text;
@property (nonatomic,strong) NSAttributedString * _Nullable attributedStr;
@property(nonatomic,strong) UIColor * _Nullable textColor;
//默认placeHold
@property (nonatomic,strong) NSString * _Nullable placeholder;
@property (nonatomic,strong) UIColor * _Nullable placeholderColor;
//最大字数
@property (nonatomic,assign) NSUInteger maxCount;
//输入完成的回调
@property (nonatomic,copy) ReturnBlock _Nullable block;
@property(nonatomic,weak) id<SHTextViewDelegate> _Nullable delegate;

@property (nonatomic, copy) UITextRange * _Nullable selectedTextRange;
@property(nonatomic) NSRange selectedRange;

@property (nullable, readwrite, strong) UIView *inputAccessoryView;

@property (nonatomic,strong) UIFont * _Nullable textFont;

@property(nonatomic,assign) UIReturnKeyType returnKeyType;

//是否支持点击键盘右下角按钮换行(默认是NO)
@property (nonatomic,assign) BOOL canWrap;



- (instancetype _Nullable )init;

- (BOOL)becomeFirstResponder;

//插入文字
-(void)insertText:(NSString *_Nullable)text atIndex:(NSUInteger)index;

@end

