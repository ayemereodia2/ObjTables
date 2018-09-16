//
//  SelectVisualizerTypeController.h
//  ObjTables
//
//  Created by mac on 9/13/18.
//  Copyright © 2018 bergerpaint. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectVisualizerTypeController : UIViewController<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) IBOutlet UITableView *sampletable;
-(IBAction)gotoBackBtnClicked:(id)sender;
@property (nonatomic, weak) IBOutlet UIButton *buttonOne;

//@property (nonatomic, retain) NSArray *array;
@end
