//
//  MrHeader.h
//  Car
//
//  Created by mac on 2019/12/17.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#ifndef MrHeader_h
#define MrHeader_h

#define CategoryUrl  [[NSString alloc] initWithFormat:@"%@/api/Shop/getCarLogos",CARDOMAIN]

#define CategoryShopUrl  [[NSString alloc] initWithFormat:@"%@/api/Shop/getAgentShopParts",CARDOMAIN]
#define CategoryShopDetail  [[NSString alloc] initWithFormat:@"%@/api/Shop/getShopParts",CARDOMAIN]

//post 方法 参数user_id  和car_logo_id
#import <TUIKit.h>
#import <FTIndicator.h>
#import "GenerateTestUserSig.h"
#import "InterfaceStatusModel.h"
#import "CarChatFuntion.h"
#import "CarChatVC.h"
#import "TUIMessageCell+MrChatCell.h"
#import "UIView+THDXib.h"
#endif /* MrHeader_h */
