//
//  CHActionSheetView.h
//  TestCsqApp
//
//  Created by csq on 2016/7/11.
//  Copyright © 2017年 MyCompany. All rights reserved.
//

#import <UIKit/UIKit.h>



@class CHActionSheetView;

@protocol CHActionSheetViewDelegate <NSObject>

@optional

-(void)actionsheetSelectButton:(CHActionSheetView *)actionSheet buttonIndex:(NSInteger)index;

-(void)actionsheetWillDisappear:(CHActionSheetView *)actionSheet;

@end


@interface CHActionSheetView : UIView

@property(nonatomic,weak)id<CHActionSheetViewDelegate>delegate;

-(void)setTitle:(NSArray *)titleArray cancelTitle:(NSString *)cancelStr;

-(void)setTitleColor:(UIColor *)color titleIndex:(NSInteger)index;

-(void)setTitleFont:(UIFont *)font  titleIndex:(NSInteger)index;

-(void)showInViewWindow;
@end
