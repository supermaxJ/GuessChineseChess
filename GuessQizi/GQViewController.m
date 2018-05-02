//
//  GQViewController.m
//  GuessQizi
//
//  Created by SuperMaxJ on 13-11-26.
//  Copyright (c) 2013年 supermaxdev. All rights reserved.
//

#import "GQViewController.h"
#import "GQQiziInfo.h"

@interface GQViewController ()

- (int)getRandomNumber:(int)from to:(int)to;

- (void)generatePlayingMethod;
- (void)generateResult;

- (void)generateQizi;
@end

@implementation GQViewController
{
    GQQiziInfo *qizi0;  //1号棋子
    GQQiziInfo *qizi1;  //2号棋子
    
    PlayingMethod method;
    BOOL result;                  //相同和不相同的概率各执一半
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self ibaReStart:nil];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (int)getRandomNumber:(int)from to:(int)to {
    return (int)(from + (arc4random() % (to - from + 1)));
}

- (void)generatePlayingMethod {
    int num = [self getRandomNumber:0 to:100];
    
    if (num < 10) {
        method = PlayingMethod_Direction;
    } else if (num < 25) {
        method = PlayingMethod_None;
    } else if (num < 50) {
        method = PlayingMethod_Color;
    } else {
        method = PlayingMethod_Type;
    }
}

- (void)generateResult {
    result = [self getRandomNumber:0 to:1];
}

- (void)generateGameInfo {
    qizi0 = [GQQiziInfo generateQizi];
    qizi1 = [GQQiziInfo generateQizi:method
                              result:result
                       referenceQizi:qizi0];
    
    
}

- (IBAction)ibaReStart:(id)sender {
    [self generatePlayingMethod];
    [self generateResult];
    [self generateGameInfo];
    
    [self refrenshView];
}

- (IBAction)ibaYes:(id)sender {
    [self showResult:sender];
}

- (IBAction)ibaNo:(id)sender {
    [self showResult:sender];
}

- (void)showResult:(UIButton *)button {
    BOOL judge;
    if (button.tag == 0) {
        judge = NO;
    } else {
        judge = YES;
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"结论"
                                                    message:judge==result ? @"正确！继续保持！" : @"错误！再接再厉！"
                                                   delegate:nil
                                          cancelButtonTitle:@"关闭"
                                          otherButtonTitles:nil, nil];
    [alert show];
    
    if (judge == result) {
        [self ibaReStart:nil];
    }
}

- (void)refrenshView {
    switch (method) {
        case PlayingMethod_Type:
            self.ibaPlayingMethod.text = @"类型相同";
            break;
        case PlayingMethod_Color:
            self.ibaPlayingMethod.text = @"颜色相同";
            break;
        case PlayingMethod_Direction:
            self.ibaPlayingMethod.text = @"方向相同";
            break;
        case PlayingMethod_None:
            self.ibaPlayingMethod.text = @"无一相同";
            break;
    }
    
    self.ibResult.text = result ? @"真" : @"假";
    
    self.ibaQizi0.image = qizi0.qiziImg;
    self.ibQizi1.image = qizi1.qiziImg;
}
@end
