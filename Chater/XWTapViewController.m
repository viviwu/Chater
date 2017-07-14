//
//  XWTapViewController.m
//  iPadUIdesign
//
//  Created by Qway on 2017/7/13.
//  Copyright © 2017年 viviwu. All rights reserved.
//

#import "XWTapViewController.h"

@interface XWTapViewController ()

@property (weak, nonatomic) IBOutlet UITextField *numberTF;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@end

@implementation XWTapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)selectTelCode:(UIButton *)sender {
    NSLog(@"%s", __func__);
}

- (IBAction)deleteDialNumberChar:(id)sender {
    if (_numberTF.text.length) {
        NSMutableString *ms=[NSMutableString stringWithFormat:@"%@", _numberTF.text];
        [ms deleteCharactersInRange:NSMakeRange(ms.length-1, 1)];
        _numberTF.text=ms;
        NSLog(@"%@", ms);
    } 
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
