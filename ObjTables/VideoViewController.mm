//
//  VideoViewController.m
//  ObjTables
//
//  Created by mac on 9/13/18.
//  Copyright © 2018 bergerpaint. All rights reserved.
//

#import "VideoViewController.h"
#include <opencv2/core/core.hpp>
#include <opencv2/highgui/highgui.hpp>
#include <opencv2/imgproc/imgproc.hpp>
#include <opencv2/videoio/cap_ios.h>
#import "ColorPalleteViewController.h"

@interface VideoViewController ()

@end

@implementation VideoViewController
@synthesize videoCamera;// = _videoCamera;
- (void)SetupCameraWrapper {
    self.videoCamera = [[CvVideoCamera alloc] initWithParentView:imageView];
    self.videoCamera.delegate = self;
    self.videoCamera.defaultAVCaptureDevicePosition = AVCaptureDevicePositionBack;//AVCaptureDevicePositionFront
    //self.videoCamera.defaultAVCaptureSessionPreset = AVCaptureSessionPreset640x480;
    self.videoCamera.defaultAVCaptureSessionPreset = AVCaptureSessionPresetHigh;
    self.videoCamera.defaultAVCaptureVideoOrientation = AVCaptureVideoOrientationPortrait;
    self.videoCamera.defaultFPS = 30;
    self.videoCamera.grayscaleMode = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES ];
    self.videoCamera = [[CvVideoCamera alloc] initWithParentView:imageView];
    self.videoCamera.delegate = self;
    self.videoCamera.defaultAVCaptureDevicePosition = AVCaptureDevicePositionBack;//AVCaptureDevicePositionFront
   // self.videoCamera.defaultAVCaptureSessionPreset = AVCaptureSessionPreset640x480;
    self.videoCamera.defaultAVCaptureSessionPreset = AVCaptureSessionPresetHigh;
    self.videoCamera.defaultAVCaptureVideoOrientation = AVCaptureVideoOrientationPortrait;
    self.videoCamera.defaultFPS = 30;
    self.videoCamera.grayscaleMode = NO;
    //points;
    ;

    [self.videoCamera start];
    [self ShowInstructions];
    // Do any additional setup after loading the view.
}
//-(void)viewWillAppear:(BOOL)animated{
//    [self SetupCameraWrapper];
//    [self.videoCamera start];
//    [self ShowInstructions];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)ShowInstructions {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Instructions"
                                                                   message:@"Simply select a color with the choose color button and touch the parts of the wall you want to paint and tap the Reset button to clear all painting"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

//-(void)viewWillAppear:(BOOL)animated{
//    [self.navigationController setNavigationBarHidden:YES ];
//    [self ShowInstructions];
//
//}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}
- (IBAction)showBerger:(id)sender{
    UIButton *senderBtn = (UIButton *) sender;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    UITableViewController *myNewVC = [storyboard instantiateViewControllerWithIdentifier:@"ColorPalleteViewController"];
    [self.navigationController presentViewController:myNewVC animated:YES completion:nil];
}
-(void)processImage:(cv::Mat&)image;
{
    int lowThreshold = 10.0;
    int ratio = 3;
    int kernel_size = 3;
    cv::Mat src_gray,detected_edges,dst,blurred;
    //std::vector<cv::Mat> channels;
    int ffillMode = 1;
    //int loDiff = 20, upDiff = 20;
    int connectivity = 4;
    int isColor = true;
    bool useMask = false;
    int newMaskVal = 255;
    cv::Mat image0;
    int diff = 10;
    cv::Mat gray;
    
    //    const cv::Scalar RED = cv::Scalar(0, 0, 255);
    //    const cv::Scalar GREEN = cv::Scalar(0, 255, 0);
    //    const cv::Scalar BLUE = cv::Scalar(255, 0, 0);
    //    const cv::Scalar BLACK = cv::Scalar(0, 0, 0);
    //    const cv::Scalar WHITE = cv::Scalar(255, 255, 255);
    //    const cv::Scalar YELLOW = cv::Scalar(0, 255, 255);
    //    const cv::Scalar LIGHT_GRAY = cv::Scalar(100, 100, 100);
    
    //cv::Point seed(285,200);
    
    cv::Point seed(location.x,location.y);
    
    cv::cvtColor(image, gray, COLOR_RGB2GRAY); //step2
    // Apply Gaussian filter to remove small edges
    cv::GaussianBlur(gray, gray,
                     cv::Size(5, 5), 1.2, 1.2);// step3
    cv::threshold(image, image, 25, 60, 3);
    
    cv::Mat edges;
    cv::Mat image1 = image;
    
    cv::Canny(gray,edges, 45, 90,3);
    
    //mask
    cv::Mat mask;
    image.copyTo(image0);
    mask.create(image.rows+2, image.cols+2, CV_8U);///edges to mask input
    mask = Scalar::all(0);
    
    //cv::Mat mask = cv::Mat::zeros(edges.rows + 2, edges.cols + 2, CV_8U);
    
    cv::cvtColor(image, image, cv::COLOR_BGR2RGB);//in-use
    int loDiff = diff, upDiff = diff;
    
    
    int lo = ffillMode == 0 ? 0 : loDiff;
    int up = ffillMode == 0 ? 0 : upDiff;
    int flags = connectivity + (newMaskVal << 8) +
    (ffillMode == 1 ? CV_FLOODFILL_FIXED_RANGE : 0);
    int b =255; //(unsigned)theRNG() & 255;
    int g = 255;//(unsigned)theRNG() & 255;
    int r = 255;//(unsigned)theRNG() & 255;
    cv::Rect ccomp;
    
    //Scalar newVal = isColor ? Scalar(b, g, r) : Scalar(r*0.299 + g*0.587 + b*0.114);
    Scalar newVal = Scalar(r*0.299 + g*0.587 + b*0.114);
    //dilate
    cv::Size size;
    size.height = 3;
    size.width = 3;
    cv::Mat kernel = cv::getStructuringElement(cv::MORPH_RECT, size);
    double alpha = 0.5;double beta; double input;
    input = 0.4;
    if( input >= 0 && input <= 1 )
    { alpha = input; }
    
    beta = ( 1.0 - alpha );
    
    if (location.x > 0 && location.y > 0)
    {
        //        cv::floodFill(image, mask, seed, newVal, &ccomp, Scalar(lo, lo, lo),
        //                  Scalar(up, up, up), 4);
        cv::floodFill(image, mask, seed, cv::Scalar(10, 255, 20) ,0, cv::Scalar(2,2, 2), cv::Scalar(2,2, 2), 8);
        cv::dilate(image, image, kernel);
        
        //cv::addWeighted(image1, alpha, image, beta, 0.0, image);
        
    }
 
}

//- (void)processImage:(cv::Mat&)image;
//{
//    int lowThreshold = 10.0;
//    int ratio = 3;
//    int kernel_size = 3;
//    cv::Mat src_gray,detected_edges,dst,blurred;
//    //std::vector<cv::Mat> channels;
//
//    cv::Mat mask;
//    cv::Mat hsv;
//
//    const cv::Scalar RED = cv::Scalar(0, 0, 255);
//    const cv::Scalar GREEN = cv::Scalar(0, 255, 0);
//    const cv::Scalar BLUE = cv::Scalar(255, 0, 0);
//    const cv::Scalar BLACK = cv::Scalar(0, 0, 0);
//    const cv::Scalar WHITE = cv::Scalar(255, 255, 255);
//    const cv::Scalar YELLOW = cv::Scalar(0, 255, 255);
//    const cv::Scalar LIGHT_GRAY = cv::Scalar(100, 100, 100);
//
//    //cv::Point seed(285,200);
//
//    cv::Point seed(location.x,location.y);
//    
//
//    cv::cvtColor(image, image, cv::COLOR_BGR2RGB);//in-use
//
//    if (location.x > 0 && location.y > 0)
//    {
//
//        cv::floodFill(image, mask, seed, cv::Scalar(255, 10, 20) ,0, cv::Scalar(2,2, 2), cv::Scalar(2,2, 2), 4 );
//
//    }
//
//}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    
    UITouch *touch = [[event allTouches] anyObject];
    location= [touch locationInView:touch.view];
    NSLog(@"%f%f",location.x,location.y);
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
