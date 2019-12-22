//
//  MrCategoryListVC.m
//  Car
//
//  Created by mac on 2019/12/17.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "MrCategoryListVC.h"
#import "CarCategoryColCell.h"
#import "DSCollectionViewIndex.h"
#import "UserInforController.h"
#import "CarCategoryModel.h"
#import "SHNetworkRequestMiddleware.h"
#import "SHNetworkComponent.h"
#import "MrCarShopListVC.h"
#import "UIView+BlockGesture.h"
@interface MrCategoryListVC ()<UICollectionViewDelegate,UICollectionViewDataSource,DSCollectionViewIndexDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSInteger currentIndex;
    DSCollectionViewIndex *_collectionViewIndex;   //右边索引条
    UILabel  *_flotageLabel;     //中间显示的背景框
}
@property(nonatomic,strong)UICollectionView* mainCollectView;
@property(nonatomic,strong)NSMutableArray* datas;
@property(nonatomic,strong)NSMutableArray* headerDatas;
@property (nonatomic, strong) NSMutableArray *sectionTitleArr;
@property (nonatomic, strong) NSMutableArray *sectionArr;


@property (nonatomic,strong) UITableView * baseTable;
@end

@implementation MrCategoryListVC

#pragma mark delegate
#pragma mark delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.sectionTitleArr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *CellID = @"CellID111";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    for (UIView* view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    float www=(Screen_Width-20)/4;
    NSArray* arr=[self.sectionArr objectAtIndex:indexPath.section];
    for (int i=0; i<arr.count; i++) {
        UIView* _topView=[UIView new];
        _topView.frame=CGRectMake(www*(i%4), 95*(i/4), www, 80);
        [cell.contentView addSubview:_topView];
        
        UIImageView* _headIV=[UIImageView new];
        [_headIV sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:nil];
        _headIV.frame=CGRectMake(10, 10, www-20, 50);
        _headIV.contentMode=UIViewContentModeScaleAspectFit;
        [_topView addSubview:_headIV];
        
        UILabel* _nameLab=[UILabel new];
        _nameLab.frame=CGRectMake(0, 60, www, 20);
        _nameLab.font=[UIFont systemFontOfSize:13];
        _nameLab.textAlignment=NSTextAlignmentCenter;
        _nameLab.textColor=[UIColor grayColor];
        [_topView addSubview:_nameLab];
        CarCategoryModel* model=arr[i];
        [_headIV sd_setImageWithURL:[NSURL URLWithString:model.logo]];
        _nameLab.text=model.name;
        [_topView addTapGestureRecognizerWithDelegate:self Block:^(NSInteger tag) {
            MrCarShopListVC* vc=[[MrCarShopListVC alloc] init];
            vc.passModel=model;
            vc.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:vc animated:YES];
        }];
        
    }

    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray* arr=self.sectionArr[indexPath.section];
    //CGSizeMake((Screen_Width-20)/4, 80);
    if (arr.count%4==0) {
        return arr.count/4*95;
    }
    return (arr.count/4+1)*95;
}
//- (nullable NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
//    return self.sectionTitleArr;
//}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView* view=[UIView new];
    view.backgroundColor=RGB(240, 240, 240);;
    UILabel* _nameLab=[UILabel new];
    _nameLab.frame=CGRectMake(15, 0, 200, 40);
    
    _nameLab.textAlignment=NSTextAlignmentLeft;
    _nameLab.textColor=[UIColor blackColor];
    [view addSubview:_nameLab];
    if (section==0) {
        _nameLab.text=@"单项专营";
    }else{
        _nameLab.text=[self.sectionTitleArr objectAtIndex:section];
    }
    

    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return .001f;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView* view=[UIView new];
    return nil;
}
//-------------------------------------------------------------------------------------------------------
#pragma mark getter and setter
-(UITableView *)baseTable
{
    if (!_baseTable) {
        
        _baseTable = [[UITableView alloc]initWithFrame:CGRectMake(0, [SHUIScreenControl navigationBarHeight], Screen_Width-20, self.view.frame.size.height-[SHUIScreenControl navigationBarHeight]) style:UITableViewStylePlain];
        _baseTable.delegate = self;
        _baseTable.dataSource = self;
        _baseTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        _baseTable.showsVerticalScrollIndicator=NO;
        _baseTable.showsHorizontalScrollIndicator=NO;
        
        
    }
    return _baseTable;
}






-(NSMutableArray *)sectionTitleArr
{
    if (!_sectionTitleArr) {
        _sectionTitleArr=[NSMutableArray new];
    }
    return _sectionTitleArr;
}
-(NSMutableArray *)sectionArr
{
    if (!_sectionArr) {
        _sectionArr=[NSMutableArray new];
    }
    return _sectionArr;
}
-(NSMutableArray *)datas{
    if (!_datas) {
        _datas=[NSMutableArray new];
    }
    return _datas;
}
-(NSMutableArray *)headerDatas{
    if (!_headerDatas) {
        _headerDatas=[NSMutableArray new];
    }
    return _headerDatas;
}
#pragma mark 索引条
#pragma mark- 索引条代理DSCollectionViewIndexDelegate

-(void)collectionViewIndex:(DSCollectionViewIndex *)collectionViewIndex didselectionAtIndex:(NSInteger)index withTitle:(NSString *)title{
    NSInteger tempInt = 0;
    NSArray *array = [NSArray array];
    for (int i=0; i<index ; i++) {    //根据循环rows数组得到需要滑动到的位置
        array = self.sectionArr[i];
        tempInt = tempInt + array.count;
    }
   // [_mainCollectView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:index] atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
    [_baseTable scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:index] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
    _flotageLabel.text = title;
    
//    UICollectionViewLayoutAttributes *attributes = [_mainCollectView layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:index]];
//    CGRect rect = attributes.frame;
//    [_mainCollectView setContentOffset:CGPointMake(_mainCollectView.frame.origin.x, rect.origin.y-40) animated:YES];


}

-(void)collectionViewIndexTouchesBegan:(DSCollectionViewIndex *)collectionViewIndex{
    _flotageLabel.alpha = 1;
    _flotageLabel.hidden = NO;
}

-(void)collectionViewIndexTouchesEnd:(DSCollectionViewIndex *)collectionViewIndex{
    void (^animation)() = ^{
        _flotageLabel.alpha = 0;
    };
    
    [UIView animateWithDuration:0.4 animations:animation completion:^(BOOL finished) {
        _flotageLabel.hidden = YES;
    }];
}

- (void)createCollectionViewIndex{
    _collectionViewIndex = [[DSCollectionViewIndex alloc] initWithFrame:CGRectMake(Screen_Width-20, [SHUIScreenControl navigationBarHeight]+20, 20, Screen_Height-[SHUIScreenControl navigationBarHeight]-40)];    //创建索引条
    _collectionViewIndex.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:_collectionViewIndex];   //添加到视图上

    _collectionViewIndex.titleIndexes = self.sectionTitleArr;   //设置数组
//    CGRect rect = _collectionViewIndex.frame;
//    rect.size.height = _collectionViewIndex.titleIndexes.count * 16;
//    rect.origin.y = 0;
//    _collectionViewIndex.frame = rect;
    _collectionViewIndex.isFrameLayer = NO;    //是否有边框线
    _collectionViewIndex.collectionDelegate = self;
    
    
    //中间显示的背景框
    _flotageLabel = [[UILabel alloc] initWithFrame:(CGRect){(Screen_Width - 64 ) / 2,(Screen_Height - 64) / 2,64,64}];
    CGRect flotageRect = _flotageLabel.frame;
    flotageRect.origin.y = (Screen_Height - flotageRect.size.height) / 2;
    _flotageLabel.frame = flotageRect;
    _flotageLabel.backgroundColor = RGBA(150, 150, 150, 0.7);
    _flotageLabel.hidden = YES;
    _flotageLabel.textAlignment = NSTextAlignmentCenter;
    _flotageLabel.textColor = [UIColor whiteColor];
    _flotageLabel.font=[UIFont boldSystemFontOfSize:25];
    _flotageLabel.layer.masksToBounds=YES;
    _flotageLabel.layer.cornerRadius=5;
    [self.view addSubview:_flotageLabel];
    
}
- (void)requestData{
    
    __weak typeof(self) weakSelf = self;
    [FTIndicator showProgressWithMessage:@""];
    NSDictionary * bodyParameters = @{@"user_id":[UserInforController sharedManager].userInforModel.userID};
    [[CarChatFuntion shareInterface] requetInterface:CategoryUrl withParameter:bodyParameters.mutableCopy handler:^(NSDictionary * _Nonnull info, InterfaceStatusModel * _Nonnull infoModel) {
        NSLog(@"-----%@",info);
        if ([[info objectForKey:@"code"] integerValue]==1) {
            [FTIndicator dismissProgress];
            NSDictionary* dataDic=[info objectForKey:@"data"];
            NSArray* topArr=[dataDic objectForKey:@"header"];
            NSArray* listData=[dataDic objectForKey:@"list"];
            for (NSDictionary* dci in topArr) {
                CarCategoryModel * model = [CarCategoryModel mj_objectWithKeyValues:dci];
                [weakSelf.headerDatas addObject:model];
            }
            for (NSDictionary* dci in listData) {
                CarCategoryModel * model = [CarCategoryModel mj_objectWithKeyValues:dci];
                [weakSelf.datas addObject:model];
            }
            
            [weakSelf setUpTableSection];
            
        }else{
            [FTIndicator showErrorWithMessage:[info objectForKey:@"msg"]];
        }
    }];;
    
}
-(void)setUpTableSection{
    
    [self.sectionArr removeAllObjects];
    [self.sectionTitleArr removeAllObjects];
    UILocalizedIndexedCollation *collation = [UILocalizedIndexedCollation currentCollation];
    //create a temp sectionArray
    NSUInteger numberOfSections = [[collation sectionTitles] count];
    NSMutableArray *newSectionArray = [[NSMutableArray alloc]init];
    for (NSUInteger index = 0; index <numberOfSections; index++) {
        [newSectionArray addObject:[[NSMutableArray alloc]init]];
    }
    
    for (CarCategoryModel *item in self.datas) {
        NSUInteger sectionIndex;
        sectionIndex = [collation sectionForObject:item collationStringSelector:@selector(initial)];  //备注名
        [newSectionArray[sectionIndex] addObject:item];
    }
    //sort the person of each section
    for (NSUInteger index=0; index < numberOfSections; index++) {
        NSMutableArray *personsForSection = newSectionArray[index];
        NSArray *sortedPersonsForSection = [collation sortedArrayFromArray:personsForSection collationStringSelector:@selector(initial)];
        newSectionArray[index] = sortedPersonsForSection;
    }
    
    NSMutableArray *temp = [NSMutableArray new];
    [newSectionArray enumerateObjectsUsingBlock:^(NSArray *arr, NSUInteger idx, BOOL *stop) {
        if (arr.count == 0) {
            [temp addObject:arr];
        } else {
            [self.sectionTitleArr addObject:[collation sectionTitles][idx]];
        }
    }];
    [newSectionArray removeObjectsInArray:temp];

    [newSectionArray insertObject:self.headerDatas atIndex:0];
    [self.sectionTitleArr insertObject:@"单" atIndex:0];
    
    
    self.sectionArr=newSectionArray;
    [self createCollectionViewIndex];
    [self.baseTable reloadData];
    // self.nFriends = newSectionArray;
}
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}
-(void)leftBarButtonItemTap{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"选择配件类别";
    self.extendedLayoutIncludesOpaqueBars = YES;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonItemTap)];
    self.view.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.baseTable];
    [self requestData];
   
    
    // Do any additional setup after loading the view.
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.sectionTitleArr.count;;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.sectionArr[section] count];;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake((Screen_Width-20)/4, 80);
}
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
//    return 12.0;
//}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CarCategoryColCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CarCategoryColCell" forIndexPath:indexPath];
    cell.backgroundColor=[UIColor whiteColor];
    CarCategoryModel* model=self.sectionArr[indexPath.section][indexPath.row];
    [cell.markIV sd_setImageWithURL:[NSURL URLWithString:model.logo]];
    cell.nameLab.text=model.name;
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(Screen_Width-20, 40);
}
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
//    return CGSizeMake(SCREEN_WIDTH, 10);
//}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (kind == UICollectionElementKindSectionHeader) {
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"PhotoheaderView" forIndexPath:indexPath];
       // [headerView removeAllSubviews];
        for (UIView* vieww in headerView.subviews) {
            [vieww removeFromSuperview];
        }
        headerView.backgroundColor=RGB(240, 240, 240);
        if (!headerView.subviews.count) {

            UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 180, 40)];
            
            if (indexPath.section==0) {
                titleLabel.text =@"单项专营";
            }else{
            
                titleLabel.text = [self.sectionTitleArr objectAtIndex:indexPath.section];
            }
            titleLabel.textColor = [UIColor blackColor];
            titleLabel.font =[UIFont systemFontOfSize:15];
            [headerView addSubview:titleLabel];
        }
        return headerView;
    }else {
        return nil;
    }
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    CarCategoryModel* model=self.sectionArr[indexPath.section][indexPath.row];

    MrCarShopListVC* vc=[[MrCarShopListVC alloc] init];
    vc.passModel=model;
    vc.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:vc animated:YES];
}
//-------------------------------------------------------------------------------------------------------
#pragma mark getter and setter

-(UICollectionView *)mainCollectView{
    if (!_mainCollectView) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumInteritemSpacing = 0;
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
        _mainCollectView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width-20, Screen_Height) collectionViewLayout:layout];
        _mainCollectView.showsVerticalScrollIndicator = NO;
        _mainCollectView.showsHorizontalScrollIndicator = NO;
        _mainCollectView.delegate = self;
        _mainCollectView.dataSource = self;
        _mainCollectView.bounces = true;
        _mainCollectView.backgroundColor = [UIColor whiteColor];
        
        [_mainCollectView registerNib:[UINib nibWithNibName:@"CarCategoryColCell" bundle:nil] forCellWithReuseIdentifier:@"CarCategoryColCell"];
//        _mainCollectView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//           // [selfp reloadData];
//        }];
        [_mainCollectView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"PhotoheaderView"];
    }
    return _mainCollectView;
}

@end
