//
//  ItemsCell.m
//  Car
//
//  Created by xianjun wang on 2019/9/17.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "ItemsCell.h"
#import "SHImageAndTitleBtn.h"
#import "SHPageControl.h"


#define BASEBTNTAG 1800

@interface ItemsCell ()

@property (nonatomic,strong) UIScrollView * bgScrollView;
@property (nonatomic,strong) SHPageControl * pageControl;


@end

@implementation ItemsCell

#pragma mark  ----  懒加载

-(UIScrollView *)bgScrollView{
    
    if (!_bgScrollView) {
        
        _bgScrollView = [[UIScrollView alloc] init];
    }
    return _bgScrollView;
}

-(SHPageControl *)pageControl{
    
    if (!_pageControl) {
        
        _pageControl = [[SHPageControl alloc] init];
        _pageControl.currentPage = 0;
        _pageControl.currentImageSize = CGSizeMake(14, 3);
        _pageControl.currentImage = [UIImage imageNamed:@"pageIconSelected"];
        _pageControl.inactiveImageSize = CGSizeMake(14, 3);
        _pageControl.inactiveImage = [UIImage imageNamed:@"pageIconNormal"];
        _pageControl.numberOfPages = 1;
    }
    return _pageControl;
}

#pragma mark  ----  生命周期函数

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        [self drawUI];
        [self creatItems];
    }
    return self;
}

#pragma mark  ----  自定义函数

-(void)drawUI{
    
    [self addSubview:self.bgScrollView];
    [self.bgScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.top.bottom.offset(0);
    }];
    
    [self addSubview:self.pageControl];
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.mas_centerX);
        make.width.offset(18);
        make.bottom.offset(-14);
        make.height.offset(3);
    }];
}

-(void)creatItems{
    
    float itemX = 15;
    float itemY = 0;
    float itemWidth = 60;
    float itemHeight = 60;
    float itemInterval = (MAINWIDTH - 15 * 2 - itemWidth * 5) / 4.0;
    float itemImageWidthHeight = 35;
    float itemImageX = (itemWidth - itemImageWidthHeight) / 2.0;
    float itemTitleHeight = 12;
    float itemTitleY = itemHeight - itemTitleHeight;
    for (NSUInteger i = 0; i < 10; i++) {
        
        SHImageAndTitleBtn * btn = [[SHImageAndTitleBtn alloc] initWithFrame:CGRectMake(itemX, itemY, itemWidth, itemHeight) andImageFrame:CGRectMake(itemImageX, 0, itemImageWidthHeight, itemImageWidthHeight) andTitleFrame:CGRectMake(0, itemTitleY, itemWidth, itemTitleHeight) andImageName:@"repairShop" andSelectedImageName:@"" andTitle:[[NSString alloc] initWithFormat:@"机油 %ld",i] andTarget:self andAction:@selector(itemClicked:)];
        btn.tag = BASEBTNTAG + i;
        [self.bgScrollView addSubview:btn];
        
        if (i == 4) {
            
            itemX = 15;
            itemY = itemHeight + 20;
        }
        else{
            
            itemX += itemWidth + itemInterval;
        }
    }
}

//item项的点击响应
-(void)itemClicked:(SHImageAndTitleBtn *)btn{
    
    NSLog(@"%ld",btn.tag);
}


@end
