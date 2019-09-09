//
//  JHLivePickerView.m
//  JHLivePlayDemo
//
//  Created by xianjunwang on 2017/9/11.
//  Copyright © 2017年 pk. All rights reserved.
//

#import "SHPickerView.h"


@interface SHPickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>
//取消按钮
@property (nonatomic,strong) UIButton * cancleBtn;
//标题
@property (nonatomic,strong) UILabel * titleLabel;
//确定按钮
@property (nonatomic,strong) UIButton * sureBtn;
//底部view
@property (nonatomic,strong) UIView * pickerBGView;

@property (nonatomic,strong) UIPickerView * pickerView;

//列
@property (nonatomic,assign) NSUInteger compont;


//显示内容
@property (nonatomic,strong) NSMutableArray * showStrArray;

//第一列数据
@property (nonatomic,strong) NSMutableArray * firstCompontArray;
//第二列数据
@property (nonatomic,strong) NSMutableArray * secondCompontArray;
//第三列数据
@property (nonatomic,strong) NSMutableArray * thirdCompontArray;

@end

@implementation SHPickerView

#pragma mark  ----  生命周期函数
-(instancetype)initWithFrame:(CGRect)frame andTitle:(NSString *)title andComponent:(NSUInteger)compont andData:(id)data{

    self = [super initWithFrame:frame];
    if (self) {
        
        self.compont = compont;
        self.data = [data copy];
    
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        if (title) {
         
            self.titleLabel.text = title;
        }
        else{
        
            self.titleLabel.text = @"";
        }
        [self addSubview:self.pickerBGView];
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancleBtnClicked)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

-(void)layoutSubviews{

    [super layoutSubviews];
}

#pragma mark  ----  代理函数
#pragma mark  ----  UIPickerViewDelegate

//重写显示项
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:FONT18];
    }
    // Fill the label text here
    id value = [self pickerView:pickerView titleForRow:row forComponent:component];
    if ([value isKindOfClass:[NSString class]]) {
        
        pickerLabel.text= value;
    }
//    else if ([value isKindOfClass:[LiveTitleModel class]]){
//
//        LiveTitleModel * model = (LiveTitleModel *)value;
//        pickerLabel.text = model.Name;
//    }
    return pickerLabel;
}
// 返回pickerView的宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{

    return MAINWIDTH / self.compont;
}

// 返回pickerView的高度
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{

    return 44;
}

// 返回pickerView 每行的内容
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{

    if (self.compont == 1) {
        
        NSString * showStr = self.firstCompontArray[row][@"title"];
        return showStr;
    }
    /*
    else if (self.compont == 2) {
        
        if (component == 0) {
            
            id model = self.firstCompontArray[row];
            if ([model isKindOfClass:[JHLivePickerViewTowColumnsModel class]]) {
                
                JHLivePickerViewTowColumnsModel * model = self.firstCompontArray[row];
                return model.name;
            }
            else{
             
                return self.firstCompontArray[row][@"operateTypeName"];
            }
        }
        else if (component == 1){
            
            id model = self.secondCompontArray[row];
            if ([model isKindOfClass:[LiveTitleModel class]]) {
                
                LiveTitleModel * model = self.secondCompontArray[row];
                return model.Name;
            }
            else{
                
                return self.secondCompontArray[row][@"operateTypeName"];
            }
        }
        else{
            
            return @"";
        }
    }
     */
    else{
    
        return @"";
    }
}


// 选中行
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {

    if (self.compont == 1) {
        
        [self.showStrArray removeAllObjects];
        if (self.firstCompontArray.count > row) {
            
            [self.showStrArray addObject:self.firstCompontArray[row]];
        }
    }
    /*
    else if (self.compont == 2) {
    
        if (component == 0) {
            
            [self.secondCompontArray removeAllObjects];
            
            id model = self.firstCompontArray[row];
            if ([model isKindOfClass:[JHLivePickerViewTowColumnsModel class]]) {
                
                JHLivePickerViewTowColumnsModel * model = self.firstCompontArray[row];
                [self.secondCompontArray addObjectsFromArray:model.array];
                [pickerView reloadComponent:1];
                [pickerView selectRow:0 inComponent:1 animated:YES];
                
                [self.showStrArray removeAllObjects];
                if (self.firstCompontArray.count > row) {
                    
                    [self.showStrArray addObject:self.firstCompontArray[row]];
                    if (self.secondCompontArray.count > 0) {
                        
                        [self.showStrArray addObject:self.secondCompontArray[0]];
                    }
                }
            }
            else{
                
                [self.secondCompontArray addObjectsFromArray:self.firstCompontArray[row][@"types"]];
                [pickerView reloadComponent:1];
                
                [self.showStrArray removeAllObjects];
                if (self.firstCompontArray.count > row) {
                    
                    [self.showStrArray addObject:self.firstCompontArray[row]];
                    if (self.secondCompontArray.count > 0) {
                        
                        [self.showStrArray addObject:self.secondCompontArray[0]];
                    }
                }
            }
        }
        else{
        
            [self.showStrArray removeLastObject];
            if (self.secondCompontArray.count > row) {
                
                [self.showStrArray addObject:self.secondCompontArray[row]];
            }
        }
    }
    else if (self.compont == 3){
    
        static NSArray * secondArray;
        if (component == 0) {
            
            [self.secondCompontArray removeAllObjects];
            [self.thirdCompontArray removeAllObjects];
            
            NSString * secondCompontKey = self.firstCompontArray[row];
            secondArray = [[NSArray alloc] initWithArray:self.data[secondCompontKey]];
            
            
            for (NSUInteger i = 0; i < secondArray.count; i++) {
                
                NSDictionary * dicTwo = secondArray[i];
                [self.secondCompontArray addObjectsFromArray:dicTwo.allKeys];
            }
            
            NSDictionary * dicThree = secondArray[0];
            [self.thirdCompontArray addObjectsFromArray:dicThree.allValues[0]];
            [pickerView reloadAllComponents];
            
            [self.showStrArray removeAllObjects];
            
            
            if (self.firstCompontArray.count > row) {
                
                [self.showStrArray addObject:self.firstCompontArray[row]];
                if (self.secondCompontArray.count > 0) {
                    
                    [self.showStrArray addObject:self.secondCompontArray[0]];
                    if (self.thirdCompontArray.count > 0) {
                        
                        [self.showStrArray addObject:self.thirdCompontArray[0]];
                    }
                }
            }
        }
        else if (component == 1){
        
             [self.thirdCompontArray removeAllObjects];
            NSDictionary * dicThree = secondArray[row];
            [self.thirdCompontArray addObjectsFromArray:dicThree.allValues[0]];
            [pickerView reloadAllComponents];
            
            [self.showStrArray removeObjectsInRange:NSMakeRange(1, 2)];
            
            if (self.secondCompontArray.count > row) {
                
                [self.showStrArray addObject:self.secondCompontArray[row]];
                if (self.thirdCompontArray.count > 0) {
                    
                    [self.showStrArray addObject:self.thirdCompontArray[0]];
                }
            }
        }
        else{
        
            [self.showStrArray removeLastObject];
            if (self.thirdCompontArray.count > row) {
                
               [self.showStrArray addObject:self.thirdCompontArray[row]];
            }
        }
    }
     */
}


#pragma mark  ----  UIPickerViewDataSource
// 返回多少列
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{

    return self.compont;
}

// 返回每列的行数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{

    if (component == 0) {
        
        return self.firstCompontArray.count;
    }
    else if (component == 1){
    
        return self.secondCompontArray.count;
    }
    else if (component == 2){
    
        return self.thirdCompontArray.count;
    }
    else{
    
        return 0;
    }
}




#pragma mark  ----  自定义函数
-(void)cancleBtnClicked{

    if (self.delegate) {
        
        [self.delegate picker:self didSelectedArray:nil];
    }
    [self removeFromSuperview];
}

-(void)sureBtnClicked:(UIButton *)btn{
    
    if (self.delegate) {
        [self.delegate picker:self didSelectedArray:self.showStrArray];
    }
    [self removeFromSuperview];
}

#pragma mark  ----  SET
-(void)setData:(id)data{

    _data = data;
    
    if (data) {
        
        [self.showStrArray removeAllObjects];
        if (self.compont == 1) {
            
            [self.firstCompontArray removeAllObjects];
            [self.firstCompontArray addObjectsFromArray:data];
            if (self.firstCompontArray.count > 0) {
             
                [self.showStrArray addObject:self.firstCompontArray[0]];
            }
            [self.pickerView reloadAllComponents];
            [self.pickerView selectRow:0 inComponent:0 animated:NO];
        }
    }
        /*
        else if (self.compont == 2){
            
            if ([self.data isKindOfClass:[NSArray class]]) {
             
                NSArray * dataArray = self.data;
                [self.firstCompontArray removeAllObjects];
                [self.secondCompontArray removeAllObjects];
                [self.showStrArray removeAllObjects];
                for (NSUInteger i = 0; i < dataArray.count; i++) {
                    
                    id opera = dataArray[i];
                    if ([opera isKindOfClass:[JHLivePickerViewTowColumnsModel class]]) {
                        
                        JHLivePickerViewTowColumnsModel * model = dataArray[i];
                        [self.firstCompontArray addObject:model];
                        if (i == 0) {
                            
                            [self.showStrArray addObject:model];
                            [self.showStrArray addObject:model.array[0]];
                            [self.secondCompontArray addObjectsFromArray:model.array];
                        }
                    }
                    else{
                        
                        NSDictionary * operateDic = dataArray[i];
                        [self.firstCompontArray addObject:operateDic];
                        if (i == 0) {
                            [self.showStrArray addObject:operateDic];
                            NSArray * operateTypeTwoArray = operateDic[@"types"];
                            for (NSUInteger j = 0; j < operateTypeTwoArray.count; j++) {
                                
                                NSDictionary * operateTypeTwoDic = operateTypeTwoArray[j];
                                if (j == 0) {
                                    
                                    [self.showStrArray addObject:operateTypeTwoDic];
                                }
                                [self.secondCompontArray addObject:operateTypeTwoDic];
                            }
                        }
                    }
                }
            }
        }
        else if (self.compont == 3){
            
            NSDictionary * dic = self.data;
            [self.firstCompontArray addObjectsFromArray:dic.allKeys];
            
            NSString * secondCompontKey = self.firstCompontArray[0];
            NSArray * secondArray = dic[secondCompontKey];
            
            for (NSUInteger i = 0; i < secondArray.count; i++) {
                
                NSDictionary * dicTwo = secondArray[i];
                [self.secondCompontArray addObjectsFromArray:dicTwo.allKeys];
            }
            
            
            NSDictionary * dicThree = secondArray[0];
            [self.thirdCompontArray addObjectsFromArray:dicThree.allValues[0]];
            
            [self.showStrArray addObject:self.firstCompontArray[0]];
            [self.showStrArray addObject:self.secondCompontArray[0]];
            [self.showStrArray addObject:self.thirdCompontArray[0]];
        }
    }
    */
}

#pragma mark  ----  懒加载
-(UIButton *)cancleBtn{

    if (!_cancleBtn) {
        
        _cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancleBtn.frame = CGRectMake(12, 0, 44, 44);
        [_cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancleBtn setTitleColor:Color_999999 forState:UIControlStateNormal];
        _cancleBtn.titleLabel.font = FONT16;
        [_cancleBtn addTarget:self action:@selector(cancleBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancleBtn;
}

-(UIButton *)sureBtn{

    if (!_sureBtn) {
        
        _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _sureBtn.frame = CGRectMake(self.frame.size.width - 12 - 44, 0, 44, 44);
        [_sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        _sureBtn.titleLabel.font = FONT16;
        [_sureBtn setTitleColor:Color_87BA4B forState:UIControlStateNormal];
        [_sureBtn addTarget:self action:@selector(sureBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureBtn;
}

-(UILabel *)titleLabel{

    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.frame.size.width - 200) / 2,0, 200, 44)];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = Color_333333;
        _titleLabel.font = FONT16;
    }
    return _titleLabel;
}

-(UIView *)pickerBGView{

    if (!_pickerBGView) {
        
        _pickerBGView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 241, MAINWIDTH, 241)];
        _pickerBGView.backgroundColor = [UIColor whiteColor];
        
        [_pickerBGView addSubview:self.cancleBtn];
        [_pickerBGView addSubview:self.titleLabel];
        [_pickerBGView addSubview:self.sureBtn];
        [_pickerBGView addSubview:self.pickerView];
    }
    return _pickerBGView;
}


-(UIPickerView *)pickerView{

    if (!_pickerView) {
        
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 44, MAINWIDTH, 241 - 44)];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
    }
    return _pickerView;
}

-(NSMutableArray *)firstCompontArray{

    if (!_firstCompontArray) {
        
        _firstCompontArray = [[NSMutableArray alloc] init];
    }
    return _firstCompontArray;
}

-(NSMutableArray *)secondCompontArray{
    
    if (!_secondCompontArray) {
        
        _secondCompontArray = [[NSMutableArray alloc] init];
    }
    return _secondCompontArray;
}

-(NSMutableArray *)thirdCompontArray{
    
    if (!_thirdCompontArray) {
        
        _thirdCompontArray = [[NSMutableArray alloc] init];
    }
    return _thirdCompontArray;
}

-(NSMutableArray *)showStrArray{

    if (!_showStrArray) {
        
        _showStrArray = [[NSMutableArray alloc] init];
    }
    return _showStrArray;
}

@end
