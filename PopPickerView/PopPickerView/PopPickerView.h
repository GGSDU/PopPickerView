//
//  PopPickerView.h
//  YDTX
//
//  Created by Story5 on 3/27/17.
//  Copyright © 2017 RookieHua. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PopPickerView;
@protocol PopPickerViewDataSource <NSObject>

- (NSArray *)titleArrayForPopPickerView:(PopPickerView *)popPickerView;

@end

@protocol PopPickerViewDelegate <NSObject>

- (void)popPickerView:(PopPickerView *)popPickerView didSelectAtIndex:(NSUInteger)index;

@end

@interface PopPickerView : UIView

// 按钮文字颜色
@property (nonatomic,strong) UIColor *defaultTitleColor;
@property (nonatomic,strong) UIColor *selectedTitleColor;

// 分割线颜色
@property (nonatomic,strong) UIColor *seperateLineColor;

// 一次性可以展示项目个数
@property (nonatomic,assign) NSInteger displayCount;

// 当前选中项
@property (nonatomic,assign) NSUInteger currentSelectedIndex;

@property (nonatomic,assign) id<PopPickerViewDataSource>dataSource;
@property (nonatomic,assign) id<PopPickerViewDelegate>delegate;

- (void)show;

@end
