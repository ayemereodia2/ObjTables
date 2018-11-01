//
//  ColorsRGB.m
//  ObjTables
//
//  Created by mac on 9/24/18.
//  Copyright © 2018 bergerpaint. All rights reserved.
//

#import "ColorsRGB.h"

@implementation ColorsRGB
@synthesize red,green,blue;//alpha;

-(id)initWithValues:(CGFloat)RED Green:(CGFloat)GREEN Blue:(CGFloat)BLUE{// Alpha:(CGFloat)ALPHA{
    self = [super init];
    
    if (self) {
        self.red = RED;
        self.green = GREEN;
        self.blue = BLUE;
       // self.alpha = ALPHA;
    }
    return self;
}
@end
