//
//  MaintenanceLogCell.h
//  Car
//
//  Created by xianjun wang on 2019/8/28.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  维修日志cell

NS_ASSUME_NONNULL_BEGIN

typedef void(^CallBack)(float value);
typedef void(^CallBackStr)(NSString * content);

typedef NS_ENUM(NSUInteger,CellState){
    
    CellState_Show = 0,//展示状态
    CellState_Edit //编辑状态
};

@interface MaintenanceLogCell : SHBaseTableViewCell

//维修日期回调
@property (nonatomic,copy) CallBackStr repairDateCallBack;
//公里数回调
@property (nonatomic,copy) CallBack kmCallBack;
//关联项目回调
@property (nonatomic,copy) CallBack projectCallBack;
//应收回调
@property (nonatomic,copy) CallBack acceptableCallBack;
//实收回调
@property (nonatomic,copy) CallBack receivedCallBack;
//成本回调
@property (nonatomic,copy) CallBack costCallBack;
//维修内容回调
@property (nonatomic,copy) CallBackStr contentCallBack;
//图片路径的回调
@property (nonatomic,copy) CallBackStr imageUrlCallBack;
//删除图片路径回调
@property (nonatomic,copy) CallBackStr deleteImageUrlCallBack;

+(float)cellHeightWithContent:(NSString *)content;

//repairDate,维修日期;kilometers,公里数;associatedProject,关联项目;acceptable,应收;received,实收;cost,成本;images,维修图片组合,以,分隔。
-(void)showData:(NSDictionary *)dic;

//主动开始上传图片
-(void)startUploadImages;
//设置状态
-(void)setCellState:(CellState)state;

@end

NS_ASSUME_NONNULL_END
