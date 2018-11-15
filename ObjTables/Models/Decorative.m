//
//  Decorative.m
//  ObjTables
//
//  Created by mac on 9/14/18.
//  Copyright © 2018 bergerpaint. All rights reserved.
//

#import "Decorative.h"

@implementation Decorative
@synthesize nameOfPaint,DescriptionOfPaint,ImagePath,TouchDryTime,HardDryTime,AreaOfUse,CoverageCapacity;
-(id)initWithValues:(NSString*)paintName description:(NSString*)value imagepath:(NSString*)path TDT:(NSString*)TouchDryTime HDT:(NSString*)HardDryTime AREOU:(NSString*)AreaOfUse CC:(NSString*)CoverageCapacity{
    self = [super init];
    
    if (self) {
        self.nameOfPaint = paintName;
        self.DescriptionOfPaint = value;
        self.ImagePath = path;
        self.TouchDryTime = TouchDryTime;
        self.HardDryTime = HardDryTime;
        self.AreaOfUse = AreaOfUse;
        self.CoverageCapacity = CoverageCapacity;
    
    }
    return self;
}

-(NSDictionary *)dictionary {
    return [NSDictionary dictionaryWithObjectsAndKeys:self.nameOfPaint,@"nameOfPaint",self.DescriptionOfPaint,    @"DescriptionOfPaint",self.ImagePath, @"ImagePath", self.TouchDryTime, @"TouchDryTime", self.HardDryTime, @"HardDryTime", self.AreaOfUse,@"AreaOfUse", self.CoverageCapacity,@"CoverageCapacity", nil];
}
@end
