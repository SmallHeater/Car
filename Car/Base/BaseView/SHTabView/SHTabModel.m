//
//  SHTabModel.m
//  Car
//
//  Created by xianjun wang on 2019/9/18.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "SHTabModel.h"

@implementation SHTabModel

-(float)btnMaxWidth{
    
    float width = [self.tabTitle widthWithFont:self.selectedFont?self.selectedFont:self.normalFont andHeight:30] + 10;
    return width;
}

@end
