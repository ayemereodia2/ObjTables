//
//  MapViewController.m
//  ObjTables
//
//  Created by mac on 9/13/18.
//  Copyright © 2018 bergerpaint. All rights reserved.
//

#import "MapViewController.h"
#import "MapPin.h"
@interface MapViewController ()

@end
#define METERS_PER_MILE 1609.344
@implementation MapViewController
@synthesize mapView = _mapView;
@synthesize manager = _manager;
- (void)viewDidLoad {
    [super viewDidLoad];
    
     _manager = [[CLLocationManager alloc]init];
    _manager.delegate = self;
    self.mapView.delegate = self;
    
    _manager.desiredAccuracy = kCLLocationAccuracyBest;
    [_manager requestAlwaysAuthorization ];
    [self.navigationController setNavigationBarHidden:YES ];
    MKCoordinateRegion region = {{0.0,0.0}, {0.0,0.0}};
    region.center.latitude = 40.707184; //6.432927;
    region.center.longitude= -73.998392;//3.425844;
    region.span.longitudeDelta = 0.01f;
    region.span.latitudeDelta = 0.01f;
    [mapVIew setRegion:region animated:YES];
    
    MapPin *ann = [[MapPin alloc]init];
    ann.title = @"Alat Office";
    ann.subtitle = @"Technology Head Quarter for Wema Bank Plc, #54 Marina Street, Lagos Island";
    ann.coordinate = region.center;
    [mapVIew addAnnotation:ann];
    NSArray *ns = [NSArray arrayWithObjects:ann, nil];

    [mapVIew showAnnotations:ns animated:YES];
    mapVIew.mapType = MKMapTypeStandard;
//    MKMapPoint annotationPoint = MKMapPointForCoordinate(mapView.userLocation.coordinate);
//    MKMapRect zoomRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0.1, 0.1);
    
    // Do any additional setup after loading the view.
}
- (IBAction)actionStart:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    
    // 1
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = 6.432927;//39.281516;
    zoomLocation.longitude= 3.425844;//-76.580806;
    
    
    // 2
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 0.5*METERS_PER_MILE, 0.5*METERS_PER_MILE);
    viewRegion.span.latitudeDelta = 0.01f;
    viewRegion.span.longitudeDelta = 0.01f;
    
    // 3
    [_mapView setRegion:viewRegion animated:YES];
    
        MapPin *ann = [[MapPin alloc]init];
        ann.title = @"Alat Office";
        ann.subtitle = @"Technology Head Quarter for Wema Bank Plc, #54 Marina Street, Lagos Island";
        ann.coordinate = zoomLocation;
        [_mapView addAnnotation:ann];
    
        //NSArray *ns = [NSArray arrayWithObjects:ann, nil];
    
    
    //[self mapView:mapVIew viewForAnnotation:ann];

   //[mapVIew showAnnotations:ns animated:YES];
    
//    _manager = [[CLLocationManager alloc]init];
//    _manager.delegate = self;
//    self.mapView.delegate = self;
//
//    _manager.desiredAccuracy = kCLLocationAccuracyBest;
//    [_manager requestAlwaysAuthorization ];
//    [self.navigationController setNavigationBarHidden:YES ];
//    MKCoordinateRegion region = {{0.0,0.0}, {0.0,0.0}};
//    region.center.latitude = 40.707184; //6.432927;
//    region.center.longitude= -73.998392;//3.425844;
//    region.span.longitudeDelta = 0.01f;
//    region.span.latitudeDelta = 0.01f;
//    [mapVIew setRegion:region animated:YES];
//
//    MapPin *ann = [[MapPin alloc]init];
//    ann.title = @"Alat Office";
//    ann.subtitle = @"Technology Head Quarter for Wema Bank Plc, #54 Marina Street, Lagos Island";
//    ann.coordinate = region.center;
//    [mapVIew addAnnotation:ann];
//    NSArray *ns = [NSArray arrayWithObjects:ann, nil];
//
//    [mapVIew showAnnotations:ns animated:YES];
//    mapVIew.mapType = MKMapTypeStandard;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
//    static NSString *identifier = @"MapPin";
//    if ([annotation isKindOfClass:[MapPin class]]) {
//        
//        MKAnnotationView *annotationView = (MKAnnotationView *) [_mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
//        if (annotationView == nil) {
//            annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
//            annotationView.enabled = YES;
//            annotationView.canShowCallout = YES;
//           // annotationView.image = [UIImage imageNamed:@"arrest.png"];//here we use a nice image instead of the default pins
//        } else {
//            annotationView.annotation = annotation;
//        }
//        
//        return annotationView;
//    }
//    
//    return nil;
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
