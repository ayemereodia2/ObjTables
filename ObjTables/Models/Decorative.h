//
//  Decorative.h
//  ObjTables
//
//  Created by mac on 9/14/18.
//  Copyright © 2018 bergerpaint. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Decorative : NSObject{
    NSString *nameOfPaint;
    NSString *DescriptionOfPaint;
    NSString *ImagePath;
}
-(id)initWithValues:(NSString*)paintName description:(NSString*)value imagepath:(NSString*)path TDT:(NSString*)TouchDryTime HDT:(NSString*)HardDryTime AREOU:(NSString*)AreaOfUse CC:(NSString*)CoverageCapacity;
@property (nonatomic, copy) NSString *nameOfPaint;
@property (nonatomic,copy) NSString *DescriptionOfPaint;
@property (nonatomic,copy) NSString *ImagePath;
@property (nonatomic,copy) NSString *TouchDryTime;
@property (nonatomic,copy) NSString *HardDryTime;
@property (nonatomic,copy) NSString *AreaOfUse;
@property (nonatomic,copy) NSString *CoverageCapacity;

-(NSDictionary *)dictionary;

@end
