//
//  MapPin.m
//  ObjTables
//
//  Created by mac on 9/13/18.
//  Copyright © 2018 bergerpaint. All rights reserved.
//

#import "MapPin.h"
 #import <Contacts/Contacts.h>
@implementation MapPin
@synthesize title,subtitle,coordinate;

- (id)initWithName:(NSString*)name address:(NSString*)address coordinate:(CLLocationCoordinate2D)coordinate {
    if ((self = [super init])) {
        if ([name isKindOfClass:[NSString class]]) {
            self.title = name;
        } else {
            self.title = @"Unknown charge";
        }
        self.subtitle = address;
        self.coordinate = coordinate;
    }
    return self;
}

- (NSString *)title {
    return title;
}

- (NSString *)subtitle {
    return subtitle;
}

- (CLLocationCoordinate2D)coordinate {
    return coordinate;
}
- (MKMapItem*)mapItem {
    NSDictionary *addressDict = @{ CNPostalAddressStreetKey : subtitle};
    
    MKPlacemark *placemark = [[MKPlacemark alloc]
                              initWithCoordinate:self.coordinate
                              addressDictionary:addressDict];
    
    MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
    mapItem.name = self.title;
    
    return mapItem;
}
@end
