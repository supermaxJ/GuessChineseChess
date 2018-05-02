//
//  GQViewController.h
//  GuessQizi
//
//  Created by SuperMaxJ on 13-11-26.
//  Copyright (c) 2013年 supermaxdev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GQViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *ibaQizi0;
@property (weak, nonatomic) IBOutlet UIImageView *ibQizi1;
@property (weak, nonatomic) IBOutlet UILabel *ibaPlayingMethod;
@property (weak, nonatomic) IBOutlet UILabel *ibResult;
- (IBAction)ibaReStart:(id)sender;
- (IBAction)ibaYes:(id)sender;
- (IBAction)ibaNo:(id)sender;
@end
