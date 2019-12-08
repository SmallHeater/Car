//
//  PersonalInformationVC.m
//  Car
//
//  Created by mac on 2019/10/21.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "PersonalInformationVC.h"
#import "PersonalInformationCell.h"
#import "UserInforController.h"
#import "PTImageCropVC.h"
#import "SHBaiDuBosControl.h"

static NSString * cellId = @"PersonalInformationCell";

@interface PersonalInformationVC ()

@end

@implementation PersonalInformationVC

#pragma mark  ----  生命周期函数

- (void)viewDidLoad {
    
    [super refreshViewType:BTVCType_AddTableView];
    [super viewDidLoad];
    [self createData];
    [self drawUI];
    [self refreshViewType:BTVCType_RefreshTableView];
}

#pragma mark  ----  代理

#pragma mark  ----  UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    float cellHeight = 0;
    if (indexPath.section == 0 && indexPath.row == 0) {
        
        cellHeight = 71;
    }
    else{
        
        cellHeight = 51;
    }
    return cellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    float headerHeigh = 0;
    if (section == 1) {
        
        headerHeigh = 10;
    }
    
    return headerHeigh;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 1) {
        
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAINWIDTH, 10)];
        view.backgroundColor = Color_EEEEEE;
        return view;
    }
    else{
        
        return nil;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        
        __weak typeof(self) weakSelf = self;
        
        [SHRoutingComponent openURL:GETIMAGE withParameter:@{@"tkCamareType":[NSNumber numberWithInteger:0],@"canSelectImageCount":[NSNumber numberWithInteger:1],@"sourceType":[NSNumber numberWithInteger:0]} callBack:^(NSDictionary *resultDic) {
            
            if (resultDic && [resultDic isKindOfClass:[NSDictionary class]]) {
                
                NSArray * dataArray = resultDic[@"data"];
                if (dataArray && [dataArray isKindOfClass:[NSArray class]] && dataArray.count > 0) {
                  
                    NSDictionary * dic = dataArray[0];
                    UIImage * selectedImage;
                    if ([dic.allKeys containsObject:@"screenSizeImage"]) {
                        
                        selectedImage = dic[@"screenSizeImage"];
                    }
                    else if ([dic.allKeys containsObject:@"originalImage"]){
                        
                        selectedImage = dic[@"originalImage"];
                    }
                    
                    if (selectedImage) {
                        
                        PTImageCropVC * vc = [[PTImageCropVC alloc] initWithTitle:@"截图" andIsShowBackBtn:YES andImage:selectedImage withCropScale:1 complentBlock:^(UIImage *image) {
                            
                            if (image) {
                                
                                [[SHBaiDuBosControl sharedManager] uploadImage:image callBack:^(NSString * _Nonnull imagePath) {
                                    
                                    [weakSelf refreshAvatar:imagePath];
                                }];
                            }
                        } cancelBlock:nil];
                        [weakSelf.navigationController pushViewController:vc animated:YES];
                    }
                }
            }
        }];
    }
}

#pragma mark  ----  UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSUInteger rows = 0;
    if (section == 0) {
        
        rows = 4;
    }
    else if (section == 1){
        
        rows = 2;
    }
    return rows;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            
            PersonalInformationCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
            if (!cell) {
                
                cell = [[PersonalInformationCell alloc] initWithReuseIdentifier:cellId andCellType:CellType_Avater];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
            
            [cell show:self.dataArray[indexPath.row] andAvater:[UserInforController sharedManager].userInforModel.avatar andContent:@""];
            return cell;
        }
        else if (indexPath.row == 1){
            
            PersonalInformationCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
            if (!cell) {
                
                cell = [[PersonalInformationCell alloc] initWithReuseIdentifier:cellId andCellType:CellType_LabelAndLabel];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
            
            [cell show:self.dataArray[indexPath.row] andAvater:@"" andContent:[UserInforController sharedManager].userInforModel.shop_name];
            return cell;
        }
        else if (indexPath.row == 2){
            
            PersonalInformationCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
            if (!cell) {
                
                cell = [[PersonalInformationCell alloc] initWithReuseIdentifier:cellId andCellType:CellType_LabelAndLabel];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
            
            [cell show:self.dataArray[indexPath.row] andAvater:@"" andContent:@"已认证"];
            return cell;
        }
        else if (indexPath.row == 3){
            
            PersonalInformationCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
            if (!cell) {
                
                cell = [[PersonalInformationCell alloc] initWithReuseIdentifier:cellId andCellType:CellType_LabelAndLabelWithoutLine];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
            
            NSString * address = [[NSString alloc] initWithFormat:@"%@%@%@",[UserInforController sharedManager].userInforModel.province,[UserInforController sharedManager].userInforModel.city,[UserInforController sharedManager].userInforModel.district];
            [cell show:self.dataArray[indexPath.row] andAvater:@"" andContent:address];
            return cell;
        }
    }
    else if (indexPath.section == 1){
        
        if (indexPath.row == 0) {
            
            PersonalInformationCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
            if (!cell) {
                
                cell = [[PersonalInformationCell alloc] initWithReuseIdentifier:cellId andCellType:CellType_LabelAndLabelWithoutArrow];
            }
            
            [cell show:self.dataArray[indexPath.row + 4] andAvater:@"" andContent:[UserInforController sharedManager].userInforModel.phone];
            return cell;
        }
        else if (indexPath.row == 1){
            
            PersonalInformationCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
            if (!cell) {
                
                cell = [[PersonalInformationCell alloc] initWithReuseIdentifier:cellId andCellType:CellType_LabelAndLabelWithoutArrowLine];
            }
            
            NSDate * date = [NSDate dateWithTimeIntervalSince1970:[UserInforController sharedManager].userInforModel.createtime];
            NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd"];
            NSString * time = [formatter stringFromDate:date];
            [cell show:self.dataArray[indexPath.row + 4] andAvater:@"" andContent:time];
            return cell;
        }
    }
    
    return nil;
}
#pragma mark  ----  自定义函数

//创造数据
-(void)createData{
    
    [self.dataArray addObject:@"头像"];
    [self.dataArray addObject:@"公司"];
    [self.dataArray addObject:@"身份"];
    [self.dataArray addObject:@"地区"];
    [self.dataArray addObject:@"注册号"];
    [self.dataArray addObject:@"注册时间"];
}

-(void)drawUI{
    
    self.view.backgroundColor = Color_F3F3F3;
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.navigationbar.mas_bottom);
        make.left.right.offset(0);
        make.height.offset(329);
    }];
    self.tableView.scrollEnabled = NO;
}

//更新头像
-(void)refreshAvatar:(NSString *)avatar{
    
    //发起请求
    NSDictionary * bodyParameters = @{@"user_id":[UserInforController sharedManager].userInforModel.userID,@"avatar":[NSString repleaseNilOrNull:avatar]};
    NSDictionary * configurationDic = @{@"requestUrlStr":UpdateUserInfo,@"bodyParameters":bodyParameters};
    __weak typeof(self) weakSelf = self;
    [SHRoutingComponent openURL:REQUESTDATA withParameter:configurationDic callBack:^(NSDictionary *resultDic) {
        
        if (![resultDic.allKeys containsObject:@"error"]) {
            
            //成功的
            NSHTTPURLResponse * response = (NSHTTPURLResponse *)resultDic[@"response"];
            if (response && [response isKindOfClass:[NSHTTPURLResponse class]] && response.statusCode == 200) {
                
                [UserInforController sharedManager].userInforModel.avatar = avatar;
                NSIndexPath * indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
                [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            }
            else{
            }
        }
        else{
            
            //失败的
        }
    }];

}


@end
