//
//  ViewController.m
//  UndeadThread
//
//  Created by LL on 2024/5/29.
//

#import "ViewController.h"
#import "WXLThread.h"

@interface ViewController ()

@property (nonatomic, strong) WXLThread *thread;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.whiteColor;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"测试按钮" forState:UIControlStateNormal];
    [button setBackgroundColor:UIColor.redColor];
    [button setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, 85, 40);
    button.center = self.view.center;
    [button addTarget:self action:@selector(buttonEvent) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    self.thread = [[WXLThread alloc] init];
}

- (void)buttonEvent {
    [self.thread runTask:^{
        NSLog(@"%s-----%@", __func__, NSThread.currentThread);
    }];
}


@end
