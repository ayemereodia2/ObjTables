//
//  SimpleTableViewCell.h
//  ObjTables
//
//  Created by mac on 8/30/18.
//  Copyright © 2018 bergerpaint. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SimpleTableViewCell : UITableViewCell
@property (nonatomic, weak) IBOutlet UILabel *companyName;
@property (nonatomic, weak) IBOutlet UILabel *productTitle;
@property (nonatomic, weak) IBOutlet UIImageView *productImage;

@property (nonatomic, weak) IBOutlet UIButton *buttonOne;
@property (nonatomic, retain) NSString* Key;
@end
