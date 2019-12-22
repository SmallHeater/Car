//
//  CarConversionListVC.m
//  Car
//
//  Created by mac on 2019/12/17.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "CarConversionListVC.h"
#import <TUIConversationListController.h>
@interface CarConversionListVC ()<TUIConversationListControllerDelegagte>

@end

@implementation CarConversionListVC
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}
-(void)gotoSystem{
    TUIConversationCellData *data = [[TUIConversationCellData alloc] init];
    data.convId =@"02784920277";
    data.convType = TIM_C2C;
    data.title = @"车店大师在线客服";
    
    
    CarChatVC *chat = [[CarChatVC alloc] init];
    chat.hidesBottomBarWhenPushed=YES;
    chat.conversationData = data;
    [self.navigationController pushViewController:chat animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationItem setTitle:@"消息"];
    
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"kefu"] style:UIBarButtonItemStylePlain target:self action:@selector(gotoSystem)];
    
    TUIConversationListController *conv = [[TUIConversationListController alloc] init];
    conv.delegate = self;
    [self addChildViewController:conv];
    [self.view addSubview:conv.view];
    
    //如果不加这一行代码，依然可以实现点击反馈，但反馈会有轻微延迟，体验不好。
    conv.tableView.delaysContentTouches = NO;
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)conversationListController:(TUIConversationListController *)conversationController didSelectConversation:(TUIConversationCell *)conversation
{
    CarChatVC *chat = [[CarChatVC alloc] init];
    chat.hidesBottomBarWhenPushed=YES;
    chat.conversationData = conversation.convData;;
    [self.navigationController pushViewController:chat animated:YES];
}

@end
