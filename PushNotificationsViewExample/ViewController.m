//
//  ViewController.m
//  PushNotificationsView
//
//  Created by Orest Savchak on 1/30/18.
//  Copyright © 2018 Hydro_O. All rights reserved.
//

#import "ViewController.h"
#import "NVNotificationView.h"


@interface ViewController ()

@property (nonatomic, strong) NVNotificationView *topNotificationView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showNotificationsView:(id)sender {
    self.topNotificationView = [NVNotificationView showNotificationWithTitle:@"Notification"
                                                                  andMessage:@"And here is a long title. You may read this or not, but it exists to show you how does UI looks when you have a lot of shitty text in your notification. But not too much."];
}

- (IBAction)hideTopNotificationsView:(id)sender {
    [self.topNotificationView hide:YES];
}

- (IBAction)showNotificationsViewUsingInitializer:(id)sender {
    self.topNotificationView = [NVNotificationView new];

    [self.topNotificationView showWithTitle:@"Red notification"
                                 andMessage:@"Yeah, it is possible to get blind with this color, use default!"
                           inViewController:self];
}

- (IBAction)showNotificationWithoutTitle:(id)sender {
    self.topNotificationView = [NVNotificationView showNotificationWithTitle:nil
                                                                  andMessage:@"And here is a long title. You may read this or not, but it exists to show you how does UI looks when you have a lot of shitty text in your notification. But not too much."];
}

@end
