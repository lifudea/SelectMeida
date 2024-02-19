//
//  ViewController.m
//  Runner
//
//  Created by hello on 2024/2/19.
//

#import "ViewControllerUtils.h"


@implementation ViewControllerUtils

- (UIViewController *)getCurrentVc {
    UIViewController *result = nil;
    UIWindow *window = [[UIApplication sharedApplication]keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
        {
            NSArray *windows = [[UIApplication sharedApplication] windows];
            for(UIWindow * tmpWin in windows)
            {
                if (tmpWin.windowLevel == UIWindowLevelNormal)
                {
                    window = tmpWin;
                    break;
                }
            }
        }
          
        UIView *frontView = [[window subviews] objectAtIndex:0];
        id nextResponder = [frontView nextResponder];
          
        if ([nextResponder isKindOfClass:[UIViewController class]])
            result = nextResponder;
        else
            result = window.rootViewController;
        return result;
}

@end
