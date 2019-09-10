//
//  MaintenanceLogCell.h
//  Car
//
//  Created by xianjun wang on 2019/8/28.
//  Copyright © 2019 SmallHeat. All rights reserved.
//  维修日志cell

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^CallBack)(float value);
typedef void(^CallBackStr)(NSString * content);

@interface MaintenanceLogCell : UITableViewCell

//维修日期回调
@property (nonatomic,copy) CallBackStr repairDateCallBack;
//公里数回调
@property (nonatomic,copy) CallBack kmCallBack;
//关联项目回调
@property (nonatomic,copy) CallBack projectCallBack;
//应收回调
@property (nonatomic,strong) CallBack acceptableCallBack;
//实收回调
@property (nonatomic,strong) CallBack receivedCallBack;
//成本回调
@property (nonatomic,strong) CallBack costCallBack;
//维修内容回调
@property (nonatomic,strong) CallBackStr contentCallBack;
//图片路径的回调
@property (nonatomic,strong) CallBackStr imageUrlCallBack;

+(float)cellHeightWithContent:(NSString *)content andImageCount:(NSUInteger)imageCount;

//repairDate,维修日期;kilometers,公里数;associatedProject,关联项目;acceptable,应收;received,实收;cost,成本;images,维修图片组合,以,分隔。
-(void)showData:(NSDictionary *)dic;

//主动开始上传图片
-(void)startUploadImages;

@end

NS_ASSUME_NONNULL_END
