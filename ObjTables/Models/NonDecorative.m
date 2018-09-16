//
//  NonDecorative.m
//  ObjTables
//
//  Created by mac on 9/14/18.
//  Copyright © 2018 bergerpaint. All rights reserved.
//

#import "NonDecorative.h"

@implementation NonDecorative
@synthesize nameOfPaint,DescriptionOfPaint;
-(id)initWithValues:(NSString*)paintName description:(NSString*)value{
    self = [super init];
    
    if (self) {
        self.nameOfPaint = paintName;
        self.DescriptionOfPaint = value;
    }
    return self;
}
@end
