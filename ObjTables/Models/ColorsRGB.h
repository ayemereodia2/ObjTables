//
//  ColorsRGB.h
//  ObjTables
//
//  Created by mac on 9/24/18.
//  Copyright © 2018 bergerpaint. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface ColorsRGB : NSObject{
    CGFloat red;
    CGFloat green;
    CGFloat blue;
   // CGFloat alpha;

}
-(id)initWithValues:(CGFloat )RED Green:(CGFloat)GREEN Blue:(CGFloat)BLUE;// Alpha:(CGFloat)ALPHA;
@property const CGFloat red;
@property const CGFloat green;
@property const CGFloat blue;
//@property const CGFloat alpha;

@end
