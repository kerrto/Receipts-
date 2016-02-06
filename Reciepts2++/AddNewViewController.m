//
//  AddNewViewController.m
//  Reciepts2++
//
//  Created by Kerry Toonen on 2016-02-04.
//  Copyright © 2016 Kerry Toonen. All rights reserved.
//

#import "AddNewViewController.h"
#import "AppDelegate.h"
#import "MainTableViewController.h"


@interface AddNewViewController ()
- (IBAction)cancelButton:(id)sender;
- (IBAction)saveButton:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *tagCell;


@end

@implementation AddNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    AppDelegate *del = [UIApplication sharedApplication].delegate;
    NSFetchRequest *tagReq = [NSFetchRequest fetchRequestWithEntityName:@"Tag"];

    tagReq.sortDescriptors = @[ [NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES] ];
    
    self.resultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:tagReq managedObjectContext:del.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    self.resultsController.delegate = self;
    NSError *err = nil;
    if (![self.resultsController performFetch:&err]) {
        NSLog(@"oh shit %@", err.localizedDescription);
        abort();
    
    
    
    // Do any additional setup after loading the view.
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

- (IBAction)cancelButton:(id)sender {
    [self popoverPresentationController];
}

- (IBAction)saveButton:(id)sender {
    
    NSString *receiptDescribe=self.detailTF.text;
    NSString *receiptAmount=self.amountTF.text;
    NSNumber *receiptAmountNumber=@([receiptAmount intValue]);

    
    // Create Managed Object
    AppDelegate *del = [UIApplication sharedApplication].delegate;
    
    NSManagedObjectContext *managedObjectContext=del.managedObjectContext;
    
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Receipt" inManagedObjectContext:managedObjectContext];
    NSManagedObject *newReceipt = [[NSManagedObject alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:managedObjectContext];
    
    
    
    [newReceipt setValue:receiptDescribe forKey:@"detail"];
    [newReceipt setValue:receiptAmountNumber forKey:@"amount"];

    
    [del saveContext];
    
    [self popoverPresentationController];
}

#pragma mark - UITableViewDataSource
    
    - (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
    {
        return 1;
    }

    - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
    {

        
        if ([self.resultsController.sections count] > 0) {
            return [self.resultsController.sections[0] numberOfObjects];
        }
        return 0;
    }
    
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tagCell"];
        
        [self configureCell:cell atIndexPath:indexPath];
 
        
        return cell;
    }

-(void)configureCell:(UITableViewCell*)cell atIndexPath:(NSIndexPath *)indexPath {
    NSManagedObject *object=[self.resultsController objectAtIndexPath:indexPath];
    
    self.tagCell.text=[object valueForKey:@"title"];
    
}
    
#pragma mark - nsfetchresultscontrollerdelegate
    
    - (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
    {
        [self.tableView beginUpdates];
    }
    
    - (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
    {
        [self.tableView endUpdates];
    }
    
    - (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath
    {
        switch (type) {
            case NSFetchedResultsChangeInsert:
                [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                break;
            case NSFetchedResultsChangeDelete:
                [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                break;
            default:
                break;
        }
    }
    
//    [self performSegueWithIdentifier:@"backToRoot" sender:newReceipt];
    

//
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    if ([[segue identifier] isEqualToString:@"backToRoot"]) {
//        
//        
//        MainTableViewController *controller = (MainTableViewController *)[segue destinationViewController];
//        [controller setDetailItem:sender];
//     
//    }
//}




    

@end
