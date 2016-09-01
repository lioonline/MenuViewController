//
//  MenuViewController.h
//  MenuViewController
//
//  Created by Lee on 8/31/16.
//  Copyright © 2016 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#include <BlocksKit+UIKit.h>
@class MenuViewController;
@protocol MenuViewControllerDelegate <NSObject>

-(void)presentViewControllerDissmiss:(MenuViewController *)presentViewController;

@end


@interface MenuViewController : UIViewController

@property (nonatomic,weak) id <MenuViewControllerDelegate> delegate;


@end
