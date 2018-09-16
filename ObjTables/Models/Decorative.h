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
-(id)initWithValues:(NSString*)paintName description:(NSString*)value imagepath:(NSString*)path;
@property (nonatomic, copy) NSString *nameOfPaint;
@property (nonatomic,copy) NSString *DescriptionOfPaint;
@property (nonatomic,copy) NSString *ImagePath;

@end
