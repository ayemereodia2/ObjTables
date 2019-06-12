//
//  DashViewController.h
//  ObjTables
//
//  Created by mac on 3/18/19.
//  Copyright © 2019 bergerpaint. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DashViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) IBOutlet UITableView *NewDashboardTable;
@property (nonatomic, strong) UIAlertController *alertVC;

@end

NS_ASSUME_NONNULL_END
