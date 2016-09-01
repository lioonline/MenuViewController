//
//  MainViewController.m
//  MenuViewController
//
//  Created by Lee on 8/31/16.
//  Copyright © 2016 Lee. All rights reserved.
//

#import "MainViewController.h"
#import "MenuViewController.h"
#import "MenuPresentAnimation.h"
#import "MenuDismissAnimation.h"
@interface MainViewController ()<UIViewControllerTransitioningDelegate,MenuViewControllerDelegate>
@property (nonatomic,strong)MenuPresentAnimation *presentAnimation;
@property (nonatomic, strong) MenuDismissAnimation *dismissAnimation;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *menu = [UIButton buttonWithType:UIButtonTypeSystem];
    
    [menu setTitle:@"MENU" forState:normal];
    
    menu.bounds = CGRectMake(0, 0, 60, 44);
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:menu];
    
    self.navigationItem.leftBarButtonItem = item;
    
    [menu addTarget:self action:@selector(showMenu) forControlEvents:UIControlEventTouchUpInside];
    _presentAnimation = [MenuPresentAnimation new];
    
    _dismissAnimation = [MenuDismissAnimation new];
    
}

-(void)showMenu {
    MenuViewController *menu = [MenuViewController new];
    
    menu.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    
    menu.transitioningDelegate = self;
    
    menu.delegate = self;
    
    [self presentViewController:menu animated:YES completion:^{
        
    }];
    
}

-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    
    return self.presentAnimation;
}


-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return self.dismissAnimation;
}


-(void)presentViewControllerDissmiss:(MenuViewController *)presentViewController{
    [self dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"dissmiss");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
