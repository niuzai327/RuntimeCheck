//
//  ViewController.m
//  RuntimeCheck
//
//  Created by YXY on 2017/8/21.
//  Copyright © 2017年 NewAsia. All rights reserved.
//

#import "ViewController.h"
#import "Cat.h"
#import "Dog.h"
#import "Chicken.h"
#import "MyDelegate.h"
#import "SecondViewController.h"
#import <objc/runtime.h>
#import "MyTableView.h"
#import "MyCycleView.h"
#import "CustomTableView.h"
#import "CustomCell.h"
@interface ViewController ()<MyDelegate,MyTableViewDataSource,MyTableViewDelegate,CustomTableViewDataSource,UIScrollViewDelegate>
{
    UIImageView *imageView;
}

@property (strong, nonatomic) MyTableView *tableView;
@property (strong, nonatomic) MyCycleView *cycleView;
@property (nonatomic, strong) CustomTableView *customTableView;

//@property (nonatomic, assign) id <MyDelegate> delegate;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /*
    // Do any additional setup after loading the view, typically from a nib.
    Cat *cat = [[Cat alloc] init];
    [cat jump];
    
    [cat setValue:@"huihui" forKey:@"name"];
    NSLog(@"%@",[cat valueForKey:@"name"]);
    
    [cat sayHi];
    
    unsigned int count = 0;
    Ivar *members = class_copyIvarList([Cat class], &count);
    for (int i = 0; i<count; i++) {
        Ivar var = members[i];
        const char *memberName = ivar_getName(var);
        NSLog(@"使用runtime %s",memberName);
    }
    Ivar name = members[1];
    object_setIvar(cat, name, @"我是Nimo");
    [cat sayHi];
    
    NSLog(@"%@",cat->_numbers);
    
    Dog *dog = [[Dog alloc] init];
    [dog jump];
    
    Chicken *chicken = [[Chicken alloc] init];
    [chicken jump];
    
    self.delegate = self;
    
//    NSTimer *timer = [[NSTimer alloc] initWithFireDate:[NSDate date] interval:1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
//    NSRunLoop *currentLoop = [NSRunLoop currentRunLoop];
//    [currentLoop addTimer:timer forMode:NSDefaultRunLoopMode];
//    NSNull *currentNull  = [NSNull null];
//    NSLog(@"%p",currentNull);
    
//    NSMutableArray *arr = [NSMutableArray arrayWithObjects:@"4",@"8",@"2",@"9",@"0",@"3", nil];
//    [self maopaoSort:arr];
//    [self checkHuiWenNumber:12367];
//    [self dlogInt:12345];
    
    NSMutableArray *arr = [NSMutableArray arrayWithObjects:@"3",@"4",@"7",@"2",@"9",@"1", nil];
    [self quickSortArray:arr withLeftIndex:0 andRightIndex:arr.count-1];
    NSLog(@"%@",arr);
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(20, 200, 200, 40);
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(pushSecond:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    NSArray *cusArr = [NSArray arrayWithObjects:@"a",@"b",nil,@"3",@"4", nil];
    NSLog(@"cusArr %@",cusArr);
    
    
    [self mpSort:arr];
    */
//    _tableView = [[MyTableView alloc] initWithFrame:self.view.bounds];
//    _tableView.delegate = self;
//    _tableView.dataSource = self;
//    [self.view addSubview:_tableView];
//    [_tableView reloadData];
    /*
    NSMutableArray *imageArr = [NSMutableArray array];
    for (int i = 1; i <= 6; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"cycle_image%ld.jpg",(long)i]];
        [imageArr addObject:image];
    }
    _cycleView = [[MyCycleView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200) imageArr:[imageArr copy]];
    _cycleView.cycleTime = 3.0f;
    [self.view addSubview:_cycleView];
     */
    
    _customTableView = [[CustomTableView alloc] initWithFrame:self.view.bounds];
    _customTableView.backgroundColor = [UIColor grayColor];
    _customTableView.dataSource = self;
    _customTableView.delegate = self;
    [_customTableView reloadData];
    [self.view addSubview:_customTableView];
    
}

/*
- (void)mpSort:(NSMutableArray *)arr{
    for (int i = 0; i<arr.count; i++) {
        for (int j = 0; j < arr.count - i - 1; j++) {
            if ([arr[j] integerValue] > [arr[j+1] integerValue]) {
                [arr exchangeObjectAtIndex:j withObjectAtIndex:j+1];
            }
        }
    }
    NSLog(@"%@",arr);
}

- (void)myMethod{
    
}

- (void)pushSecond:(UIButton *)sender
{
    SecondViewController *vc = [[SecondViewController alloc] initWithNibName:nil bundle:nil];
    vc.str = @"firstVC";
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)checkHuiWenNumber:(int)number{
    NSMutableArray *numberArr = [NSMutableArray array];
    if (number <  10000 && number > 99999) {
        NSLog(@"输入的不是五位数");
    }else{
        for (int i = 0; i < 5; i++) {
            numberArr[i] =  [NSString stringWithFormat:@"%d",number%10];
            number /= 10;
        }
        if ([numberArr[0] intValue] == [numberArr[4] intValue] && [numberArr[1] intValue] == [numberArr[3] intValue]) {
            NSLog(@"输入的是回文数");
        }else{
            NSLog(@"输入的不是回文数");
        }
    }
}

- (void)dlogInt:(NSInteger)number{
    NSMutableString *numberStr = [[NSMutableString alloc] init];
    NSInteger numberLength = number;
    for (int i = 0; i<[self weishu:numberLength]; i++) {
        [numberStr appendString:[NSString stringWithFormat:@"%ld",number%10]];
        number /= 10;
    }
    NSLog(@"numberStr %@",numberStr);
}

- (NSInteger)weishu:(NSInteger)number{
    NSInteger sum = 0;
    while (number >= 1) {
        number = number/10;
        sum ++;
    }
    return sum;
}

- (void)maopaoSort:(NSMutableArray *)arr{
    for (int i = 0; i<arr.count; i++) {
        for (int j=0; j<arr.count-1; j++) {
            if ([arr[j] integerValue] > [arr[j+1] integerValue]) {
                [arr exchangeObjectAtIndex:j withObjectAtIndex:j+1];
            }
            NSLog(@"intarr:%@",arr);
        }
        NSLog(@"outArr%@",arr);
    }
    NSLog(@"endArr%@",arr);
}

- (void)quickSortArray:(NSMutableArray *)array withLeftIndex:(NSInteger)leftIndex andRightIndex:(NSInteger)rightIndex
{
    if (leftIndex >= rightIndex) {
        return;
    }
    NSInteger i = leftIndex;
    NSInteger j = rightIndex;
    NSInteger key = [array[i] integerValue];
    while (i < j) {
        while (i < j && [array[j] integerValue] >= key) {
            j--;
        }
        array[i] = array[j];
        while (i < j && [array[i] integerValue] <= key) {
            i++;
        }
        array[j] = array[i];
    }
    array[i] = @(key);
    [self quickSortArray:array withLeftIndex:leftIndex andRightIndex:i-1];
    [self quickSortArray:array withLeftIndex:i+1 andRightIndex:rightIndex];
}

- (void)timerAction{
    NSLog(@"timer ");
}
 */

/*
#pragma mark -- MyTableViewDelegate & MyTableViewDataSource
- (NSInteger)tableView:(MyTableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 30;
}

- (UITableViewCell *)tableView:(MyTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"MyCellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifrier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.backgroundColor = [UIColor redColor];
    cell.textLabel.textColor = [UIColor blueColor];
    cell.textLabel.text = [[NSString alloc]initWithFormat:@"我是第%ld行",(long)indexPath.row];
    return cell;
}

- (CGFloat)tableView:(MyTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
*/
#pragma mark --CustomTableViewDataSource
- (NSInteger)numberOfRows{
    return 100;
}

- (UITableViewCell *)tableView:(CustomTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"CustomCellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
//        cell.reuseIdentifier = @"CustomCellId";
        cell.backgroundColor = [UIColor redColor];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"我是第%ld行",(long)indexPath.row];
    NSLog(@"%@",cell.textLabel.text);
    return cell;
}

- (CGFloat)heightForRowInTableView{
    return 50;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
