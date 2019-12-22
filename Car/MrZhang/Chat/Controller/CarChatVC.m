//
//  CarChatVC.m
//  Car
//
//  Created by mac on 2019/12/17.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "CarChatVC.h"
#import "MrCarShopDetailVC.h"
@interface CarChatVC ()<TUIChatControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIDocumentPickerDelegate>
@property (nonatomic, strong) TUIChatController *chat;
@end

@implementation CarChatVC
-(void)leftBarButtonItemTap{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)goDetail{
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",_conversationData.convId];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonItemTap)];
    
    
    UIButton* btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(0, 0, 25, 25);
    [btn setBackgroundImage:[UIImage imageNamed:@"phone"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(goDetail) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc] initWithCustomView:btn];
    
    TIMConversation *conv = [[TIMManager sharedInstance] getConversation:_conversationData.convType receiver:_conversationData.convId];
    _chat = [[TUIChatController alloc] initWithConversation:conv];
    _chat.delegate = self;

    
    
    [self addChildViewController:_chat];
    [self.view addSubview:_chat.view];
    
    self.navigationItem.title=_conversationData.title;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onRefreshNotification:)
                                                 name:TUIKitNotification_TIMRefreshListener
                                               object:nil];
    
    //添加未读计数的监听
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onChangeUnReadCount:)
                                                 name:TUIKitNotification_onChangeUnReadCount
                                               object:nil];
    // Do any additional setup after loading the view.
}
- (void)willMoveToParentViewController:(UIViewController *)parent
{
    if (parent == nil) {
        [_chat saveDraft];
    }
}

// 聊天窗口标题由上层维护，需要自行设置标题
- (void)onRefreshNotification:(NSNotification *)notifi
{
    
    NSArray<TIMConversation *> *convs = notifi.object;
    if ([convs isKindOfClass:[NSArray class]]) {
        for (TIMConversation *conv in convs) {
            if ([[conv getReceiver] isEqualToString:_conversationData.convId]) {
                if (_conversationData.convType == TIM_GROUP) {
                    _conversationData.title = [conv getGroupName];
                } else if (_conversationData.convType == TIM_C2C) {
                    TIMUserProfile *user = [[TIMFriendshipManager sharedInstance] queryUserProfile:_conversationData.convId];
                    if (user) {
                        _conversationData.title = [user showName];
                    }
                }
            }
        }
    }
    
    
}
- (void) onChangeUnReadCount:(NSNotification *)notifi{
    NSNumber *count = notifi.object;
    
    //此处获取本对话的未读计数，并减去本对话的未读。如果不减去，则在本对话中收到消息时，消息不会自动设为已读，从而会错误显示左上角未读计数。
    TIMConversation *conv = [[TIMManager sharedInstance] getConversation:_conversationData.convType receiver:_conversationData.convId];
    count = [NSNumber numberWithInteger:(count.integerValue - conv.getUnReadMessageNum)];
    
    [_unRead setNum:count.integerValue];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (TUIMessageCell *)chatController:(TUIChatController *)controller onShowMessageData:(TUIMessageCellData *)cellData{
    NSLog(@"走了啊");
    return nil;
}
- (void)chatController:(TUIChatController *)controller onSelectMessageAvatar:(TUIMessageCell *)cell{
    if (cell.messageData.direction==MsgDirectionIncoming) {
        if (![_conversationData.convId isEqualToString:@"02784920277"]) {
            MrCarShopDetailVC* detailVC=[[MrCarShopDetailVC alloc] init];
            detailVC.passID=_conversationData.convId;
            [self.navigationController pushViewController:detailVC animated:YES];
        }
    }

}
@end
