//
//  NonDecorative.h
//  ObjTables
//
//  Created by mac on 9/14/18.
//  Copyright © 2018 bergerpaint. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NonDecorative : NSObject{
    NSString *nameOfPaint;
    NSString *DescriptionOfPaint;
}
-(id)initWithValues:(NSString*)paintName description:(NSString*)value;
@property (nonatomic, copy) NSString *nameOfPaint;
@property (nonatomic,copy) NSString *DescriptionOfPaint;
@end
