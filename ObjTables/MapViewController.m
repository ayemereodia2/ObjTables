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

    //[mapVIew showAnnotations:ns animated:YES];
    mapVIew.mapType = MKMapTypeStandard;
//    MKMapPoint annotationPoint = MKMapPointForCoordinate(mapView.userLocation.coordinate);
//    MKMapRect zoomRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0.1, 0.1);
    
    // Do any additional setup after loading the view.
}
- (IBAction)actionStart:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    
    CLLocationCoordinate2D zoomLocation0;
    zoomLocation0.latitude = 8.6753;//39.281516;
    zoomLocation0.longitude= 9.0820;
    
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation0, 0.5*METERS_PER_MILE, 0.5*METERS_PER_MILE);
    
    [_mapView setCenterCoordinate:zoomLocation0 animated:YES];
    viewRegion.span.latitudeDelta = 0.0275f;
    viewRegion.span.longitudeDelta = 0.0275f;
    
    // 3
    [_mapView regionThatFits:viewRegion];

    [_mapView setRegion:viewRegion animated:YES];
    
    
    // 1
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = 5.128333;//39.281516;
    zoomLocation.longitude= 7.360562;//-76.580806;
    // 2
  
    
    
        MapPin *ann = [[MapPin alloc]init];
        ann.title = @"Abia State";
        ann.subtitle = @"128 Aba Owerri Road, beside Kemjika Filling Station, Abia State";
        ann.coordinate = zoomLocation;
        //[_mapView addAnnotation:ann];

//
    CLLocationCoordinate2D zoomLocation1;
    zoomLocation1.latitude = 7.167938;
    zoomLocation1.longitude= 3.372688;

    MapPin *ann1 = [[MapPin alloc]init];
    ann1.title = @"Ogun State";
    ann1.subtitle = @"Laffro house, beside Hasan Furniture, Moshood Abiola way, Abeokuta";
    ann1.coordinate = zoomLocation1;
    
    
    CLLocationCoordinate2D zoomLocation2;
    zoomLocation2.latitude = 7.167938;
    zoomLocation2.longitude= 3.372688;
    
    MapPin *ann2 = [[MapPin alloc]init];
    ann2.title = @"Abuja";
    ann2.subtitle = @"748, Alenxandria Crescent, Wuse 11, Behind Barnex Plaza, F.C.T. Abuja";
    ann2.coordinate = zoomLocation2;
    
    //START
    CLLocationCoordinate2D zoomLocation3;
    zoomLocation3.latitude = 9.0805665;
    zoomLocation3.longitude= 7.4664779;
    
    MapPin *ann3 = [[MapPin alloc]init];
    ann3.title = @"Abuja";
    ann3.subtitle = @"Barrister place,Tomatoes junction Deidei FCT";
    ann3.coordinate = zoomLocation3;
    
    CLLocationCoordinate2D zoomLocation4;
    zoomLocation4.latitude = 7.263499;
    zoomLocation4.longitude= 5.17775;
    
    MapPin *ann4 = [[MapPin alloc]init];
    ann4.title = @"Ondo";
    ann4.subtitle = @"102 Oyemekun rd, opposite Oyemekun Grammar School, Akure";
    ann4.coordinate = zoomLocation4;
    
    CLLocationCoordinate2D zoomLocation5;
    zoomLocation5.latitude = 6.205473;
    zoomLocation5.longitude= 6.721556;
    
    MapPin *ann5 = [[MapPin alloc]init];
    ann5.title = @"Delta";
    ann5.subtitle = @"379, Nnebisi Road. Asaba";
    ann5.coordinate = zoomLocation5;
    
    CLLocationCoordinate2D zoomLocation6;
    zoomLocation6.latitude = 6.2219079;
    zoomLocation6.longitude= 7.0868439;
    
    MapPin *ann6 = [[MapPin alloc]init];
    ann6.title = @"Anambra";
    ann6.subtitle = @"Km 20 Enugu / Onitsha Express Road, opp. Crunches Eatery, Unizik Junction, Awka";
    ann6.coordinate = zoomLocation6;
    
    
    CLLocationCoordinate2D zoomLocation7;
    zoomLocation7.latitude = 6.3280757;
    zoomLocation7.longitude= 5.6403479;
    
    MapPin *ann7 = [[MapPin alloc]init];
    ann7.title = @"Edo";
    ann7.subtitle = @"134, Murtala Mohammed Way, Benin City, Edo State";
    ann7.coordinate = zoomLocation7;
    
    CLLocationCoordinate2D zoomLocation8;
    zoomLocation8.latitude = 4.989819;
    zoomLocation8.longitude= 8.333496;
    
    MapPin *ann8 = [[MapPin alloc]init];
    ann8.title = @"Cross-River";
    ann8.subtitle = @"14, Murtala Mohammed Way, Calabar.";
    ann8.coordinate = zoomLocation8;
    
    
    CLLocationCoordinate2D zoomLocation9;
    zoomLocation9.latitude = 4.9850992;
    zoomLocation9.longitude= 8.3373497;
    
    MapPin *ann9 = [[MapPin alloc]init];
    ann9.title = @"Cross-Rivers2";
    ann9.subtitle = @"Plot 214, First Avenue State Housing Estate, Calabar";
    ann9.coordinate = zoomLocation9;
    
    
    CLLocationCoordinate2D zoomLocation10;
    zoomLocation10.latitude = 7.6554983;
    zoomLocation10.longitude= 5.2296964;
    
    MapPin *ann10 = [[MapPin alloc]init];
    ann10.title = @"Ekiti";
    ann10.subtitle = @"MBM Ajitadidun Estate, Along Adebayo Road. Ado Ekiti";
    ann10.coordinate = zoomLocation10;
    
    
    CLLocationCoordinate2D zoomLocation11;
    zoomLocation11.latitude = 6.461811;
    zoomLocation11.longitude= 7.504001;
    
    MapPin *ann11 = [[MapPin alloc]init];
    ann11.title = @"Enugu";
    ann11.subtitle = @"33, Abakaliki Road, G.R.A, Enugu";
    ann11.coordinate = zoomLocation11;
    
    
    CLLocationCoordinate2D zoomLocation12;
    zoomLocation12.latitude = 7.3565553;
    zoomLocation12.longitude= 3.8702913;
    
    MapPin *ann12 = [[MapPin alloc]init];
    ann12.title = @"Oyo";
    ann12.subtitle = @"1, Azeez Aina Street, Off Ring Road, Ibadan, Oyo State";
    ann12.coordinate = zoomLocation12;
    
    
    CLLocationCoordinate2D zoomLocation13;
    zoomLocation13.latitude = 7.352486;
    zoomLocation13.longitude= 3.824015;
    
    MapPin *ann13 = [[MapPin alloc]init];
    ann13.title = @"Oyo2";
    ann13.subtitle = @"Abu Plaza,Elebu Market road, off Akala express, Elebu Oluyole extension, Ibadan";
    ann13.coordinate = zoomLocation13;
    
    
    CLLocationCoordinate2D zoomLocation14;
    zoomLocation14.latitude = 7.4044204;
    zoomLocation14.longitude=3.9441713;
    
    MapPin *ann14 = [[MapPin alloc]init];
    ann14.title = @"Oyo3";
    ann14.subtitle = @"Inside Debistol oil, Olopomeji busstop, Opp wetlands hotel, Akobo, Ibadan";
    ann14.coordinate = zoomLocation14;
    
    
    CLLocationCoordinate2D zoomLocation15;
    zoomLocation15.latitude = 6.4686529;
    zoomLocation15.longitude= 3.4923618;
    
    MapPin *ann15 = [[MapPin alloc]init];
    ann15.title = @"Lagos2";
    ann15.subtitle = @"Km 30, Lagos Epe Expressway Casia Estate, Abijo GRA";
    ann15.coordinate = zoomLocation15;
    
    
    CLLocationCoordinate2D zoomLocation16;
    zoomLocation16.latitude = 8.4514072;
    zoomLocation16.longitude= 4.5806123;
    
    MapPin *ann16 = [[MapPin alloc]init];
    ann16.title = @"Kwara";
    ann16.subtitle = @"4 Ifelodun Street, Off Asa Dam Road, Offa Garage, Ilorin";
    ann16.coordinate = zoomLocation16;
    
    
    CLLocationCoordinate2D zoomLocation17;
    zoomLocation17.latitude = 6.605269;
    zoomLocation17.longitude= 3.3478667;
    
    MapPin *ann17 = [[MapPin alloc]init];
    ann17.title = @"Lagos3";
    ann17.subtitle = @"No.16, Tos Benson Road (Former Beach Road), Ebute Ikorodu, Lagos";
    ann17.coordinate = zoomLocation17;
    
    
    CLLocationCoordinate2D zoomLocation18;
    zoomLocation18.latitude = 9.9051133;
    zoomLocation18.longitude= 8.891676;
    
    MapPin *ann18 = [[MapPin alloc]init];
    ann18.title = @"Jos";
    ann18.subtitle = @"1A, Constitution Hill Road, Opposite Pirelli tyres, Joys, Plateau State";
    ann18.coordinate = zoomLocation18;
    
    
    
    CLLocationCoordinate2D zoomLocation19;
    zoomLocation19.latitude = 10.4861451;
    zoomLocation19.longitude= 7.4160316;
    
    MapPin *ann19 = [[MapPin alloc]init];
    ann19.title = @"Kaduna";
    ann19.subtitle = @"1440, Kachia Road, Kaduna, Kaduna State.";
    ann19.coordinate = zoomLocation19;
    
    
    CLLocationCoordinate2D zoomLocation20;
    zoomLocation20.latitude = 11.9832844;
    zoomLocation20.longitude= 8.5429084;
    
    MapPin *ann20 = [[MapPin alloc]init];
    ann20.title = @"Kano";
    ann20.subtitle = @"4, Ajasa Street, Off Civic Centre Road, Kano State.";
    ann20.coordinate = zoomLocation20;
    
    
    CLLocationCoordinate2D zoomLocation21;
    zoomLocation21.latitude = 6.605269;
    zoomLocation21.longitude= 3.3478667;
    
    MapPin *ann21 = [[MapPin alloc]init];
    ann21.title = @"Lagos4";
    ann21.subtitle = @"91, Allen Avenue, Ikeja Lagos";
    ann21.coordinate = zoomLocation21;
    
    
    CLLocationCoordinate2D zoomLocation22;
    zoomLocation22.latitude = 6.6010673;
    zoomLocation22.longitude=  3.3364635;
    
    MapPin *ann22 = [[MapPin alloc]init];
    ann22.title = @"Lagos5";
    ann22.subtitle = @"102, Oba Akran Avenue, Ikeja Industrial Estate";
    ann22.coordinate = zoomLocation22;
    
    
    CLLocationCoordinate2D zoomLocation23;
    zoomLocation23.latitude = 6.605269;
    zoomLocation23.longitude= 3.3478667;
    
    MapPin *ann23 = [[MapPin alloc]init];
    ann23.title = @"Lagos";
    ann23.subtitle = @"Berger place, along Lagos Ibadan expressway behind Lagos state Accident & Emergency centre";
    ann23.coordinate = zoomLocation23;
    
    
    CLLocationCoordinate2D zoomLocation24;
    zoomLocation24.latitude = 6.605269;
    zoomLocation24.longitude= 3.3478667;
    
    MapPin *ann24 = [[MapPin alloc]init];
    ann24.title = @"Lagos5";
    ann24.subtitle = @"Adenekan Mega Plaza, No 1 Adenekan street opposite Access Bank, Okota road, Isolo";
    ann24.coordinate = zoomLocation24;
    
    
    CLLocationCoordinate2D zoomLocation25;
    zoomLocation25.latitude = 6.4686529;
    zoomLocation25.longitude= 3.4923618;
    
    MapPin *ann25 = [[MapPin alloc]init];
    ann25.title = @"Lekki,Lagos2";
    ann25.subtitle = @"Km 16, Lekki Epe Expressway Agungi/Osapa Bus Stop";
    ann25.coordinate = zoomLocation25;
    
    
    
    CLLocationCoordinate2D zoomLocation26;
    zoomLocation26.latitude = 11.902102;
    zoomLocation26.longitude= 13.08546;
    
    MapPin *ann26 = [[MapPin alloc]init];
    ann26.title = @"Borno";
    ann26.subtitle = @"105, Baga Road, Maiduguri, Borno State";
    ann26.coordinate = zoomLocation26;
    
    
    CLLocationCoordinate2D zoomLocation27;
    zoomLocation27.latitude = 7.089792;
    zoomLocation27.longitude= 7.657574;
    
    MapPin *ann27 = [[MapPin alloc]init];
    ann27.title = @"Benue";
    ann27.subtitle = @"Tonimas Plaza, by Railway Crossing, Old Otukpo Road, Benue State";
    ann27.coordinate = zoomLocation27;
    
    
    CLLocationCoordinate2D zoomLocation28;
    zoomLocation28.latitude = 7.769292;
    zoomLocation28.longitude= 8.561354;
    
    MapPin *ann28 = [[MapPin alloc]init];
    ann28.title = @"Benue 2";
    ann28.subtitle = @"Beside tilley Gydao College, Makurdi -Lafia Road, North Bank, Makurdi, Benue State";
    ann28.coordinate = zoomLocation28;
    
    
    
    CLLocationCoordinate2D zoomLocation29;
    zoomLocation29.latitude = 9.603431;
    zoomLocation29.longitude= 6.56331;
    
    MapPin *ann29 = [[MapPin alloc]init];
    ann29.title = @"Niger";
    ann29.subtitle = @"SM3, Ahamadu Bahago Plaza, Tunga, Minna";
    ann29.coordinate = zoomLocation29;
    
    
    CLLocationCoordinate2D zoomLocation30;
    zoomLocation30.latitude = 11.0860104;
    zoomLocation30.longitude= 7.716289;
    
    MapPin *ann30 = [[MapPin alloc]init];
    ann30.title = @"Nassarawa";
    ann30.subtitle = @"Pentagon Plaza, Bukan Sidi, beside Investment House, Jos Road, Lafia";
    ann30.coordinate = zoomLocation30;
    
    
    
    CLLocationCoordinate2D zoomLocation31;
    zoomLocation31.latitude = 6.151028;
    zoomLocation31.longitude= 6.802582;
    
    MapPin *ann31 = [[MapPin alloc]init];
    ann31.title = @"Anambra 2";
    ann31.subtitle = @"Akwa Road, Onitsha, Anambra State";
    ann31.coordinate = zoomLocation31;
    
    
    CLLocationCoordinate2D zoomLocation32;
    zoomLocation32.latitude = 6.2219079;
    zoomLocation32.longitude= 7.0868439;
    
    MapPin *ann32 = [[MapPin alloc]init];
    ann32.title = @"Imo";
    ann32.subtitle = @"No 35 blossom Plaza, Onitsha, Owerri Road, Nnewi";
    ann32.coordinate = zoomLocation32;
    
    
    CLLocationCoordinate2D zoomLocation33;
    zoomLocation33.latitude = 7.8242904;
    zoomLocation33.longitude= 4.5883262;
    
    MapPin *ann33 = [[MapPin alloc]init];
    ann33.title = @"Osun";
    ann33.subtitle = @"306, Ikirun road, Beside Iyana camp opp.NNPC, Ota Efun, Ikirun Road, Oshogbo";
    ann33.coordinate = zoomLocation33;
    
    
    
    CLLocationCoordinate2D zoomLocation34;
    zoomLocation34.latitude = 5.4839214;
    zoomLocation34.longitude= 7.0145165;
    
    MapPin *ann34 = [[MapPin alloc]init];
    ann34.title = @"Imo 2";
    ann34.subtitle = @"51/65 Mbaise Road, by Wetheral/Fire Service Roundabout. Owerri";
    ann34.coordinate = zoomLocation34;
    
    
    CLLocationCoordinate2D zoomLocation35;
    zoomLocation35.latitude = 4.8446588;
    zoomLocation35.longitude= 7.0382423;
    
    MapPin *ann35 = [[MapPin alloc]init];
    ann35.title = @"Rivers";
    ann35.subtitle = @"No 42 Old Aba Road by Artillery Junction Portharcourt";
    ann35.coordinate = zoomLocation35;
    
    
    CLLocationCoordinate2D zoomLocation36;
    zoomLocation36.latitude = 4.843555;
    zoomLocation36.longitude= 7.0383416;
    
    MapPin *ann36 = [[MapPin alloc]init];
    ann36.title = @"Rivers 2";
    ann36.subtitle = @"70, Ordinance Road, Trans Amadi Industrial Estate, Portharcourt";
    ann36.coordinate = zoomLocation36;
    
    CLLocationCoordinate2D zoomLocation37;
    zoomLocation37.latitude = 13.0543789;
    zoomLocation37.longitude= 5.1625844;
    
    MapPin *ann37 = [[MapPin alloc]init];
    ann37.title = @"Sokoto";
    ann37.subtitle = @"13,Ahmadu Bello way, Sokoto";
    ann37.coordinate = zoomLocation37;
    
    
    CLLocationCoordinate2D zoomLocation38;
    zoomLocation38.latitude = 5.586068;
    zoomLocation38.longitude= 5.7796854;
    
    MapPin *ann38 = [[MapPin alloc]init];
    ann38.title = @"Delta";
    ann38.subtitle = @"111, Warri-Effurun Road, Warri, Delta State";
    ann38.coordinate = zoomLocation38;
    
    
    CLLocationCoordinate2D zoomLocation39;
    zoomLocation39.latitude = 5.5691557;
    zoomLocation39.longitude= 5.7283273;
    
    MapPin *ann39 = [[MapPin alloc]init];
    ann39.title = @"Delta 2";
    ann39.subtitle = @"Km 5, Refinery Road,Warri,Delta State";
    ann39.coordinate = zoomLocation39;
    
    
    CLLocationCoordinate2D zoomLocation40;
    zoomLocation40.latitude = 5.586068;
    zoomLocation40.longitude= 5.7796854;
    
    MapPin *ann40 = [[MapPin alloc]init];
    ann40.title = @"Delta 3";
    ann40.subtitle = @"Km 2,Okpe road, Osubi behind victory joe filling station, Delta State";
    ann40.coordinate = zoomLocation40;
    
    
    
    CLLocationCoordinate2D zoomLocation41;
    zoomLocation41.latitude = 5.0534452;
    zoomLocation41.longitude= 7.8785121;
    
    MapPin *ann41 = [[MapPin alloc]init];
    ann41.title = @"Akwa-Ibom";
    ann41.subtitle = @"No 51,Ikot Ekpene Road, Uyo";
    ann41.coordinate = zoomLocation41;
    
    
    
//    CLLocationCoordinate2D zoomLocation42;
//    zoomLocation42.latitude = 7.167938;
//    zoomLocation42.longitude= 3.372688;
//
//    MapPin *ann43 = [[MapPin alloc]init];
//    ann43.title = @"Abuja";
//    ann43.subtitle = @"Keana house,3 Lagos crescent Garki 2 FCT Abuja";
//    ann43.coordinate = zoomLocation42;
//
//
//    CLLocationCoordinate2D zoomLocation44;
//    zoomLocation44.latitude = 7.167938;
//    zoomLocation44.longitude= 3.372688;
//
//    MapPin *ann44 = [[MapPin alloc]init];
//    ann44.title = @"Abuja";
//    ann44.subtitle = @"748, Alenxandria Crescent, Wuse 11, Behind Barnex Plaza, F.C.T. Abuja";
//    ann44.coordinate = zoomLocation44;
    
    CLLocationCoordinate2D zoomLocation45;
    zoomLocation45.latitude = 9.0805665;
    zoomLocation45.longitude= 7.4664779;
    
    MapPin *ann45 = [[MapPin alloc]init];
    ann45.title = @"Abuja";
    ann45.subtitle = @"Keana house,3 Lagos crescent Garki 2 FCT Abuja";
    ann45.coordinate = zoomLocation45;
    
    CLLocationCoordinate2D zoomLocation46;
    zoomLocation46.latitude = 9.217861;
    zoomLocation46.longitude= 7.189803;
    
    MapPin *ann46 = [[MapPin alloc]init];
    ann46.title = @"Niger";
    ann46.subtitle = @"Shop No 8, Kwakwansh Plaza, opposite Mohafiya Filling Station Mandalla Road, Suleja, Niger State";
    ann46.coordinate = zoomLocation46;
    
    
    CLLocationCoordinate2D zoomLocation47;
    zoomLocation47.latitude = 6.4686529;
    zoomLocation47.longitude= 3.4923618;
    
    MapPin *ann47 = [[MapPin alloc]init];
    ann47.title = @"Lekki,Lagos1";
    ann47.subtitle = @"Lekki Garent plaza Km 17/18,Lekki - Epe expressway, Igbo - Efon b/stop, Lekki";
    ann47.coordinate = zoomLocation47;
    
  
    NSArray *ns = [NSArray arrayWithObjects:ann, ann1,ann2,ann3,ann4,ann5,ann6,ann7,ann8,ann9,ann10,ann11,ann12,ann13,ann14,ann15,ann16,ann17,ann18,ann19,ann20,ann21,ann22,ann23,ann24,ann25,ann26,ann27,ann2,ann28,ann29,ann30,ann31,ann32,ann33,ann34,ann35,ann36,ann37,ann38,ann39,ann40,ann41,ann45,ann46,ann47, nil];

    [_mapView addAnnotations:ns];
    
    
    
    
    
    
    
    
    
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
