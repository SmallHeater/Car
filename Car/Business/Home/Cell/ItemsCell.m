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

//项名字，数组
@property (nonatomic,strong) NSArray * itemsTitleArray;
//项图片名，数组
@property (nonatomic,strong) NSArray * itemsImageNameArray;

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

-(NSArray *)itemsTitleArray{
    
    if (!_itemsTitleArray) {
        
        //@"维修保养",@"行业信息"
        _itemsTitleArray = [[NSArray alloc] initWithObjects:@"机油采购",@"配件采购",@"营销课",@"残值交易",@"求职招聘",@"查车架号",@"查违章",@"维修资料",@"查故障",@"疑难杂症", nil];
    }
    return _itemsTitleArray;
}

-(NSArray *)itemsImageNameArray{
    
    if (!_itemsImageNameArray) {
        
        _itemsImageNameArray = [[NSArray alloc] initWithObjects:@"jiyoucaigou",@"peijiancaigou",@"yingxiaoke",@"canzhijiaoyi",@"qiuzhizhaopin",@"chachejiahao",@"chaweizhang",@"weixiuziliao",@"chaguzhang",@"yinanzazheng", nil];
    }
    return _itemsImageNameArray;
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
        make.bottom.offset(-7);
        make.height.offset(3);
    }];
}

-(void)creatItems{
    
    float itemX = 15;
    float itemY = 10;
    float itemWidth = 60;
    float itemHeight = 62;
    float itemInterval = (MAINWIDTH - 15 * 2 - itemWidth * 5) / 4.0;
    float itemImageWidthHeight = 42;
    float itemImageX = (itemWidth - itemImageWidthHeight) / 2.0;
    float itemTitleHeight = 12;
    float itemTitleY = itemHeight - itemTitleHeight;
    for (NSUInteger i = 0; i < self.itemsTitleArray.count; i++) {
        
        SHImageAndTitleBtn * btn = [[SHImageAndTitleBtn alloc] initWithFrame:CGRectMake(itemX, itemY, itemWidth, itemHeight) andImageFrame:CGRectMake(itemImageX, 0, itemImageWidthHeight, itemImageWidthHeight) andTitleFrame:CGRectMake(0, itemTitleY, itemWidth, itemTitleHeight) andImageName:self.itemsImageNameArray[i] andSelectedImageName:@"" andTitle:self.itemsTitleArray[i]];
        [btn addTarget:self action:@selector(itemClicked:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = BASEBTNTAG + i;
        [self.bgScrollView addSubview:btn];
        
        if (i == 4) {
            
            itemX = 15;
            itemY = itemY +itemHeight + 16;
        }
        else{
            
            itemX += itemWidth + itemInterval;
        }
    }
}

//item项的点击响应
-(void)itemClicked:(SHImageAndTitleBtn *)btn{
}


@end
