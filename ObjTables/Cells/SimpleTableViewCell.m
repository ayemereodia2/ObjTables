//
//  SimpleTableViewCell.m
//  ObjTables
//
//  Created by mac on 8/30/18.
//  Copyright © 2018 bergerpaint. All rights reserved.
//

#import "SimpleTableViewCell.h"

@implementation SimpleTableViewCell

@synthesize companyName = _companyName;
@synthesize productTitle = _productTitle;
@synthesize productImage = _productImage;
@synthesize buttonOne = _buttonOne;
@synthesize Key = _Key;


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backgroundColor = UIColor.clearColor;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
