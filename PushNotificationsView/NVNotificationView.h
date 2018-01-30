//
// Created by Orest Savchak on 12/18/17.
// Copyright (c) 2017 GrambleWorld. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NVNotificationView : UIView

NS_ASSUME_NONNULL_BEGIN

/*!
 * Show notification in the root view controller of your application.
 *
 * @param title     Notification title - shown in bold.
 * @param message   Notification message.
 *
 * @return instance of created notification view.
 */
+ (instancetype)showNotificationWithTitle:(nullable NSString *)title andMessage:(NSString *)message;

/*!
 * Show notification in the passed view controller.
 *
 * @param title     Notification title - shown in bold.
 * @param message   Notification message.
 *
 * @return instance of created notification view.
 */
+ (instancetype)showNotificationWithTitle:(nullable NSString *)title
                               andMessage:(NSString *)message
                         inViewController:(UIViewController *)viewController;

- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;

/*!
 * Create a new notifications view.
 *
 * @return new instance.
 */
- (instancetype)init;

/*!
 * Show notification.
 *
 * @param title             Notification title - shown in bold.
 * @param message           Notification message.
 * @param viewController    Current View Controller.
 */
- (void)showWithTitle:(nullable NSString *)title
           andMessage:(NSString *)message
     inViewController:(UIViewController *)viewController;

/*!
 * Hide notifications view.
 * @param animated hide view animated or not.
 */
- (void)hide:(BOOL)animated;

NS_ASSUME_NONNULL_END

@end
