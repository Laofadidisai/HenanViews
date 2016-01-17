//
//  ViewController.m
//  GDRNavigationBarView
//
//  Created by dllo on 16/1/8.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "ViewController.h"
#import "GDRNavigationBarView.h"
#define HEIGHT self.view.frame.size.height
#define WIDTH self.view.frame.size.width
@interface ViewController ()<UIScrollViewDelegate>
@property(nonatomic,retain)GDRNavigationBarView *naTabView;
@property(nonatomic,retain)UIScrollView *scrollViewDown;
@property(nonatomic,retain)NSArray *arr;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    self.arr = @[@"头条",@"订阅",@"苹果",@"新闻",@"手机",@"评测",@"数码",@"电脑",@"热榜",@"导航",@"视频",@"攒机",@"外设",@"直播"];
    self.navigationController.navigationBar.barTintColor = [UIColor blueColor];
    self.navigationController.navigationBar.translucent = NO;
    self.naTabView = [[GDRNavigationBarView alloc]initWithFrame:CGRectMake(0, 20, WIDTH, 40) withWidth:WIDTH  withArray:self.arr];
    self.navigationItem.titleView = self.naTabView;
    
    ///创建滚动的scrollViewDown
    [self createScrollViewDown];
   
}

///创建滚动的scrollViewDown
- (void)createScrollViewDown{
    
    self.scrollViewDown=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    self.scrollViewDown.contentSize=CGSizeMake(WIDTH*14, 0);
    self.scrollViewDown.backgroundColor = [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:arc4random()%256/255.0];
    self.scrollViewDown.pagingEnabled=YES;
    self.scrollViewDown.bounces=NO;
    self.scrollViewDown.delegate = self;
    [self.view addSubview:self.scrollViewDown];
    
    for (int i=0; i<14; i++) {
        UILabel *lable=[[UILabel alloc]initWithFrame:CGRectMake(150 + WIDTH*i, 80, 100, 100)];
        lable.text=self.arr[i];
        lable.font = [UIFont systemFontOfSize:30];
        lable.textColor=[UIColor colorWithRed:0.414 green:0.057 blue:1.000 alpha:1.000];
        lable.textAlignment=NSTextAlignmentLeft;
        [self.scrollViewDown addSubview:lable];
    }
    
    ///传值
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(deliverValue:) name:@"123" object:nil];
}

///点击button跳到对应的页面
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.naTabView deliver:scrollView];
}

///滑动,跳到对应的button
- (void)deliverValue:(NSNotification *)notification{
    NSString *str = [notification object];
    CGFloat temp = [str intValue];
    self.scrollViewDown.contentOffset = CGPointMake(temp * WIDTH, 0);
}

@end
