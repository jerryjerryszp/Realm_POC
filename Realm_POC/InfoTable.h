//
//  InfoTable.h
//  Realm_POC
//
//  Created by Jerry Shi on 2018-09-14.
//  Copyright © 2018 Jerry Shi. All rights reserved.
//

#import "RLMObject.h"
#import <UIKit/UIKit.h>
#import <Realm/Realm.h>

@interface InfoTable : RLMObject

//Add two columns to the Realm Database
@property NSString *title;
@property NSString *task;

@end
