//
//  DetailViewController.h
//  Chater
//
//  Created by Qway on 2017/7/12.
//  Copyright © 2017年 viviwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Chater+CoreDataModel.h"

@interface DetailViewController : UIViewController

@property (strong, nonatomic) Event *detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

