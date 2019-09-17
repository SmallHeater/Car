//
//  ImageCompressionController.h
//  JHLivePlayDemo
//
//  Created by xianjunwang on 2017/9/27.
//  图片压缩控制器

#import <Foundation/Foundation.h>

@interface ImageCompressionController : NSObject
//传入图片大小（内存）和压缩后的大小要求，返回压缩系数,imageLength和expectLength的单位都是KB
+(float)getCompressionFactorWithLength:(float)imageLength andExpextLength:(float)expectLength;
@end
