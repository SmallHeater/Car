//
//  JHCameraForLicenceViewController.h
//  TestWebView
//
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^GetImageFromCamera)(UIImage * cutImage);

@interface JHCameraForLicenceViewController : UIViewController

@property (nonatomic,copy)GetImageFromCamera imageCallBack;

@end

NS_ASSUME_NONNULL_END
