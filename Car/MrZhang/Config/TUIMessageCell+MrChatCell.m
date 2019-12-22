//
//  TUIMessageCell+MrChatCell.m
//  Car
//
//  Created by mac on 2019/12/18.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "TUIMessageCell+MrChatCell.h"

@implementation TUIMessageCell (MrChatCell)

- (void)fillWithData:(TUIMessageCellData *)data
{
    [super fillWithData:data];
    //self.messageData = data;
    [self setValue:data forKey:@"messageData"];
    
    self.readReceiptLabel.hidden=YES;
    [self.avatarView setImage:data.avatarImage];
    @weakify(self)
    [[[RACObserve(data, avatarUrl) takeUntil:self.rac_prepareForReuseSignal] ignore:nil] subscribeNext:^(NSURL *url) {
        @strongify(self)
        [self.avatarView sd_setImageWithURL:url placeholderImage:self.messageData.avatarImage];
    }];
    
    
    if ([TUIKit sharedInstance].config.avatarType == TAvatarTypeRounded) {
        self.avatarView.layer.masksToBounds = YES;
        self.avatarView.layer.cornerRadius = data.cellLayout.avatarSize.height / 2;
    } else if ([TUIKit sharedInstance].config.avatarType == TAvatarTypeRadiusCorner) {
        self.avatarView.layer.masksToBounds = YES;
        self.avatarView.layer.cornerRadius = [TUIKit sharedInstance].config.avatarCornerRadius;
    }
    
    //set data
    self.nameLabel.text = data.name;
    self.nameLabel.textColor = data.nameColor;
    self.nameLabel.font = data.nameFont;
    
    //由于tableView的刷新策略，导致部分情况下可能会出现未读label未显示的bug。原因是因为在label显示时，内容为空。
    //label内容的变化不会引起tableView的刷新，但是hiddend状态的变化会引起tableView刷新。
    //所以未读标签选择直接赋值，而不是在发送成功时赋值。显示时机由hidden属性控制。
    self.readReceiptLabel.text = @"未读";
    //self.readReceiptLabel.text = [self getReadReceiptResult];
    
    if(data.status == Msg_Status_Fail){
        [self.indicator stopAnimating];
        self.retryView.image = [UIImage imageNamed:TUIKitResource(@"msg_error")];
       // _readReceiptLabel.hidden = YES;
    } else {
        if (data.status == Msg_Status_Sending_2) {
            [self.indicator startAnimating];
            self.readReceiptLabel.hidden = YES;
        }
        else if(data.status == Msg_Status_Succ){
            [self.indicator stopAnimating];
            //发送成功，说明 indicator 和 error 已不会显示在 label 中,可以开始显示已读回执label
            if(self.messageData.direction == MsgDirectionOutgoing
               && self.messageData.showReadReceipt
               && self.messageData.innerMessage.getConversation.getType == TIM_C2C){//只对发送的消息进行label显示。
               // _readReceiptLabel.hidden = NO;
            }
            
        }
        else if(data.status == Msg_Status_Sending){
            [self.indicator stopAnimating];
            //_readReceiptLabel.hidden = YES;
        }
        self.retryView.image = nil;
    }
}
@end
