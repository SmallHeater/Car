//
//  ForumDetailWebViewCell.m
//  Car
//
//  Created by mac on 2019/10/3.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "ForumDetailContentCell.h"
#import "FormDetailTextCell.h"
#import "FormDetailImgCell.h"
#import "FormDetailVideoCell.h"
#import "FormDetailUrlCell.h"


static NSString * textCellId = @"FormDetailTextCell";
static NSString * urlCellId = @"FormDetailUrlCell";
static NSString * imgCellId = @"FormDetailImgCell";
static NSString * videoCellId = @"FormDetailVideoCell";

@interface ForumDetailContentCell ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSMutableArray<ContentListItemModel *> * dataArray;
@property (nonatomic,strong) SHBaseTableView * tableView;

@end

@implementation ForumDetailContentCell

#pragma mark  ----  懒加载

-(NSMutableArray<ContentListItemModel *> *)dataArray{
    
    if (!_dataArray) {
        
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

-(SHBaseTableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[SHBaseTableView alloc] initWithFrame:CGRectMake(0,0, 0,0) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.scrollEnabled = NO;
    }
    return _tableView;
}

#pragma mark  ----  生命周期函数

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self drawUI];
    }
    return self;
}

#pragma mark  ----  代理

#pragma mark  ----  UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    float cellHeight = 0;
    ContentListItemModel * model = self.dataArray[indexPath.row];
    NSString * type = @"";
    if ([model isKindOfClass:[ContentListItemModel class]] && ![NSString strIsEmpty:model.type]) {
        
        type = model.type;
    }
    if ([type isEqualToString:@"text"]) {
        
        cellHeight = [FormDetailTextCell cellHeight:model];
    }
    else if ([type isEqualToString:@"url"]){
        
        cellHeight = [FormDetailUrlCell cellHeight:model];
    }
    else if ([type isEqualToString:@"img"] || [type isEqualToString:@"video"]){
        
        cellHeight = [FormDetailImgCell cellHeightWithModel:model];
    }
    
    return cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ContentListItemModel * model = self.dataArray[indexPath.row];
    NSString * type = @"";
    if ([model isKindOfClass:[ContentListItemModel class]] && ![NSString strIsEmpty:model.type]) {
        
        type = model.type;
    }
    
    if ([type isEqualToString:@"img"]) {
        
        [SHRoutingComponent openURL:BIGPICTUREBROWSING withParameter:@{@"dataArray":@[model.content],@"selectedIndex":[NSNumber numberWithInteger:0]}];
    }
}

#pragma mark  ----  UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ContentListItemModel * model = self.dataArray[indexPath.row];
    NSString * type = @"";
    if ([model isKindOfClass:[ContentListItemModel class]] && ![NSString strIsEmpty:model.type]) {
        
        type = model.type;
    }
    
    if ([type isEqualToString:@"text"]) {
        
        FormDetailTextCell * cell = [tableView dequeueReusableCellWithIdentifier:textCellId];
        if (!cell) {
            
            cell = [[FormDetailTextCell alloc] initWithReuseIdentifier:textCellId];
        }
        
        [cell show:model];
        
        return cell;
    }
    else if ([type isEqualToString:@"url"]){
        
        FormDetailUrlCell * cell = [tableView dequeueReusableCellWithIdentifier:urlCellId];
        if (!cell) {
            
            cell = [[FormDetailUrlCell alloc] initWithReuseIdentifier:textCellId];
        }
        
        [cell show:model];
        
        return cell;
    }
    else if ([type isEqualToString:@"img"]){
        
        FormDetailImgCell * cell = [tableView dequeueReusableCellWithIdentifier:imgCellId];
        if (!cell) {
            
            cell = [[FormDetailImgCell alloc] initWithReuseIdentifier:imgCellId];
            __weak typeof(self) weakSelf = self;
            cell.refresh = ^{
              
                [weakSelf.tableView reloadData];
                
                if (weakSelf.refreshBlock) {
                 
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        
                        weakSelf.refreshBlock();
                    });
                }
            };
        }
        
        [cell showModel:model];
        
        return cell;
    }
    else if ([type isEqualToString:@"video"]){
        
        FormDetailVideoCell * cell = [tableView dequeueReusableCellWithIdentifier:videoCellId];
        if (!cell) {
            
            cell = [[FormDetailVideoCell alloc] initWithReuseIdentifier:videoCellId];
        }
        
        [cell showUrl:model.content];
        
        return cell;
    }
    
    return nil;
}

#pragma mark  ----  自定义函数

+(float)cellHeightWithModel:(ForumArticleModel *)model{
    
    float cellHeight = 0;
    if (model && [model isKindOfClass:[ForumArticleModel class]] && model.content_list && [model.content_list isKindOfClass:[NSArray class]]) {
        
        for (ContentListItemModel * itemModel in model.content_list) {
            
            NSString * type = @"";
            if ([itemModel isKindOfClass:[ContentListItemModel class]] && ![NSString strIsEmpty:itemModel.type]) {
                
                type = itemModel.type;
            }
            if ([type isEqualToString:@"text"]) {
                
                cellHeight += [FormDetailTextCell cellHeight:itemModel];
            }
            else if ([type isEqualToString:@"img"] || [type isEqualToString:@"video"]){
                
                if (itemModel.imageHeight > 0) {
                    
                    cellHeight += itemModel.imageHeight + 10 *2;
                }
                else{
                 
                    cellHeight += 192 + 10 *2;
                }
            }
        }
    }
    return cellHeight;
}

-(void)drawUI{
    
    [self addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.top.bottom.offset(0);
    }];
}

-(void)show:(ForumArticleModel *)model{
    
    [self.dataArray removeAllObjects];
    if (model && model.content_list && [model.content_list isKindOfClass:[NSArray class]]) {
        
         [self.dataArray addObjectsFromArray:model.content_list];
    }
    [self.tableView reloadData];
}

@end
