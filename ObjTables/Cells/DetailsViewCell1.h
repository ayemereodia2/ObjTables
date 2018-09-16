//
//  DetailsViewCell1.h
//  ObjTables
//
//  Created by mac on 9/14/18.
//  Copyright © 2018 bergerpaint. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailsViewCell1 : UITableViewCell
//@property NSString *title;
@property (nonatomic,weak) IBOutlet UILabel* title;
@property (nonatomic,weak) IBOutlet UILabel* subdescription;

@end
