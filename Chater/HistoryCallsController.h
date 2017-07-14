//
//  HistoryCallsController.h
//  Chater
//
//  Created by Qway on 2017/7/12.
//  Copyright © 2017年 viviwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Chater+CoreDataModel.h"

@class DetailViewController;

@interface HistoryCallsController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) DetailViewController *detailViewController;

@property (strong, nonatomic) NSFetchedResultsController<Event *> *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;


@end

