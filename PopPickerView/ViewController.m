//
//  ViewController.m
//  PopPickerView
//
//  Created by Story5 on 3/28/17.
//  Copyright © 2017 Story5. All rights reserved.
//

#import "ViewController.h"
#import "PopPickerView.h"

@interface ViewController ()<PopPickerViewDataSource,PopPickerViewDelegate>

@property (nonatomic,strong) PopPickerView *popPickerView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(100, 100, 100, 40);
    button.backgroundColor = [UIColor redColor];
    [button setTitle:@"pop" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - target
- (void)buttonClicked:(UIButton *)aSender {
    CGRect buttonFrame = aSender.frame;
    CGRect frame = CGRectMake(buttonFrame.origin.x,CGRectGetMaxY(buttonFrame), buttonFrame.size.width, 40 * 3);
    [self showPopPickerViewWithFrame:frame];
}

- (void)showPopPickerViewWithFrame:(CGRect)frame
{
    self.popPickerView.frame = frame;
    self.popPickerView.defaultTitleColor = [UIColor whiteColor];
    self.popPickerView.selectedTitleColor = [UIColor blackColor];
    self.popPickerView.seperateLineColor = [UIColor whiteColor];
    self.popPickerView.displayCount = 3;
    self.popPickerView.currentSelectedIndex = 0;
    
    [self.popPickerView show];
}

#pragma mark - event
- (PopPickerView *)popPickerView
{
    if (_popPickerView == nil) {
        _popPickerView = [[PopPickerView alloc] init];
        _popPickerView.dataSource = self;
        _popPickerView.delegate = self;
        [self.view addSubview:_popPickerView];
    }
    return _popPickerView;
}

#pragma mark - 
- (NSArray *)titleArrayForPopPickerView:(PopPickerView *)popPickerView
{
    return @[@"title1",@"title2",@"title3",@"title4",@"title5"];
}

- (void)popPickerView:(PopPickerView *)popPickerView didSelectAtIndex:(NSUInteger)index
{
    NSLog(@"index : %ld",index);
}

@end
