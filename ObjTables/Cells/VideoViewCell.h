//
//  VideoViewCell.h
//  ObjTables
//
//  Created by mac on 9/13/18.
//  Copyright © 2018 bergerpaint. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoViewCell : UITableViewCell
@property (nonatomic, weak) IBOutlet UILabel *productTitle;
@property (nonatomic, weak) IBOutlet UIImageView *productImage;

@property (nonatomic, weak) IBOutlet UIButton *buttonOne;
//@property (nonatomic, weak) IBOutlet UIButton *backButton;

@end
