//
//  ViewController.m
//  llbTest
//
//  Created by 1 on 16/3/22.
//  Copyright © 2016年 llb. All rights reserved.
//

#import "ViewController.h"
#import "UIView+Frame.h"
@interface ViewController ()<UIGestureRecognizerDelegate>
@property(nonatomic,assign)BOOL shouldMove;
@property(nonatomic,weak)UIButton * btn;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self addOpenDoorBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 虚浮按钮-
-(void)addOpenDoorBtn
{
    _shouldMove = NO;
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0,40,40);
    btn.backgroundColor = [UIColor redColor];
    btn.right = self.view.width;
    btn.centerY = self.view.centerY;
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(openDoorBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressHandle:)];
    //从手指按下开始计时，过了0.5秒会调用longPressHandle:
    longPress.minimumPressDuration = 0.5;
    longPress.delegate = self;
    [btn addGestureRecognizer:longPress];
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pangesMove:)];
    [btn addGestureRecognizer:pan];
    _btn = btn ;
    
    
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

- (void)longPressHandle:(UILongPressGestureRecognizer *)longPress
{
    
    if (longPress.state == UIGestureRecognizerStateBegan)
    {
        NSLog(@"长安开始");
        _shouldMove = YES ;
        CGPoint point = [longPress locationInView:self.view];
        _btn.center = point;
    }
    else if(longPress.state == UIGestureRecognizerStateEnded)
    {
        _shouldMove = NO;
        
        [self backToBounds];
        
    }else if (longPress.state == UIGestureRecognizerStateChanged)
    {
        
        
    }
}
-(void)backToBounds
{

    if (_btn.centerX > self.view.centerX) {
        
    [UIView animateWithDuration:0.3 animations:^{
        
        _btn.right = self.view.right;
    }];
        
        
    }else
    {
        [UIView animateWithDuration:0.3 animations:^{
            _btn.left = self.view.left;
 
        }];
    }



}







-(void)pangesMove:(UIPanGestureRecognizer *)ges
{

   
    if (_shouldMove == YES) {
       [self panGesMove:ges];
    }

}

-(void)panGesMove:(UIPanGestureRecognizer *)ges
{


    if (ges.state == UIGestureRecognizerStateChanged) {
    
        CGPoint point = [ges translationInView:self.view];
        CGPoint center = _btn.center;
        _btn.center = CGPointMake(center.x + point.x, center.y + point.y);
        [ges setTranslation:CGPointZero inView:self.view];
    }

}


-(void)openDoorBtnClick:(UIButton *)btn
{
    
    
    
    
}


@end
