//
//  PushAndPlayViewController.m
//  Car
//
//  Created by mac on 2019/10/29.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "PlayViewController.h"
#import "SHImageAndTitleBtn.h"
#import "SmallVideoViewController.h"
#import "VideoPlayCell.h"

static NSString * cellId = @"VideoPlayCell";

@interface PlayViewController ()

//关闭按钮
@property (nonatomic,strong) UIButton * clostBtn;
//发布按钮
@property (nonatomic,strong) SHImageAndTitleBtn * publishBtn;
//我发布的
@property (nonatomic,strong) SHImageAndTitleBtn * myPublish;
@property (nonatomic,assign) NSUInteger index;

@end

@implementation PlayViewController

#pragma mark  ----  懒加载

-(UIButton *)clostBtn{
    
    if (!_clostBtn) {
        
        _clostBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_clostBtn setImage:[UIImage imageNamed:@"guanbibaise"] forState:UIControlStateNormal];
        _clostBtn.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
        __weak typeof(self) weakSelf = self;
        [[_clostBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
           
            [weakSelf backBtnClicked:nil];
        }];
    }
    return _clostBtn;
}

-(SHImageAndTitleBtn *)publishBtn{
    
    if (!_publishBtn) {
        
        NSUInteger btnWidth = 30;
        _publishBtn = [[SHImageAndTitleBtn alloc] initWithFrame:CGRectZero andImageFrame:CGRectMake((btnWidth - 17) / 2, 0, 17, 17) andTitleFrame:CGRectMake(0, 22, btnWidth, 12) andImageName:@"fabubaise" andSelectedImageName:@"fabubaise" andTitle:@"发布"];
        [_publishBtn refreshColor:[UIColor whiteColor]];
        //播放，发布分离
        _publishBtn.hidden = YES;
    }
    return _publishBtn;
}

-(SHImageAndTitleBtn *)myPublish{
    
    if (!_myPublish) {
        
        NSUInteger btnWidth = 60;
        _myPublish = [[SHImageAndTitleBtn alloc] initWithFrame:CGRectZero andImageFrame:CGRectMake((btnWidth - 17) / 2, 0, 17, 17) andTitleFrame:CGRectMake(0, 22, btnWidth, 12) andImageName:@"wofabude" andSelectedImageName:@"wofabude" andTitle:@"我发布的"];
        [_myPublish refreshColor:[UIColor whiteColor]];
        __weak typeof(self) weakSelf = self;
        [[_myPublish rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
           
            SmallVideoViewController * vc = [[SmallVideoViewController alloc] initWithType:VCType_MyVideos];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }];
    }
    return _myPublish;
}

#pragma mark  ----  生命周期函数

-(instancetype)initWithTitle:(NSString *)title andShowNavgationBar:(BOOL)isShowNavgationBar andIsShowBackBtn:(BOOL)isShowBackBtn andTableViewStyle:(UITableViewStyle)style andDataArray:(NSMutableArray<VideoModel *> *)dataArray andSelectIndex:(NSUInteger)index{
    
    self = [super initWithTitle:title andShowNavgationBar:isShowNavgationBar andIsShowBackBtn:isShowBackBtn andTableViewStyle:style andIsShowHead:NO andIsShowFoot:NO];
    if (self) {
        
        self.index = index;
        [self.dataArray addObjectsFromArray:dataArray];
    }
    return self;
}

- (void)viewDidLoad {
    
    [super refreshViewType:BTVCType_AddTableView];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self drawUI];
}

-(void)dealloc{
    
    NSLog(@"");
}

#pragma mark  ----  代理

#pragma mark  ----  UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    float cellHeight = MAINHEIGHT;
    return cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark  ----  UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    VideoPlayCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        
        cell = [[VideoPlayCell alloc] initWithReuseIdentifier:cellId];
        cell.backgroundColor = [UIColor greenColor];
    }
    
    VideoModel * video = self.dataArray[indexPath.row];
    [cell playVideo:video];
    return cell;
}

#pragma mark  ----  自定义函数

-(void)drawUI{
    
    self.tableView.pagingEnabled = YES;
    [self.view addSubview:self.clostBtn];
    [self.clostBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(10);
        make.top.offset(28 + [SHUIScreenControl liuHaiHeight]);
        make.width.height.offset(28);
    }];
    
    [self.view addSubview:self.myPublish];
    [self.myPublish mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.offset(27 + [SHUIScreenControl liuHaiHeight]);
        make.right.offset(-11);
        make.width.offset(60);
        make.height.offset(34);
    }];
    
    [self.view addSubview:self.publishBtn];
    [self.publishBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.myPublish.mas_top);
        make.right.equalTo(self.myPublish.mas_left).offset(-20);
        make.width.offset(30);
        make.height.equalTo(self.myPublish.mas_height);
    }];
    
    NSIndexPath * indexPath = [NSIndexPath indexPathForRow:self.index inSection:0];
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionNone animated:YES];
}

@end
