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

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES ];
    self.videoCamera = [[CvVideoCamera alloc] initWithParentView:imageView];
    self.videoCamera.delegate = self;
    self.videoCamera.defaultAVCaptureDevicePosition = AVCaptureDevicePositionBack;//AVCaptureDevicePositionFront
    self.videoCamera.defaultAVCaptureSessionPreset = AVCaptureSessionPreset640x480;
    //self.videoCamera.defaultAVCaptureSessionPreset = AVCaptureSessionPresetHigh;
    self.videoCamera.defaultAVCaptureVideoOrientation = AVCaptureVideoOrientationPortrait;
    self.videoCamera.defaultFPS = 30;
    self.videoCamera.grayscaleMode = NO;
    [self ShowInstructions];
    // Do any additional setup after loading the view.
}

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

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES ];
    [self ShowInstructions];

}

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


- (void)processImage:(cv::Mat&)image;
{
    int lowThreshold = 10.0;
    int ratio = 3;
    int kernel_size = 3;
    cv::Mat src_gray,detected_edges,dst,blurred;
    //std::vector<cv::Mat> channels;
    
    cv::Mat mask;
    cv::Mat hsv;
    
    const cv::Scalar RED = cv::Scalar(0, 0, 255);
    const cv::Scalar GREEN = cv::Scalar(0, 255, 0);
    const cv::Scalar BLUE = cv::Scalar(255, 0, 0);
    const cv::Scalar BLACK = cv::Scalar(0, 0, 0);
    const cv::Scalar WHITE = cv::Scalar(255, 255, 255);
    const cv::Scalar YELLOW = cv::Scalar(0, 255, 255);
    const cv::Scalar LIGHT_GRAY = cv::Scalar(100, 100, 100);
    
    //cv::Point seed(285,200);
    
    cv::Point seed(location.x,location.y);
    //cv::Canny(image, mask, 100, 200);
    //    cv::split(hsv, channels);
    //
    // cv::copyMakeBorder(mask, mask, 1, 1, 1, 1, cv::BORDER_REPLICATE);
    
    //cv::cvtColor( image, src_gray, COLOR_BGR2GRAY );
    
    // cv::blur( src_gray, detected_edges, cv::Size(5,5) );
    
    //cv::dilate(detected_edges, blurred, image);
    
    cv::cvtColor(image, image, cv::COLOR_BGR2RGB);//in-use
    
    if (location.x > 0 && location.y > 0)
    {
        
        cv::floodFill(image, mask, seed, cv::Scalar(255, 10, 20) ,0, cv::Scalar(2,2, 2), cv::Scalar(2,2, 2), 4 );
        
    }
    
}

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
