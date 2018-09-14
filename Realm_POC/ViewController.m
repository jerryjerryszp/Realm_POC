//
//  ViewController.m
//  Realm_POC
//
//  Created by Jerry Shi on 2018-09-14.
//  Copyright © 2018 Jerry Shi. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, assign) BOOL toggle;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.]
    // tableDataArray consist of all objects in InfoTable
    tableDataArray = [InfoTable allObjects];
    self.toggle = false;
    [_mTableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)didTapInsertBtn:(id)sender {
    //initiating alert view to allow insertion of data
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Realm Insert" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"Cancel" ,@"Save", nil];
    alert.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
    [alert textFieldAtIndex:0].placeholder = @"Title";
    [alert textFieldAtIndex:1].placeholder = @"Task";
    [alert textFieldAtIndex:1].secureTextEntry = NO;
    alert.tag = 111;
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    //insert to Realm database
    if (alertView.tag == 111) {
        if (buttonIndex == 1) {
            //fresh insert with textfield text
            UITextField *titleTextField = [alertView textFieldAtIndex:0];
            UITextField *taskTextField = [alertView textFieldAtIndex:1];
            [self insertDataIntoDataBaseWithTitle:titleTextField.text WithTask:taskTextField.text];
        }
    }
    
    //update to Realm datebase
    if (alertView.tag == 222) {
        if (buttonIndex == 1) {
            //take the newly updated textfield texts and pass to update method
            UITextField *titleTextField = [alertView textFieldAtIndex:0];
            UITextField *taskTextField = [alertView textFieldAtIndex:1];
            [self updateDataInDatabase:titleTextField.text WithTask:taskTextField.text];
        }
    }
}

- (void)insertDataIntoDataBaseWithTitle:(NSString *)title WithTask:(NSString *)task {
    RLMRealm *realm = [RLMRealm defaultRealm];
    //begin transaction for Realm
    [realm beginWriteTransaction];
    InfoTable *info = [[InfoTable alloc]init];
    info.title = title;
    info.task = task;
    //insert info object consists of title and task
    [realm addObject:info];
    [realm commitWriteTransaction];
    [_mTableView reloadData];
}

- (void)updateDataInDatabase:(NSString *)title WithTask:(NSString *)task {
    //same idea as the insert
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    //update the selected data object with new data
    selectedDataObject.title = title;
    selectedDataObject.task = task;
    [realm commitWriteTransaction];
    [_mTableView reloadData];
}

//tableView delegate methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [tableDataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    static NSString *cellid = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellid];
    }
    //set up cell
    InfoTable *info = [tableDataArray objectAtIndex:indexPath.row];
    cell.textLabel.text = info.title;
    cell.detailTextLabel.text = info.task;
    cell.backgroundColor = [UIColor clearColor];
    cell.contentView.backgroundColor = [UIColor clearColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    //select the to-be-updated object
    selectedDataObject = [tableDataArray objectAtIndex:indexPath.row];
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Realm Update" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"Cancel", @"Update", nil];
    alert.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
    [alert textFieldAtIndex:0].placeholder = @"Title";
    [alert textFieldAtIndex:1].placeholder = @"Task";
    [alert textFieldAtIndex:1].secureTextEntry = NO;
    [alert textFieldAtIndex:0].text = selectedDataObject.title;
    [alert textFieldAtIndex:1].text = selectedDataObject.task;
    alert.tag = 222;
    [alert show];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    if(editingStyle == UITableViewCellEditingStyleDelete) {
        //delete Realm object at indexPath.row
        [[RLMRealm defaultRealm] beginWriteTransaction];
        [[RLMRealm defaultRealm] deleteObject:[tableDataArray objectAtIndex:indexPath.row]];
        [[RLMRealm defaultRealm] commitWriteTransaction];
        tableDataArray = [InfoTable allObjects];
        //enable row deletion animation
        [_mTableView deleteRowsAtIndexPaths:[NSMutableArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [_mTableView setEditing:NO animated:YES];
    }
}

- (IBAction)didTapDeleteBtn:(id)sender {
    //toggle setEditing
    if(_toggle == false) {
        [_mTableView setEditing:YES animated:YES];
    }
    if(_toggle == true) {
        [_mTableView setEditing:NO animated:YES];
    }
    self.toggle = !_toggle;
}

- (IBAction)didTapDeleteAllBtn:(id)sender {
    //delete all objects in the Realm database
    [[RLMRealm defaultRealm] beginWriteTransaction];
    [[RLMRealm defaultRealm] deleteAllObjects];
    [[RLMRealm defaultRealm] commitWriteTransaction];
    [_mTableView reloadData];
}
@end


