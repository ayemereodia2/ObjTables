//
//  CategoryViewController.h
//  ObjTables
//
//  Created by mac on 9/14/18.
//  Copyright © 2018 bergerpaint. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CategoryViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) IBOutlet UITableView *sampletable;
@property (nonatomic, weak) IBOutlet UIButton *buttonOne;
-(IBAction) gotoBackBtnClicked:(id)sender;
@end
