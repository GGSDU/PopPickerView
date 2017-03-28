//
//  PopPickerView.m
//  YDTX
//
//  Created by Story5 on 3/27/17.
//  Copyright © 2017 RookieHua. All rights reserved.
//

#import "PopPickerView.h"

#import "UIButton+Layer.h"
#import "UIColor+Hex.h"

#define BaseTag 100

@interface PopPickerView ()

@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,assign) BOOL shown;

@end

@implementation PopPickerView
#pragma mark - setter
- (void)setCurrentSelectedIndex:(NSUInteger)currentSelectedIndex
{
    _currentSelectedIndex = currentSelectedIndex;
    for (id subView in self.scrollView.subviews) {
        if ([subView isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)subView;
            if (button.tag == _currentSelectedIndex + BaseTag) {
                button.selected = true;
            } else button.selected = false;
        }
    }
}

- (void)setDefaultTitleColor:(UIColor *)defaultTitleColor
{
    _defaultTitleColor = defaultTitleColor;
    for (id button in self.scrollView.subviews) {
        if ([button isKindOfClass:[UIButton class]]) {
            [button setTitleColor:defaultTitleColor forState:UIControlStateNormal];
        }
    }
}

- (void)setSelectedTitleColor:(UIColor *)selectedTitleColor
{
    _selectedTitleColor = selectedTitleColor;
    for (id button in self.scrollView.subviews) {
        if ([button isKindOfClass:[UIButton class]]) {
            [button setTitleColor:selectedTitleColor forState:UIControlStateSelected];
        }
    }
}

- (void)setSeperateLineColor:(UIColor *)seperateLineColor
{
    _seperateLineColor = seperateLineColor;
    for (id button in self.scrollView.subviews) {
        if ([button isKindOfClass:[UIButton class]]) {
            // 加下边线
            [button addLineOn:Top color:_seperateLineColor width:1];
        }
    }
}

#pragma mark - public methods
- (void)show
{
    if (_shown) {
        return;
    }
    _shown = true;
    
    
    if ([self.dataSource respondsToSelector:@selector(titleArrayForPopPickerView:)]) {
        NSArray *titleArray = [self.dataSource titleArrayForPopPickerView:self];
        [self.dataArray addObjectsFromArray:titleArray];
    }
    
    CGFloat buttonHeight = self.scrollView.bounds.size.height / self.displayCount;
    for (int i = 0; i < self.dataArray.count; i++) {
        id value = self.dataArray[i];
        if ([value isKindOfClass:[NSString class]]) {
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(0, buttonHeight * i, self.scrollView.bounds.size.width, buttonHeight);
            UIColor *normalColor = self.defaultTitleColor;
            UIColor *selectedColor = self.selectedTitleColor;
            [button setTitleColor:normalColor forState:UIControlStateNormal];
            [button setTitleColor:selectedColor forState:UIControlStateSelected];
            [button setTitle:value forState:UIControlStateNormal];
            button.tag = BaseTag + i;
            [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [self.scrollView addSubview:button];
            
            // 加下边线
            UIColor *lineColor = self.seperateLineColor;
            [button addLineOn:Top color:lineColor width:1];
            
            if (button.tag == self.currentSelectedIndex + BaseTag) {
                button.selected = YES;
            }
        } else return;
    }
    self.scrollView.contentSize = CGSizeMake(self.scrollView.bounds.size.width, buttonHeight * self.dataArray.count);
}

#pragma mark - event
- (void)buttonClicked:(UIButton *)aSender
{
    UIButton *button = [self.scrollView viewWithTag:_currentSelectedIndex + BaseTag];
    if (button) {
        button.selected = false;
    }
    
    aSender.selected = !aSender.selected;
    _currentSelectedIndex = aSender.tag - BaseTag;
    
    if ([self.delegate respondsToSelector:@selector(popPickerView:didSelectAtIndex:)]) {
        [self.delegate popPickerView:self didSelectAtIndex:aSender.tag - BaseTag];
    }
}

#pragma mark - getter
- (UIScrollView *)scrollView
{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.bounces = false;
        _scrollView.pagingEnabled = true;
        _scrollView.showsVerticalScrollIndicator = false;
        _scrollView.layer.cornerRadius = 5;
        [self addSubview:_scrollView];
        
        UIColor *backgroundColor = [UIColor colorForHex:@"22bafd"];
        _scrollView.backgroundColor   = backgroundColor;
    }
    return _scrollView;
}

- (NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return  _dataArray;
}

@end
