//
//  JHLivePickerView.h
//  JHLivePlayDemo
//
//  Created by xianjunwang on 2017/9/11.
//  带picker的view，最多支持三列,

#import <UIKit/UIKit.h>

@class SHPickerView;

@protocol SHPickerViewDelegate <NSObject>

-(void)picker:(SHPickerView *)picker didSelectedArray:(NSMutableArray *)selectDicArray;

@end
@interface SHPickerView : UIView

@property (nonatomic,weak)id<SHPickerViewDelegate>delegate;
@property (nonatomic,strong) id data;


-(instancetype)initWithFrame:(CGRect)frame andTitle:(NSString *)title andComponent:(NSUInteger)compont andData:(id)data;
@end


