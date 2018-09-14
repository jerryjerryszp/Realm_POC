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
    RLMResults *tableDataArray;
    InfoTable *selectedDataObject;
}

- (IBAction)didTapInsertBtn:(id)sender;
- (IBAction)didTapDeleteBtn:(id)sender;

@property (weak, nonatomic) IBOutlet UITableView *mTableView;


@end




