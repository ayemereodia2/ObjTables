//
//  PaintViewCell.h
//  ObjTables
//
//  Created by mac on 9/21/18.
//  Copyright © 2018 bergerpaint. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cardview.h"
@interface PaintViewCell : UICollectionViewCell
@property (nonatomic,weak) IBOutlet UILabel* title;
@property (nonatomic,weak) IBOutlet cardview* viewer;

@end
