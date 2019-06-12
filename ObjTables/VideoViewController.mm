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
#import <AssetsLibrary/AssetsLibrary.h>
#include <opencv2/video/background_segm.hpp>
#include "Models/Pointed.h"

@interface VideoViewController ()
@property CGFloat width;
@property CGFloat height;

@end

@implementation VideoViewController
@synthesize videoCamera;// = _videoCamera;
@synthesize selectedColors = _selectedColors;
@synthesize parentView = _parentView;
@synthesize ArrayContainer =_ArrayContainer;
@synthesize ArrayContainer2 =_ArrayContainer2;



- (void)viewDidLoad {
    [super viewDidLoad];
    self.ArrayContainer = [NSMutableArray new];
    self.ArrayContainer2 = [NSMutableArray new];

    [self.navigationController setNavigationBarHidden:YES ];
    self.videoCamera = [[CvVideoCamera alloc] initWithParentView:imageView];
    self.videoCamera.delegate = self;
    self.videoCamera.defaultAVCaptureDevicePosition = AVCaptureDevicePositionBack;//
    self.videoCamera.defaultAVCaptureSessionPreset = AVCaptureSessionPresetHigh;// AVCaptureSessionPresetHigh;
    self.videoCamera.defaultAVCaptureVideoOrientation = AVCaptureVideoOrientationPortrait;
    self.videoCamera.defaultFPS = 30;
    self.videoCamera.grayscaleMode = NO;
    self.saveit = 0;

   //videoUrl = self.videoCamera.videoFileURL; //= @"";
    
    [self.videoCamera start];
    [self ShowInstructions];
    
    self.width = [UIScreen mainScreen].bounds.size.width;
    self.height = [UIScreen mainScreen].bounds.size.height;

    self.curvedView.layer.cornerRadius = 30;
    self.curvedView.layer.masksToBounds = YES;
    self.curvedView.layer.maskedCorners = kCALayerMinXMinYCorner|kCALayerMaxXMinYCorner;
   
    // Do any additional setup after loading the view.
}

-(void)createImage:(int)withFPS {
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:videoUrl options:nil];
    CMTime assetTime = [asset duration];
    AVAssetImageGenerator *generator = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    generator.requestedTimeToleranceAfter =  kCMTimeZero;
    generator.requestedTimeToleranceBefore =  kCMTimeZero;
    //int time = CMTimeGetSeconds(asset.duration);
    CMTime duration = CMTime();
    duration.timescale = 30;
    
    for (Float64 i = 0; i < CMTimeGetSeconds(assetTime) *  withFPS ; i++){
       @autoreleasepool {
            CMTime time = CMTimeMake(0, withFPS);
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
        PHAssetChangeRequest *changeRequest = [PHAssetChangeRequest creationRequestForAssetFromImage:self->imageView.image ];
        changeRequest.creationDate          = [NSDate date];
    } completionHandler:^(BOOL success, NSError *error) {
        if (success) {
            AudioServicesPlaySystemSound(1108);
            
            [self ShowInstructions2];
            
        self->_saveit = 0;

            NSLog(@"successfully saved");
        }
        else {
         self->_saveit = 0;

            NSLog(@"error saving to photos: %@", error);
        }
    }];
}

-(IBAction)saveImage:(UIButton*)sender{
    
    //[self createImage:30];
    cv::Mat frame;

    //[self savePhotoToAlbum:imageView.image];
    //ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    _saveit++;
    
    cv::VideoCapture capture = cv::VideoCapture("../Data/Application/14D1E28D-848F-4840-802D-B6B8887B1AEA/tmp/output.mov");
    while (1)
    {
        capture >> frame;
        if (!frame.data)
        {
            break;
        }
        
#ifdef WAIT_ON
        k = cv::waitKey(1);
        if (k == 27)
        {
            break;
        }
#endif
    }

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
- (int)somo {
    cv::Size size;
    size.height = 3;
    size.width = 3;
    cv::Mat kernel = cv::getStructuringElement(cv::MORPH_RECT, size);
    double alpha = 0.5;double beta; double input;
    input = 0.4;
    if( input >= 0 && input <= 1 )
    { alpha = input; }
    
    beta = ( 1.0 - alpha );
    int res = 0;
    return res;
}

-(void)processImage:(cv::Mat&)image;
{
    cv::Size OriginalSizeOfImage = cv::Size();
    
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
    cv::Size size;
    size.height = 3;
    size.width = 3;
    
    OriginalSizeOfImage = cv::Size(imageView.bounds.size.width, imageView.bounds.size.height);
    cv::Mat newImage = cv::Mat(OriginalSizeOfImage, CV_8UC3);
    
    cv::cvtColor(image, newImage, cv::COLOR_RGBA2RGB);
    
    cv::resize(newImage, newImage, cv::Size(self.width, self.height));
    cv::Mat newMask = cv::Mat(image.size(),CV_8UC3);
    
    cv::Mat floodFilled = cv::Mat::zeros(self.width + 2, self.height + 2,CV_8U);
    
    cv::Mat output = Mat(image.size(), CV_8UC3);
    
    
    
    floodFilled = cv::Mat::zeros(self.width + 2, self.height + 2, CV_8U);
    
    newMask = cv::Mat::zeros(newImage.size(), CV_8UC3);
    
    output = cv::Mat::zeros(newImage.size(), CV_8UC3);
    cv::Mat temp;

    
    //output.setTo(cv::Scalar(red,green,blue));
    
    
//    @try {
//
//        NSLog(@"a contains %lu", self.ArrayContainer.count);
//        NSLog(@"b contains %lu", self.ArrayContainer2.count);
//
//                //double alpha  = 255.0 * colors.alpha;
//
//        for (Pointed* obj in self.ArrayContainer)
//        {
//               cv::Point seed(obj.point1,obj.point2);
//
//
////          int ras =  cv::floodFill(newImage, floodFilled, seed, cv::Scalar(red,green,blue) , nil, Scalar(3.0, 3.0, 3.0),
////                          Scalar(1.0, 1.0, 1.0), 4 + (255 << 8) + cv::FLOODFILL_MASK_ONLY);
//
//             cv::floodFill(newImage,floodFilled,seed, cv::Scalar(red,green,blue) ,0, cv::Scalar(2,2,2), cv::Scalar(1,1,1),4);
//
//            cv::subtract(floodFilled, cv::Scalar::all(0.0), floodFilled);
//
//          //  NSLog(@"number of pix %i",ras);
//
//            cv::Mat submat(floodFilled, cv::Rect(1, 1, 500, 500));//ROI
//
//            submat.copyTo(temp);
//            temp.copyTo(newMask,temp);
//
//            cv::bitwise_not(newMask, newMask);
//            newImage.copyTo(output, newMask);
//
//            cv::resize(output, output, OriginalSizeOfImage);
//
//            for (Pointed *obj in self.ArrayContainer2) {
//
//                cv::Point seed(obj.point1,obj.point2);
//
//                cv::circle(output, seed, 4, cv::Scalar(255.0, 255.0, 255.0), 4);
//                cv::circle(output, seed, 4, cv::Scalar(red,green,blue), -1);
//
//            }
//
//
//            //floodFilled.submat(roi).copyTo(temp)
//            //temp!!.copyTo(mask, temp)
//        }
//
//
//
//    } @catch (NSException *ex)
//    {
//
//    }
    
   // output.setTo();
    
    
    image0.create(image.size(), image.type());
  


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
    cv::Mat grad = cv::Mat::zeros(self.width + 2, self.height + 2, CV_8U);

    cv::convertScaleAbs(grad_x, abs_grad_x);
    cv::convertScaleAbs(grad_y, abs_grad_y);
    cv::addWeighted(abs_grad_x, 0.5, abs_grad_y, 0.5, 0, grad);

    cv::Mat edges;

    //cv::Canny(grad_x,grad_y,edges, 85, 255,3);
    
  
   //mask
    cv::Mat mask;
    //edges.copyTo(image);
     mask = cv::Mat::zeros((500 + 2), (500 + 2), CV_8U);
 
    cv::threshold(mask, mask, 1, 128, THRESH_TOZERO);

    cv::cvtColor(image, image, cv::COLOR_BGR2RGB);//in-use
    
    int res = [self somo];
    
//try
//    cv::Mat kernelly = (Mat_<float>(3,3) <<
//              1,  1, 1,
//              1, -8, 1,
//              1,  1, 1);
//    cv::Mat imgLaplacian;
//    cv::filter2D(image, imgLaplacian, CV_32F, kernelly);
//    image.convertTo(image, CV_32F);
//    image = image - imgLaplacian;
    
    
    @try {
        cv::cvtColor(image, image, COLOR_RGB2GRAY);
        
        if (location.x > 0 && location.y > 0)
        {
            cv::resize(image, image, cv::Size(500, 500));
            for (Pointed* obj in self.ArrayContainer)
            {
                cv::Point seed(obj.point1,obj.point2);

                double red  = 255.0 * colors.red;
                double green  = 255.0 * colors.green;
                double blue  = 255.0 * colors.blue;
                //double alpha  = 255.0 * colors.alpha;
                
                cv::Mat kernel = cv::getStructuringElement(cv::MORPH_RECT, size);

                //cv::erode(image, image, kernel);

                // cv::dilate(image, image, kernel);
                
                //cv::Vec3b bgr(red, green, blue);

                //cv::Vec3f hsv = BGRtoHSV(bgr);
//cv::Scalar(red,green,blue,0.0)

              res = cv::floodFill(image,mask,seed, cv::Scalar(red,green,blue,0.0) ,0, cv::Scalar(2.0,2.0,2.0), cv::Scalar(1.0,1.0,1.0),4);
                
               
                
                NSLog(@"tFilled %i",res);
//
//                           int area = cv::floodFill(image, mask, seed, cv::Scalar(red,green,blue) , 0, Scalar(2.0, 2.0, 2.0),
//                                                                    Scalar(2.0, 2.0, 2.0), 4 + (255 << 8) + cv::FLOODFILL_MASK_ONLY);

//
//                cv::Mat newImage(image.size(), image.type());
//                cv::Mat maskedImage(image.size(), image.type());
//
//                // set the solid color we will mask out of
//                newImage = cv::Scalar(red, green, blue);
//
//                // crop the 2 extra pixels w and h that were given before
//                cv::Mat maskROI = mask(cv::Rect(1,1,image.cols,image.rows));
//
//                // mask the solid color we want into new image
//                newImage.copyTo(maskedImage, maskROI);
//
//                //image.copyTo(image, maskedImage);
//
//               // cv::bitwise_not(maskedImage, maskedImage);
//                image.copyTo(image, maskedImage);


                //// cv::subtract(mask, mask, Scalar::all(0));
                cv::subtract(mask, cv::Scalar::all(0.0), mask);

                cv::Mat submat(mask, cv::Rect(1, 1, 500,500));//ROI
                
//                cv::morphologyEx(submat, submat, cv::MORPH_OPEN, kernel);
//                cv::morphologyEx(submat, submat, cv::MORPH_DILATE, kernel);
                
                submat.copyTo(temp);
                temp.copyTo(newMask,temp);
                

                 cv::bitwise_not(newMask, newMask);
                image.copyTo(image, newMask);

                //   image = grad;
                //cv::blur(image, image,cv::Size(3,3));
                //cv::dilate(image, image, cv::Mat());

                // cv::erode(<#cv::InputArray src#>, <#cv::OutputArray dst#>, <#cv::InputArray kernel#>);

                // cv::addWeighted(image, alpha, image, beta, 0.0, image);



//                            for (Pointed *obj in self.ArrayContainer2) {
//
//                                cv::Point seed(obj.point1,obj.point2);
//
//                                cv::circle(image, seed, 4, cv::Scalar(255.0, 255.0, 255.0), 0.5);
//                                cv::circle(image, seed, 4, cv::Scalar(red,green,blue), 0.5);
//
//                            }


            }


        }

    }
    @catch (NSException *ex)
    {
        //
    }
    
   // image = temp;
   
}
cv::Rect bound(0,0,700,700);
Mat blur, gray, grad;

Point2f computeIntersect(Vec4i a, Vec4i b)
{
    int x1 = a[0], y1 = a[1], x2 = a[2], y2 = a[3];
    int x3 = b[0], y3 = b[1], x4 = b[2], y4 = b[3];
    
    if (float d = ((float)(x1-x2) * (y3-y4)) - ((y1-y2) * (x3-x4)))
    {
        Point2f pt;
        pt.x = ((x1*y2 - y1*x2) * (x3-x4) - (x1-x2) * (x3*y4 - y3*x4)) / d;
        pt.y = ((x1*y2 - y1*x2) * (y3-y4) - (y1-y2) * (x3*y4 - y3*x4)) / d;
        return pt;
    }
    else
        return Point2f(-1, -1);
}

cv::Vec3f BGRtoHSV(const cv::Vec3b& bgr)
{
    cv::Mat3f bgrMat(static_cast<cv::Vec3f>(bgr));
    
    bgrMat *= 1./255.;
    
    cv::Mat3f hsvMat;
    cv::cvtColor(bgrMat, hsvMat, COLOR_BGR2HSV);
    
    cv::Vec3f hsv = hsvMat(0,0);
    
    return hsv;
}




-(void)processImage2:(cv::Mat &)image
{
    Mat src = image;// imread("empty2.jpg");
    Mat roi = src(bound);
    Mat blury, grayy, thresh, dst;
    int scale = 1;
    int delta = 0;
    int ddepth = CV_16S;
    Mat grad_x, grad_y;
    Mat abs_grad_x, abs_grad_y;
    Mat finals, finals2;
    
    
    //bilateralFilter( roi, blury, 50, 5, BORDER_DEFAULT );
    cvtColor( roi, grayy, COLOR_BGR2GRAY );
    //threshold(grayy,thresh,127,255,THRESH_BINARY);
    //dilate( thresh, thresh, MORPH_RECT );
    //dilate( thresh, thresh, MORPH_RECT );
    //dilate( thresh, thresh, MORPH_RECT );
    //Sobel( grayy, grad_x, ddepth, 1, 0, 3, scale, delta, BORDER_DEFAULT );
    //Sobel( grayy, grad_y, ddepth, 0, 1, 3, scale, delta, BORDER_DEFAULT );
    //convertScaleAbs( grad_x, abs_grad_x );
    //convertScaleAbs( grad_y, abs_grad_y );
    //addWeighted( abs_grad_x, 0.5, abs_grad_y, 0.5, 0, grad );
    Canny( grayy, finals, 50, 150, 3 );
    
    
    
    dilate( finals, finals, MORPH_RECT );
    dilate( finals, finals, MORPH_RECT );
    dilate( finals, finals, MORPH_RECT );
    cvtColor(finals, finals2, COLOR_GRAY2BGR);
    std::vector<Vec4i> lines;
    HoughLinesP(finals, lines, 1, CV_PI/180, 30, 50, 10 );
    
    std::vector<Point2f> corners;
    std::vector<Vec4i> edgedetect;
    for (int i = 0; i < lines.size(); i++)
    {
        for (int j = i+1; j < lines.size(); j++)
        {
            Point2f pt = computeIntersect(lines[i], lines[j]);
            Vec4i l = lines[i];
            Vec4i h = lines[j];
            if (pt.x >= 0 && pt.y >= 0)
                edgedetect.push_back(l);
            edgedetect.push_back(h);
            for (int r = 0; r < lines.size(); r += 2)
                for(int k = r + 1; k < lines.size(); k++)
                {
                    Vec4i e = edgedetect[i];
                    Vec4i f = edgedetect[j];
                    line( finals2, cv::Point(e[0], e[1]), cv::Point(e[2], e[3]), Scalar(0,0,255), 3, LINE_AA);
                    line( finals2, cv::Point(f[0], f[1]), cv::Point(f[2], f[3]), Scalar(0,0,255), 3, LINE_AA);
                }
        }
    }

    image = finals2;
    
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
        
        Pointed *val = [Pointed new];
        val.point1 = location.x;
        val.point2 = location.y;


        [self.ArrayContainer addObject:val];
        [self.ArrayContainer2 addObject:val];

        
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
