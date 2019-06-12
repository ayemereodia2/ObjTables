//
//  WelcomeViewCell2.m
//  ObjTables
//
//  Created by mac on 3/18/19.
//  Copyright © 2019 bergerpaint. All rights reserved.
//

#import "WelcomeViewCell2.h"

@implementation WelcomeViewCell2

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) showViewCommand:(BOOL)result
{
    self.overflowView.hidden = result;
}

@end
