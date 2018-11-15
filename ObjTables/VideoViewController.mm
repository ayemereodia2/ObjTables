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
#import <opencv2/imgcodecs/ios.h>
#import <Photos/Photos.h>
@interface VideoViewController ()

@end

@implementation VideoViewController
@synthesize videoCamera;// = _videoCamera;
@synthesize selectedColors = _selectedColors;
@synthesize parentView = _parentView;


- (void)SetupCameraWrapper {
    self.videoCamera = [[CvVideoCamera alloc] initWithParentView:imageView];
    self.videoCamera.delegate = self;
    self.videoCamera.defaultAVCaptureDevicePosition = AVCaptureDevicePositionBack;//AVCaptureDevicePositionFront
    //self.videoCamera.defaultAVCaptureSessionPreset = AVCaptureSessionPreset1280x720;
    self.videoCamera.defaultAVCaptureSessionPreset = AVCaptureSessionPresetHigh;
    self.videoCamera.defaultAVCaptureVideoOrientation = AVCaptureVideoOrientationLandscapeRight;
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
    self.videoCamera.defaultAVCaptureSessionPreset = AVCaptureSessionPresetHigh;// AVCaptureSessionPresetHigh;
    self.videoCamera.defaultAVCaptureVideoOrientation = AVCaptureVideoOrientationPortrait;
    self.videoCamera.defaultFPS = 30;
    self.videoCamera.grayscaleMode = NO;

   //videoUrl = self.videoCamera.videoFileURL; //= @"";
    
    [self.videoCamera start];
    [self ShowInstructions];
    
    // Do any additional setup after loading the view.
}

-(void)createImage:(int)withFPS {
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:videoUrl options:nil];
    
    AVAssetImageGenerator *generator = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    generator.requestedTimeToleranceAfter =  kCMTimeZero;
    generator.requestedTimeToleranceBefore =  kCMTimeZero;
    //int time = CMTimeGetSeconds(asset.duration);
    CMTime duration = CMTime();
    duration.timescale = 30;
    
    for (Float64 i = 0; i < CMTimeGetSeconds(duration) *  withFPS ; i++){
        @autoreleasepool {
            CMTime time = CMTimeMake(i, withFPS);
            NSError *err;
            CMTime actualTime;
            CGImageRef image = [generator copyCGImageAtTime:time actualTime:&actualTime error:&err];
            UIImage *generatedImage = [[UIImage alloc] initWithCGImage:image];
            [self savePhotoToAlbum: generatedImage]; // Saves the image on document directory and not memory
            CGImageRelease(image);
        }
    }
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

- (void)ShowInstructions2 {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Saved"
                                                                   message:@"Image Saved!"
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
    //UIButton *senderBtn = (UIButton *) sender;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ColorPalleteViewController *myNewVC = (ColorPalleteViewController *)[storyboard instantiateViewControllerWithIdentifier:@"ColorPalleteViewController"];
    myNewVC.delegate = self;
    [self.navigationController pushViewController:myNewVC animated:YES];

}
- (void)savePhotoToAlbum:(UIImage*)image {
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        PHAssetChangeRequest *changeRequest = [PHAssetChangeRequest creationRequestForAssetFromImage:self->imageView.image = image];
        changeRequest.creationDate          = [NSDate date];
    } completionHandler:^(BOOL success, NSError *error) {
        if (success) {
            AudioServicesPlaySystemSound(1108);
            
            [self ShowInstructions2];
            
            
            NSLog(@"successfully saved");
        }
        else {
            NSLog(@"error saving to photos: %@", error);
        }
    }];
}

-(IBAction)saveImage:(UIButton*)sender{
    
    [self createImage:30];

    //[self savePhotoToAlbum:imageView.image];
    
}





ColorsRGB *colors;

-(void) sendColorToVideo:(UIColor *)color{
    self.showBerger.backgroundColor = color;
    CGColorRef colorref = [color CGColor];
    
    int numOfColors = (int)CGColorGetNumberOfComponents(colorref);
    
    if (numOfColors == 4) {
         const CGFloat* compo = CGColorGetComponents(colorref);
    

 colors = [[ColorsRGB alloc]initWithValues:compo[0] Green:compo[1] Blue:compo[2]];

    }
}
-(void)processImage:(cv::Mat&)image;
{
    videoUrl = self.videoCamera.videoFileURL; //= @"";

  //  videoUrl = [NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"VfE_html5" ofType:@"mp4"]];

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
    image0.create(image.size(), image.type());
    //    const cv::Scalar RED = cv::Scalar(0, 0, 255);
    //    const cv::Scalar GREEN = cv::Scalar(0, 255, 0);
    //    const cv::Scalar BLUE = cv::Scalar(255, 0, 0);
    //    const cv::Scalar BLACK = cv::Scalar(0, 0, 0);
    //    const cv::Scalar WHITE = cv::Scalar(255, 255, 255);
    //    const cv::Scalar YELLOW = cv::Scalar(0, 255, 255);
    //    const cv::Scalar LIGHT_GRAY = cv::Scalar(100, 100, 100);
    
    //cv::Point seed(285,200);
    
    cv::Point seed(location.x+100.0,location.y+100.0);
    
    // Apply Gaussian filter to remove small edges
    cv::GaussianBlur(image, image,
                     cv::Size(5, 5), 1.2, 1.2);// step3
    cv::cvtColor(image, gray, COLOR_RGB2GRAY); //step4
    
     cv::sum(image);
    

   // cv::threshold(image, image, 25, 60, 3);
    cv::Mat grad_x,grad_y,abs_grad_x,abs_grad_y;
    
//    cv::Sobel(gray, grad_x, CV_16S, 1, 0);
//    cv::Sobel(gray, grad_y, CV_16S, 0, 1);
    
    cv::Scharr(gray, grad_x, CV_16S, 1, 0);
    cv::Scharr(gray, grad_y, CV_16S, 0, 1);
    cv::Mat grad;

    cv::convertScaleAbs(grad_x, abs_grad_x);
    cv::convertScaleAbs(grad_y, abs_grad_y);
    cv::addWeighted(abs_grad_x, 0.5, abs_grad_y, 0.5, 0, grad);
    
    cv::Mat edges;
    
   //cv::Canny(grad_x,grad_y,edges, 85, 255,3);
   // image = edges;
    //cv::Mat filter = cv::Mat::ones(3, 3, CV_32F);

    cv::equalizeHist(grad, grad);
   // cv::filter2D(grad, grad, -1, filter,cv::Point(-1, -1), 0,BORDER_DEFAULT);
   // cv::bilateralFilter(grad, grad, 5, 75, 75);
  //  image = grad;

   //mask
    cv::Mat mask;
//    image.copyTo(image0);
    cv::copyMakeBorder(mask, mask, 5, 5, 5, 5, cv::BORDER_REPLICATE);

    mask.create(grad.rows+2, grad.cols+2, CV_8U);///edges to mask input
    mask = Scalar::all(0);

    cv::cvtColor(image, image, cv::COLOR_BGR2RGB);//in-use
                                                //    int loDiff = diff, upDiff = diff;
                                                //
                                                //
                                                //    int lo = ffillMode == 0 ? 0 : loDiff;
                                                //    int up = ffillMode == 0 ? 0 : upDiff;
                                                //    int flags = connectivity + (255 << 8) +
                                                //    (ffillMode == 1 ? CV_FLOODFILL_FIXED_RANGE : 0);
                                                //    int b =255; //(unsigned)theRNG() & 255;
                                                //    int g = 255;//(unsigned)theRNG() & 255;
                                                //    int r = 255;//(unsigned)theRNG() & 255;
                                                //    cv::Rect ccomp;
                                                //
                                                //    //Scalar newVal = isColor ? Scalar(b, g, r) : Scalar(r*0.299 + g*0.587 + b*0.114);
                                                //    Scalar newVal = Scalar(r*0.299 + g*0.587 + b*0.114);
                                                //    //dilate
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
       
            
            double red  = 255.0 * colors.red;
            double green  = 255.0 * colors.green;
            double blue  = 255.0 * colors.blue;
           // double alpha  = 255.0 * colors.alpha;

            
         int xc = cv::floodFill(image,mask,seed, cv::Scalar(red,green,blue) ,0, cv::Scalar(2,2,2), cv::Scalar(1,1,1),4);
            //   image = grad;
            cv::blur(image, image,cv::Size(3,3));
            cv::dilate(image, image, kernel);
            
            // cv::erode(<#cv::InputArray src#>, <#cv::OutputArray dst#>, <#cv::InputArray kernel#>);
            
            cv::addWeighted(image, alpha, image, beta, 0.0, image);
        
        

    }

}



+(UIImage *)processViews:(UIImage *)srcimage startPoint:(NSMutableArray* )point newColor:(ColorsRGB *)newcolor lodiff:(int )diff tap:(int )Taps
{
    
    cv::Mat image;
    UIImageToMat(srcimage, image);
    
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
    //int diff = 10;
    cv::Mat gray;
    image0.create(image.size(), image.type());
    
    
    
    //cv::Point seed(285,200);
    
    
    // Apply Gaussian filter to remove small edges
    cv::GaussianBlur(image, image,
                     cv::Size(5, 5), 1.2, 1.2);// step3
    cv::cvtColor(image, gray, COLOR_RGB2GRAY); //step4
    
    //cv::sum(image);
    // cv::threshold(image, image, 25, 60, 3);
    cv::Mat grad_x,grad_y,abs_grad_x,abs_grad_y;
    
    //    cv::Sobel(gray, grad_x, CV_16S, 1, 0);
    //    cv::Sobel(gray, grad_y, CV_16S, 0, 1);
    
    cv::Scharr(gray, grad_x, CV_16S, 1, 0);
    cv::Scharr(gray, grad_y, CV_16S, 0, 1);
    cv::Mat grad;
    
    cv::convertScaleAbs(grad_x, abs_grad_x);
    cv::convertScaleAbs(grad_y, abs_grad_y);
    cv::addWeighted(abs_grad_x, 0.5, abs_grad_y, 0.5, 0, grad);
    
    cv::Mat edges;
    
    //cv::Canny(grad_x,grad_y,edges, 85, 255,3);
    // image = edges;
    //cv::Mat filter = cv::Mat::ones(3, 3, CV_32F);
    
    cv::equalizeHist(grad, grad);
    // cv::filter2D(grad, grad, -1, filter,cv::Point(-1, -1), 0,BORDER_DEFAULT);
    // cv::bilateralFilter(grad, grad, 5, 75, 75);
    //  image = grad;
    
    //mask
    cv::Mat mask;
    //    image.copyTo(image0);
    cv::copyMakeBorder(mask, mask, 5, 5, 5, 5, cv::BORDER_REPLICATE);
    
    mask.create(grad.rows+2, grad.cols+2, CV_8U);///edges to mask input
    mask = Scalar::all(0);
    
    cv::cvtColor(image, image, cv::COLOR_BGR2RGB);//in-use
    //    int loDiff = diff, upDiff = diff;
    //
    //
    //    int lo = ffillMode == 0 ? 0 : loDiff;
    //    int up = ffillMode == 0 ? 0 : upDiff;
    //    int flags = connectivity + (255 << 8) +
    //    (ffillMode == 1 ? CV_FLOODFILL_FIXED_RANGE : 0);
    //    int b =255; //(unsigned)theRNG() & 255;
    //    int g = 255;//(unsigned)theRNG() & 255;
    //    int r = 255;//(unsigned)theRNG() & 255;
    //    cv::Rect ccomp;
    //
    //    //Scalar newVal = isColor ? Scalar(b, g, r) : Scalar(r*0.299 + g*0.587 + b*0.114);
    //    Scalar newVal = Scalar(r*0.299 + g*0.587 + b*0.114);
    //    //dilate
    cv::Size size;
    size.height = 3;
    size.width = 3;
    cv::Mat kernel = cv::getStructuringElement(cv::MORPH_RECT, size);
    double alpha = 0.5;double beta; double input;
    input = 0.4;
    if( input >= 0 && input <= 1 )
    { alpha = input; }
    
    beta = ( 1.0 - alpha );
    
    
        
        double red  = 255.0 * newcolor.red;
        double green  = 255.0 * newcolor.green;
        double blue  = 255.0 * newcolor.blue;
    CGPoint pointed;
    CGPoint pointed2;
    int x = 0;

    for (NSValue *valuetoGetBack in point) {
        pointed = [valuetoGetBack CGPointValue];
        //do something with the CGPoint

    }
    
        for (int i=0; i<[point count]; i++) {

            cv::Point seed(pointed.x+100.0,pointed.y+100.0);

            if(Taps == 3)
              {
                  
                  return srcimage ;
              }
            else{
                cv::floodFill(image,mask,seed, cv::Scalar(blue,green,red) ,0, cv::Scalar(1,1,1), cv::Scalar(1,1,1),4);
                //   image = grad;
                //        cv::blur(image, image,cv::Size(3,3));
                //        cv::dilate(image, image, kernel);
                
                // cv::erode(<#cv::InputArray src#>, <#cv::OutputArray dst#>, <#cv::InputArray kernel#>);
                
                // cv::addWeighted(image, alpha, image, beta, 0.0, image);
                cv::cvtColor(image, image, cv::COLOR_BGR2RGB);//in-use
                
                
                pointed2.x = pointed.x;
                pointed2.y = pointed.y;
                x++;
                
                srcimage = MatToUIImage(image);
            }
              
            

         
          //  NSLog(@"%d: %@", i, point[i]);
        
        }
   // return MatToUIImage(image);

    return srcimage;

    }




- (IBAction)goBack:(UIButton*)sender{
    
   // UIButton *senderBtn = (UIButton *) sender;
    [self.navigationController popViewControllerAnimated:YES];
}



-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    if(!colors)
    {
        [self ShowInstructions];
        return;
    }
    else{
    UITouch *touch = [[event allTouches] anyObject];
    location= [touch locationInView:touch.view];
        
        
    NSLog(@"%f%f",location.x,location.y);
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//- (void)createVideoPreviewLayer;
//{
//
//    self.parentView.layer.sublayers = nil;
//    if (self.videoCamera.captureVideoPreviewLayer == nil) {
//        self.videoCamera.captureVideoPreviewLayer  = [[AVCaptureVideoPreviewLayer alloc]initWithSession:self.videoCamera.captureSession];
//
//
//        [[AVCaptureVideoPreviewLayer alloc]
//                                    initWithSession:self.videoCamera.captureSession];
//    }
//
//    if (self.parentView != nil) {
//        self.videoCamera.captureVideoPreviewLayer.frame = self.parentView.bounds;
//        self.videoCamera.captureVideoPreviewLayer.videoGravity =
//        AVLayerVideoGravityResizeAspectFill;
//        [self.parentView.layer addSublayer:self.videoCamera.captureVideoPreviewLayer];
//    }
//    NSLog(@"[Camera] created AVCaptureVideoPreviewLayer");
//}


//- (void)createStillImageOutput;
//{
//    // setup still image output with jpeg codec
//    self.stillImageOutput = [[AVCapturePhotoOutput alloc] init];
//    NSDictionary *outputSettings = [NSDictionary dictionaryWithObjectsAndKeys:AVVideoCodecTypeJPEG, AVVideoCodecKey, nil];
//    [self.stillImageOutput setOutputSettings:outputSettings];
//    [self.captureSession addOutput:self.stillImageOutput];
//
//    for (AVCaptureConnection *connection in self.stillImageOutput.connections) {
//        for (AVCaptureInputPort *port in [connection inputPorts]) {
//            if ([port.mediaType isEqual:AVMediaTypeVideo]) {
//                self.videoCaptureConnection = connection;
//                break;
//            }
//        }
//        if (self.videoCaptureConnection) {
//            break;
//        }
//    }
//    NSLog(@"[Camera] still image output created");
//}

@end
