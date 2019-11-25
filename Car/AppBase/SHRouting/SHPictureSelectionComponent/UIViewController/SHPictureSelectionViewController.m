//
//  SHUIImagePickerViewController.m
//  SHPictureSelectionController
//
//  Created by xianjunwang on 2017/10/24.
//  Copyright © 2017年 xianjunwang. All rights reserved.
//

#import "SHPictureSelectionViewController.h"
#import "SHPictureSelectionController.h"
#import "SHImageCollectionViewCell.h"
#import "SHVideoCollectionViewCell.h"
#import "SHAssetBaseModel.h"
#import "SHAssetImageModel.h"
#import "SHAssetVideoModel.h"
#import <objc/message.h>
#import <Photos/Photos.h>
#import <AVKit/AVKit.h>
#import "SHRoutingComponent.h"


#define CELLSELECTBTNBASETAG  1010


@interface SHPictureSelectionViewController ()<UICollectionViewDelegate, UICollectionViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
//自定义导航条
@property (nonatomic,strong) UIView * shNavigationBar;
//返回按钮
@property (nonatomic,strong) UIButton * backBtn;
//标题label
@property (nonatomic,strong) UILabel * titleLabel;
//完成按钮
@property (nonatomic,strong) UIButton * finishBtn;
@property (nonatomic,retain) UICollectionView *collectionView;
//存储模型的数组
@property (nonatomic,strong) NSMutableArray<SHAssetImageModel *> * dataArray;
//存储选中的模型的数组
@property (nonatomic,strong) NSMutableArray<SHAssetBaseModel *> * selectedModelArray;
//视频播放器
@property (nonatomic,strong) AVPlayerViewController * playerVC;

@end

@implementation SHPictureSelectionViewController

#pragma mark  ----  懒加载



-(UIButton *)finishBtn{
    
    if (!_finishBtn) {
        
        _finishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _finishBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [_finishBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_finishBtn setTitle:@"完成" forState:UIControlStateNormal];
        [_finishBtn addTarget:self action:@selector(finishBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _finishBtn;
}

-(UICollectionView *)collectionView{
    
    if (!_collectionView) {
        
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 4.0;
        layout.minimumInteritemSpacing = 4.0;
        _collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView setDataSource:self];
        [_collectionView setDelegate:self];
        
        [_collectionView registerClass:[SHImageCollectionViewCell class] forCellWithReuseIdentifier:@"SHImageCollectionViewCell"];
        [_collectionView registerClass:[SHVideoCollectionViewCell class] forCellWithReuseIdentifier:@"SHVideoCollectionViewCell"];
    }
    return _collectionView;
}

-(NSMutableArray *)dataArray{
    
    if (!_dataArray) {
        
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

-(NSMutableArray<SHAssetBaseModel *> *)selectedModelArray{
    
    if (!_selectedModelArray) {
        
        _selectedModelArray = [[NSMutableArray alloc] init];
    }
    return _selectedModelArray;
}

#pragma mark  ----  生命周期函数

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self drawUI];
    dispatch_async(dispatch_get_main_queue(), ^{
       
        __weak typeof(self) weakSelf = self;
        [[SHPictureSelectionController sharedManager] loadAllPhoto:^(NSMutableArray *arr) {
            
            [weakSelf.dataArray addObjectsFromArray:arr];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [weakSelf.collectionView reloadData];
            });
        }];
    });
}

-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    //使用自定义导航条
    self.navigationController.navigationBarHidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    
//    NSLog(@"SHPictureSelectionViewController销毁");
    [[SHPictureSelectionController sharedManager] clearMemary];
    [SHPictureSelectionController sharedManager].configurationModel = nil;
}

#pragma mark  ----  代理

#pragma mark  ----  UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row == 0) {
        
        if ([SHPictureSelectionController sharedManager].configurationModel.canSelectImageCount > 0) {
            
            if (self.selectedModelArray.count > 0) {
                
                //选了照片就不能再去拍照
                [MBProgressHUD wj_showError:@"选择照片和拍摄不能同时使用!"];
                return;
            }
        }
        else{
            
            NSString * str;
            if ([SHPictureSelectionController sharedManager].configurationModel.sourceType == SourceImage) {
                
                str = @"已达到最大照片选择数";
            }
            else{
                
                str = @"已达到最大视频选择数";
            }
            [MBProgressHUD wj_showError:str];
        }
    }
    else{
        
        SHAssetBaseModel * model = [self.dataArray objectAtIndex:indexPath.row];
        if ([model isMemberOfClass:[SHAssetVideoModel class]]) {
            
            SHAssetVideoModel * videoModel = (SHAssetVideoModel *)model;
            //播放视频
            if (!self.playerVC) {
                
                self.playerVC = [[AVPlayerViewController alloc] init];
                self.playerVC.player = [AVPlayer playerWithURL:videoModel.videoUrl];
                self.playerVC.view.frame = CGRectMake(0, 0, MAINWIDTH, MAINHEIGHT);
                self.playerVC.showsPlaybackControls = YES;
            }else{
                
                self.playerVC.player = [AVPlayer playerWithURL:videoModel.videoUrl];
            }
            
            self.playerVC.modalPresentationStyle = UIModalPresentationFullScreen;
            [self presentViewController:self.playerVC animated:YES completion:^{
                
            }];
            [self.playerVC.player play];
            
        }
        else if ([model isMemberOfClass:[SHAssetImageModel class]]){
            
            //大图浏览
            NSUInteger index = indexPath.row - 1;
            NSMutableArray * imageModelDataArray = [[NSMutableArray alloc] initWithArray:self.dataArray];
            [imageModelDataArray removeObjectAtIndex:0];
            [SHRoutingComponent openURL:BIGPICTUREBROWSING withParameter:@{@"dataArray":imageModelDataArray,@"selectedIndex":[NSNumber numberWithInteger:index]}];
        }
    }
}
#pragma mark  ----  UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    SHAssetImageModel * model = [self.dataArray objectAtIndex:indexPath.row];
    if ([model isMemberOfClass:[SHAssetImageModel class]]) {
        
        //图片资源
        SHImageCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"SHImageCollectionViewCell" forIndexPath:indexPath];
        
        if (indexPath.row == 0) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
               
                cell.imageView.image = nil;
                cell.imageView.image = model.thumbnails;
            });
            cell.selectBtn.hidden = YES;
        }
        else{
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                cell.imageView.image = nil;
                cell.imageView.image = model.thumbnails;
            });
            cell.selectBtn.hidden = NO;
            [cell.selectBtn setSelected:model.selected];
            cell.selectBtn.tag = CELLSELECTBTNBASETAG + indexPath.row;
            [cell.selectBtn addTarget:self action:@selector(selectBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        }
        return cell;
    }
    else if([model isMemberOfClass:[SHAssetVideoModel class]]){
        
        //视频资源
        SHVideoCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"SHVideoCollectionViewCell" forIndexPath:indexPath];
        cell.imageView.image = model.thumbnails;
        cell.selectBtn.hidden = NO;
        [cell.selectBtn setSelected:model.selected];
        cell.selectBtn.tag = CELLSELECTBTNBASETAG + indexPath.row;
        [cell.selectBtn addTarget:self action:@selector(selectBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    return nil;
}

#pragma mark  ----  UICollectionViewDelegateFlowLayout

//返回每个item的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat width = (MAINWIDTH - 6.0 * 4)/3.0;
    return CGSizeMake(width, width);
}

//返回上左下右四边的距离
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(6, 6, 0, 6);
}

//返回cell之间的最小行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 6;
}

//cell之间的最小列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return 6;
}

#pragma mark  ----  UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
     [self finishedTakeImage:image];
}

- (void)finishedTakeImage:(UIImage *)image{
    if (image) {
        
        NSMutableArray * selectedImageArray = [[NSMutableArray alloc] init];
        
        __weak typeof(self) wkself = self;
        [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
            
            [PHAssetCreationRequest creationRequestForAssetFromImage:image];
            
        } completionHandler:^(BOOL success, NSError * _Nullable error) {
            
            if (success) {
                
                [[SHPictureSelectionController sharedManager] loadAllPhoto:^(NSMutableArray<SHAssetBaseModel *> *arr) {
                    
                    if (arr.count > 0) {
                        
                        //第一个是默认的照相机项
                        if (arr.count > 1) {
                            
                            SHAssetBaseModel * model = arr[1];
                            [selectedImageArray addObject:model];
                            [wkself backBtnClicked:nil];
                            if (wkself.block) {
                                
                                wkself.block(selectedImageArray);
                            }
                            else if (wkself.delegate){
                                
                                [wkself.delegate finiSHSelectedWithArray:selectedImageArray];
                            }
                        }
                    }
                }];
            }
            else{
                
                NSLog(@"image转PHAsset失败，%@",error);
            }
        }];
    }
}
#pragma mark  ----  自定义函数

-(void)drawUI{
    
    [self.navigationbar addSubview:self.finishBtn];
    [self.finishBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.width.height.offset(44);
        make.bottom.offset(0);
        make.right.offset(0);
    }];
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.bottom.offset(0);
        make.top.equalTo(self.navigationbar.mas_bottom).offset(0);
    }];
}

//完成按钮的响应
-(void)finishBtnClicked:(UIButton *)finishBtn{

    NSMutableArray * selectedImageArray = [[NSMutableArray alloc] initWithArray:self.selectedModelArray];
    [self.selectedModelArray removeAllObjects];
    [self backBtnClicked:nil];
    if (self.block) {
        
        self.block(selectedImageArray);
    }else if (self.delegate){
        
        [self.delegate finiSHSelectedWithArray:selectedImageArray];
    }
    
    [self.dataArray removeAllObjects];
    [self.selectedModelArray removeAllObjects];
    self.playerVC  = nil;
}

//cell的选择按钮被点击
-(void)selectBtnClicked:(UIButton *)btn{
    
    if (!btn.selected) {
        
        if ([SHPictureSelectionController sharedManager].configurationModel.canSelectImageCount > 0) {
         
            btn.selected = !btn.selected;
            SHAssetBaseModel * model = self.dataArray[btn.tag - CELLSELECTBTNBASETAG];
            model.selected = btn.selected;
            [SHPictureSelectionController sharedManager].configurationModel.canSelectImageCount--;
            [self.selectedModelArray addObject:model];
        }
        else{
        
            NSString * str;
            if ([SHPictureSelectionController sharedManager].configurationModel.sourceType == SourceImage) {
                
                str = @"已达到最大照片选择数";
            }
            else{
                
                str = @"已达到最大视频选择数";
            }
            [MBProgressHUD wj_showError:str];
        }
    }
    else{
    
        btn.selected = !btn.selected;
        SHAssetBaseModel * model = self.dataArray[btn.tag - CELLSELECTBTNBASETAG];
        model.selected = btn.selected;
        [SHPictureSelectionController sharedManager].configurationModel.canSelectImageCount++;
        [self.selectedModelArray removeObject:model];
    }
}

@end
