//
//  TestViewController.m
//  CHActionSheetViewDemo
//
//  Created by csq on 2017/7/11.
//  Copyright © 2017年 DianDian. All rights reserved.
//

#import "TestViewController.h"
#import "CHActionSheetView.h"


@interface TestViewController ()<CHActionSheetViewDelegate>

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    CHActionSheetView *view = [[CHActionSheetView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 0)];
    view.delegate = self;
    [view setTitle:@[@"选择一",@"选择二",@"选择三",] cancelTitle:@"取消"];
    // [view setTitleFont:[UIFont systemFontOfSize:40] titleIndex:1];
    // [view setTitleColor:[UIColor redColor] titleIndex:1];
    [view showInViewWindow];
}

#pragma mark CHActionSheetViewDelegate
-(void)actionsheetSelectButton:(CHActionSheetView *)actionSheet buttonIndex:(NSInteger)index{
    NSLog(@"点击了++%ld",index);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
