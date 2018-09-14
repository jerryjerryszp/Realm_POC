//
//  ViewController.h
//  Realm_POC
//
//  Created by Jerry Shi on 2018-09-14.
//  Copyright © 2018 Jerry Shi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InfoTable.h"

@interface ViewController : UIViewController {
    //auto updating query container for data objects
    //RLMResults always reflect on current state in current thread
    RLMResults *tableDataArray;
    //selected data object for editing purpose
    InfoTable *selectedDataObject;
}

//three buttons: insert/delete/deleteAll on top of vc
- (IBAction)didTapInsertBtn:(id)sender;
- (IBAction)didTapDeleteBtn:(id)sender;
- (IBAction)didTapDeleteAllBtn:(id)sender;

//tableView for populating objects
@property (weak, nonatomic) IBOutlet UITableView *mTableView;

@end




