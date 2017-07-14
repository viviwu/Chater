//
//  AppDelegate.h
//  Chater
//
//  Created by Qway on 2017/7/12.
//  Copyright © 2017年 viviwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <XWVoipKit/XWVoipKit.h>

#import "XWTapViewController.h"

#define kScreenH [UIScreen mainScreen].bounds.size.height
#define kScreenW [UIScreen mainScreen].bounds.size.width
#define tapSize  128.0

#define kAppDel  ((AppDelegate*)([UIApplication sharedApplication].delegate))

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UIWindow *tapWindow;
@property (strong, nonatomic) XWTapViewController * tapView;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

