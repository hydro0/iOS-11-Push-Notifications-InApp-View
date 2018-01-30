//
// Created by Orest Savchak on 12/18/17.
// Copyright (c) 2017 GrambleWorld. All rights reserved.
//

#import "NVNotificationView.h"

static NSInteger const HorizontalMargin = 8;
static NSInteger const VerticalMargin = 16;
static NSInteger const Height = 100;
static NSInteger const Padding = 10;

@implementation NVNotificationView

+ (instancetype)showNotificationWithTitle:(nullable NSString *)title andMessage:(NSString *)message {
    return [self showNotificationWithTitle:title
                                andMessage:message
                          inViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
}

+ (instancetype)showNotificationWithTitle:(nullable NSString *)title
                               andMessage:(NSString *)message
                         inViewController:(UIViewController *)viewController {
    NVNotificationView *notificationsView = [NVNotificationView new];

    [notificationsView showWithTitle:title andMessage:message inViewController:viewController];

    return notificationsView;
}

- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}

- (void)hide:(BOOL)animated {
    if (animated) {
        [self hideAnimated];
    } else {
        [self removeFromSuperview];
    }
}

- (void)showWithTitle:(nullable NSString *)title
           andMessage:(NSString *)message
     inViewController:(UIViewController *)viewController {
    self.frame = CGRectMake(HorizontalMargin, -Height * 2, viewController.view.frame.size.width - HorizontalMargin * 2, Height);

    [self setBlur];

    CGFloat top = 10;
    if (title) {
        [self showTitle:title topPosition:top];
        top += 30;
    }
    [self showMessage:message topPosition:top];

    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]
            initWithTarget:self
                    action:@selector(handlePan:)];

    [self addGestureRecognizer:pan];
    [self scheduleClose];

    [viewController.view addSubview:self];
    [UIView animateWithDuration:0.2f animations:^{
        self.frame = CGRectMake(HorizontalMargin, VerticalMargin, viewController.view.frame.size.width - HorizontalMargin * 2, Height);
    }];
}

- (void)setBlur {
    if (!UIAccessibilityIsReduceTransparencyEnabled()) {
        self.backgroundColor = [UIColor clearColor];

        UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];

        blurEffectView.frame                = self.bounds;
        blurEffectView.autoresizingMask     = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        blurEffectView.clipsToBounds        = YES;
        blurEffectView.layer.cornerRadius   = 15;

        [self addSubview:blurEffectView];
    } else {
        self.backgroundColor                = [UIColor colorWithRed:0.9f green:0.9f blue:0.9f alpha:1.f];
        self.alpha                          = 0.9f;
    }

    self.layer.cornerRadius     = 15;
    self.layer.shadowColor      = [UIColor blackColor].CGColor;
    self.layer.shadowOpacity    = 0.8;
    self.layer.shadowRadius     = 2.0;
    self.layer.shadowOffset     = CGSizeMake(2.0, 2.0);
}

- (void)showMessage:(NSString *)message topPosition:(CGFloat)topPosition {
    UILabel *messageView        = [[UILabel alloc] initWithFrame:CGRectMake(Padding, topPosition, self.frame.size.width - Padding * 2, 60)];

    messageView.font            = [UIFont systemFontOfSize:15];
    messageView.numberOfLines   = 0;
    messageView.text            = message;

    [self addSubview:messageView];
}

- (void)showTitle:(NSString *)title topPosition:(CGFloat)topPosition {
    UILabel *titleView  = [[UILabel alloc] initWithFrame:CGRectMake(Padding, topPosition, self.frame.size.width - Padding * 2, 30)];

    titleView.font      = [UIFont boldSystemFontOfSize:15];
    titleView.text      = title;

    [self addSubview:titleView];

}

- (void)scheduleClose {
    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 3 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [weakSelf hideAnimated];
    });
}

- (void)handlePan:(UIPanGestureRecognizer *)pan {
    CGPoint center = pan.view.center;
    CGPoint translation = [pan translationInView:pan.view];
    if (pan.state == UIGestureRecognizerStateChanged) {
        if (center.y > 150) {
            translation.y = translation.y / 2.f;
        }
        center = CGPointMake(center.x, center.y + translation.y);
        pan.view.center = center;
        [pan setTranslation:CGPointZero inView:pan.view];
    } else if (pan.state == UIGestureRecognizerStateEnded) {
        if (center.y < 30) {
            [self hideAnimated];
        } else {
            [UIView animateWithDuration:0.3f animations:^{
                pan.view.center = CGPointMake(center.x, 50 + VerticalMargin);
            }];
        }
    }
}

- (void)hideAnimated {
    [UIView animateWithDuration:0.3f animations:^{
        self.center = CGPointMake(self.center.x, -150);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
