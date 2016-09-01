//
//  MenuViewController.m
//  MenuViewController
//
//  Created by Lee on 8/31/16.
//  Copyright © 2016 Lee. All rights reserved.
//

#import "MenuViewController.h"

@interface MenuViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UIView *whiteBgview;
@property (nonatomic,strong)UIView *blackTranslucentBackground;
@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    
    [self.view bk_whenTapped:^{
        
        if ([self.delegate respondsToSelector:@selector(presentViewControllerDissmiss:)]) {
            
            [self.delegate presentViewControllerDissmiss:self];
        }
    }];
    
    self.view.clipsToBounds = NO;
    
    _whiteBgview = [UIView new];
    
    _whiteBgview.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width*0.75, [UIScreen mainScreen].bounds.size.height);
    
    _whiteBgview.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:_whiteBgview];
    
    
    //手势
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc]
                                                    initWithTarget:self
                                                    action:@selector(handlePan:)];
    [_whiteBgview addGestureRecognizer:panGestureRecognizer];

    
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:_whiteBgview.bounds style:UITableViewStyleGrouped];
    
    tableView.delegate = self;
    
    tableView.dataSource = self;
    
    [_whiteBgview addSubview:tableView];
    
    
    
    
    
}

//处理手势
- (void) handlePan:(UIPanGestureRecognizer*) recognizer
{
    CGPoint translation = [recognizer translationInView:_whiteBgview];
    NSLog(@"%f",translation.x);
    if (_whiteBgview.frame.origin.x <= 0) {
        
        if (_whiteBgview.frame.origin.x + translation.x > 0) {
            return;
        }
        recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x,
                                             recognizer.view.center.y );
        [recognizer setTranslation:CGPointZero inView:_whiteBgview];
    }
    
    if(recognizer.state == UIGestureRecognizerStateEnded)
    {
        //All fingers are lifted.
        NSLog(@"end==========");
        
        if (-_whiteBgview.frame.origin.x >= _whiteBgview.frame.size.width/2.0) {
            [UIView animateWithDuration:0.2 animations:^{
                _whiteBgview.frame = CGRectMake(-_whiteBgview.frame.size.width, 0, _whiteBgview.frame.size.width, _whiteBgview.frame.size.height);
                
                if ([self.delegate respondsToSelector:@selector(presentViewControllerDissmiss:)]) {
                    [self.delegate presentViewControllerDissmiss:self];
                }

            } completion:^(BOOL finished) {
                 _whiteBgview.frame = CGRectMake(0, 0, _whiteBgview.frame.size.width, _whiteBgview.frame.size.height);
            }];
            
        }else{
            [UIView animateWithDuration:0.25 animations:^{
                _whiteBgview.frame = _whiteBgview.bounds;
                
            }];
        }
    }
    
}





//view 手势
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    // 拿到UITouch就能获取当前点
    UITouch *touch = [touches anyObject];
    // 获取当前点
    CGPoint curP = [touch locationInView:_whiteBgview];
    // 获取上一个点
    CGPoint preP = [touch previousLocationInView:_whiteBgview];
    // 获取手指x轴偏移量
    CGFloat offsetX = curP.x - preP.x;
    // 获取手指y轴偏移量
    // 移动当前view
    if (_whiteBgview.frame.origin.x + offsetX <=0) {
        _whiteBgview.transform = CGAffineTransformTranslate(_whiteBgview.transform, offsetX, 0);

    }
    
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    if (_whiteBgview.frame.origin.x <= (-_whiteBgview.frame.size.width/2.0)) {
        [UIView animateWithDuration:0.25 animations:^{
            _whiteBgview.frame = CGRectMake(-_whiteBgview.frame.size.width, 0, _whiteBgview.frame.size.width, _whiteBgview.frame.size.height);
            
            if ([self.delegate respondsToSelector:@selector(presentViewControllerDissmiss:)]) {
                [self.delegate presentViewControllerDissmiss:self];
            }
            
        } completion:^(BOOL finished) {
            _whiteBgview.frame = CGRectMake(0, 0, _whiteBgview.frame.size.width, _whiteBgview.frame.size.height);
            
        }];
    }else{
        [UIView animateWithDuration:0.25 animations:^{
            _whiteBgview.frame = _whiteBgview.bounds;
            
        }];
    }

    
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *idf = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:idf];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:idf];
    }
    
    
    return cell;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 120;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"indexPath.row:%ld",(long)indexPath.row);

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width * 2, [UIScreen mainScreen].bounds.size.height);

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
