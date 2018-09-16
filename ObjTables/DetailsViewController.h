//
//  DetailsViewController.h
//  ObjTables
//
//  Created by mac on 9/10/18.
//  Copyright © 2018 bergerpaint. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailsViewController :UIViewController<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, weak) IBOutlet UIButton *buttonOne;
@property (nonatomic, strong) IBOutlet UITableView *sampletable;
-(IBAction) gotoBackBtnClicked:(id)sender;
@end
