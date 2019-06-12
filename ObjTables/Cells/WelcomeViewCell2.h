//
//  WelcomeViewCell2.h
//  ObjTables
//
//  Created by mac on 3/18/19.
//  Copyright © 2019 bergerpaint. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WelcomeViewCell2 : UITableViewCell
@property (nonatomic, weak) IBOutlet UIButton *optionsButton;
@property (nonatomic, weak) IBOutlet UIView *overflowView;


-(void) showViewCommand:(BOOL)result;
@end

NS_ASSUME_NONNULL_END
