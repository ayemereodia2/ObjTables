//
//  ShowDetailsViewController.h
//  ObjTables
//
//  Created by mac on 11/11/18.
//  Copyright © 2018 bergerpaint. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Models/Decorative.h"
NS_ASSUME_NONNULL_BEGIN

@interface ShowDetailsViewController :  UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) IBOutlet UITableView *detailviewtable;
-(IBAction)goBackBtnClicked:(id)sender;
@property (nonatomic,weak) IBOutlet UILabel* Headerdescription;
@property(nonatomic, retain) Decorative *decorate;
//- (id)initWithDecor:(Decorative *)decor;

@end

NS_ASSUME_NONNULL_END
