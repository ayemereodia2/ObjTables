//
//  Decorative.m
//  ObjTables
//
//  Created by mac on 9/14/18.
//  Copyright © 2018 bergerpaint. All rights reserved.
//

#import "Decorative.h"

@implementation Decorative
@synthesize nameOfPaint,DescriptionOfPaint,ImagePath;
-(id)initWithValues:(NSString*)paintName description:(NSString*)value imagepath:(NSString*)path{
    self = [super init];
    
    if (self) {
        self.nameOfPaint = paintName;
        self.DescriptionOfPaint = value;
        self.ImagePath = path;
    }
    return self;
}
@end
