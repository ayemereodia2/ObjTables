//
//  DetailsViewController2.h
//  ObjTables
//
//  Created by mac on 9/14/18.
//  Copyright © 2018 bergerpaint. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailsViewController2 : UIViewController<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, weak) IBOutlet UIButton *buttonOne;
@property (nonatomic, strong) IBOutlet UITableView *sampletable;
-(IBAction) gotoBackBtnClicked:(id)sender;
@end
