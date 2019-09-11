//
//  JHStoreDatePickView.h
//  JHLivePlayLibrary
//
//  Created by i'm yu on 2019/7/12.
//  Copyright © 2019 pk. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SHDatePickView : UIView

+ (void)showActionSheetDateWithFormatter:(NSString *)formatter callBack:(void(^)(NSDate * date,NSString * dateStr))handle;

@end

NS_ASSUME_NONNULL_END
