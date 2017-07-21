//
//  CHActionSheetView.m
//  TestCsqApp
//
//  Created by csq on 2016/7/11.
//  Copyright © 2017年 MyCompany. All rights reserved.
//

#import "CHActionSheetView.h"

#define Screen_Width ([UIScreen mainScreen].bounds.size.width)
#define Screen_Height ([UIScreen mainScreen].bounds.size.height)



@implementation CHActionSheetView{
    UIButton *bgView;
}
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self)
    {
        CGRect tmpframe = CGRectMake((Screen_Width-frame.size.width)/2, Screen_Height, frame.size.width, frame.size.height);
        self.frame = tmpframe;
        
        self.backgroundColor = [UIColor whiteColor];
        
        
        NSArray *windows = [UIApplication sharedApplication].windows;
        UIWindow *mainWin = windows[0];
        UIWindow *window = mainWin;
        for (NSInteger  i = windows.count-1; i >= 0; i--) {
            UIWindow *win = windows[i];
            if (CGRectEqualToRect(win.bounds, mainWin.bounds) && win.windowLevel == UIWindowLevelNormal) {
                window = win;
                break;
            }
        }
        
        bgView  = [UIButton buttonWithType:UIButtonTypeCustom];
        bgView.backgroundColor = [UIColor blackColor];
        bgView.frame = CGRectMake(0, 0, Screen_Width, Screen_Height);
        bgView.alpha = 0;
        [bgView addTarget:self action:@selector(hiddenActionSheet) forControlEvents:UIControlEventTouchUpInside];
        [window addSubview:bgView];
        [window addSubview:self];
    }
    return self;
}

-(void)setTitle:(NSArray *)titleArray cancelTitle:(NSString *)cancelStr
{
    self.backgroundColor = [self colorWithHexString:@"f3f4f5" alpha:0.9];
    CGFloat height = 0;
    CGFloat buttonHeight = 42;
    for(int i = 0 ; i < titleArray.count ; i ++)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, (buttonHeight + 1)*i, self.frame.size.width, buttonHeight);
        [button setBackgroundColor:[UIColor colorWithWhite:1 alpha:0.85]];
        button.titleLabel.font = [UIFont systemFontOfSize:17];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitle:titleArray[i] forState:UIControlStateNormal];
        button.tag = i+1;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        height = button.frame.size.height+button.frame.origin.y;
    }
    
    if(cancelStr)
    {
        height += 10;
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, height, self.frame.size.width, buttonHeight);
        [button setBackgroundColor:[UIColor colorWithWhite:1 alpha:0.85]];
        button.titleLabel.font = [UIFont systemFontOfSize:17];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitle:cancelStr forState:UIControlStateNormal];
        [button addTarget:self action:@selector(hiddenActionSheet) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 0;
        [self addSubview:button];
        height += buttonHeight;
    }
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

-(void)setTitleColor:(UIColor *)color titleIndex:(NSInteger)index;
{
    UIButton *button = (UIButton *)[self viewWithTag:index];
    [button setTitleColor:color forState:UIControlStateNormal];
}
-(void)setTitleFont:(UIFont *)font  titleIndex:(NSInteger)index{
    UIButton *button = (UIButton *)[self viewWithTag:index];
    button.titleLabel.font = font;
}
-(void)show
{
    [UIView animateWithDuration:0.4 animations:^{
        CGRect frame = CGRectMake((Screen_Width-self.frame.size.width)/2, Screen_Height-self.frame.size.height, self.frame.size.width, self.frame.size.height);
        self.frame = frame;
        bgView.alpha = 0.4;
    }];
}

-(void)hiddenActionSheet
{
    if([_delegate respondsToSelector:@selector(actionsheetWillDisappear:)])
    {
        [_delegate actionsheetWillDisappear:self];
    }
    [UIView animateWithDuration:0.4 animations:^{
        CGRect frame = CGRectMake((Screen_Width-self.frame.size.width)/2, Screen_Height, self.frame.size.width, self.frame.size.height);
        self.frame = frame;
        bgView.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        [bgView removeFromSuperview];
    }];
}

-(void)buttonClick:(UIButton *)sender
{
    [self hiddenActionSheet];
    if([_delegate respondsToSelector:@selector(actionsheetSelectButton:buttonIndex:)])
    {
        [_delegate actionsheetSelectButton:self buttonIndex:sender.tag];
    }
}

#pragma mark - 将十六进制字符串转为UIColor对象(带透明度)
-(UIColor*)colorWithHexString:(NSString *)stringToConvert alpha:(CGFloat)alpha
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return nil;
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    
    if ([cString length] != 6 &&[cString length] != 8) return nil;
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b,a=255.0;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    if ([cString length] == 8)
    {
        range.location = 6;
        NSString *aString = [cString substringWithRange:range];
        [[NSScanner scannerWithString:aString] scanHexInt:&a];
    }
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:alpha];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
