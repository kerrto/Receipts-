//
//  AddNewViewController.h
//  Reciepts2++
//
//  Created by Kerry Toonen on 2016-02-04.
//  Copyright © 2016 Kerry Toonen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AddNewViewController : UIViewController <UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITextField *amountTF;
@property (strong, nonatomic) IBOutlet UITextField *detailTF;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSFetchedResultsController *resultsController;

@end
