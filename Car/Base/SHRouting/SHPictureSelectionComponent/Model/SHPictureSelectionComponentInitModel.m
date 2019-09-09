//
//  SHPictureSelectionComponentInitModel.m
//  SHPictureSelectionComponent
//
//  Created by xianjunwang on 2018/10/16.
//  Copyright © 2018年 xianjunwang. All rights reserved.
//

#import "SHPictureSelectionComponentInitModel.h"

@implementation SHPictureSelectionComponentInitModel


#pragma mark  ----  懒加载
-(CamareType)tkCamareType{
    
    if (!_tkCamareType) {
        
        return CamareTypeSystem;
    }
    else{
        
        return _tkCamareType;
    }
}


-(SourceType)sourceType{
    
    if (!_sourceType) {
     
        return SourceImage;
    }
    else{
        
        return _sourceType;
    }
}

@end
