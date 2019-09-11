//
//  SHBaseTableViewCell.m
//  Car
//
//  Created by xianjun wang on 2019/9/11.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "SHBaseTableViewCell.h"

@implementation SHBaseTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

@end
