//
//  MapViewController.h
//  ObjTables
//
//  Created by mac on 9/13/18.
//  Copyright © 2018 bergerpaint. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "MapPin.h"
@interface MapViewController : UIViewController<MKMapViewDelegate,CLLocationManagerDelegate>{
    MKMapView *mapVIew;
}
- (IBAction)actionStart:(id)sender;
@property (nonatomic, weak) IBOutlet MKMapView *mapView;
@property (nonatomic, strong) IBOutlet UIButton *close;
@property (nonatomic, retain) CLLocationManager* manager;
@end
