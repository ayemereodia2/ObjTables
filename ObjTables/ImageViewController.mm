//
//  ImageViewController.m
//  ObjTables
//
//  Created by mac on 9/13/18.
//  Copyright © 2018 bergerpaint. All rights reserved.
//

#import "ImageViewController.h"
#include <opencv2/core/core.hpp>
#include <opencv2/highgui/highgui.hpp>
#include <opencv2/imgproc/imgproc.hpp>
#include <opencv2/videoio/cap_ios.h>
#import "ColorPalleteViewController.h"
#import "VideoViewController.h"
#import <Photos/Photos.h>
#import <opencv2/imgcodecs/ios.h>
#import "Models/Pointed.h"
@interface ImageViewController ()

@end

@implementation ImageViewController
@synthesize photoCamera = _photoCamera;
@synthesize videoCamera = _videoCamera;
@synthesize imageView2 = _imageView2;
@synthesize mPointsArray = _mPointsArray;
@synthesize ArrayContainer =_ArrayContainer;
@synthesize ArrayContainer2 =_ArrayContainer2;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES ];

    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                              message:@"Device has no camera"
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles: nil];
        
        [myAlertView show];
        self.counter = 0;

    }
    
    
    if (self.imageView2.image == nil) {
        self.clearPhoto.enabled = NO;
    }
    else{
        self.clearPhoto.enabled = YES;
        
    }
    //show instruction
    [self ShowInstructions];
    // Do any additional setup after loading the view.
    
    self.curvedView2.layer.cornerRadius = 30;
    self.curvedView2.layer.masksToBounds = YES;
    self.curvedView2.layer.maskedCorners = kCALayerMinXMinYCorner|kCALayerMaxXMinYCorner;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//NSArray *array = [NSArray arrayWithObjects:@"VideoViewCell",@"ImageViewCell",nil];

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)showBerger:(id)sender{
    UIButton *senderBtn = (UIButton *) sender;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    ColorPalleteViewController *myNewVC = (ColorPalleteViewController *)[storyboard instantiateViewControllerWithIdentifier:@"ColorPalleteViewController"];
    myNewVC.delegate = self;
    [self.navigationController pushViewController:myNewVC animated:YES];
    
}


- (IBAction)selectPhoto:(UIButton *)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;

    [self presentViewController:picker animated:YES completion:NULL];
  
    
}

-(IBAction)ChooseImageFromCamera:(UIButton*)sender{
    
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
        [self presentViewController:picker animated:YES completion:NULL];
    
}

ColorsRGB *colorz;

-(void) sendColorToVideo:(UIColor *)color{
    self.showBerger.backgroundColor = color;
    CGColorRef colorref = [color CGColor];
    
    int numOfColors = (int)CGColorGetNumberOfComponents(colorref);
    
    if (numOfColors == 4) {
        const CGFloat* compo = CGColorGetComponents(colorref);
        
        
        colorz = [[ColorsRGB alloc]initWithValues:compo[0] Green:compo[1] Blue:compo[2]];
        
    }
}



- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.imageView2.image = chosenImage;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}
-(IBAction)saveImage2:(UIButton*)sender{
    
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        PHAssetChangeRequest *changeRequest = [PHAssetChangeRequest creationRequestForAssetFromImage:self->_imageView2.image];
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

- (void)ShowInstructions2 {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Saved"
                                                                   message:@"Image Saved!"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    

//    imageView.image = [FloodFillOBJ floodFill:[UIImage imageNamed:@"bae.jpg"] startPoint:tpoint newColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"lena.png"]] lodiff:10];
//
    //self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    
    if(!colorz && !_imageView2.image)
    {
        [self ShowInstructions];
        return;
    }
    else{
        CGPoint tpoint = [[[event allTouches] anyObject] locationInView:self.view];
        
        location = tpoint;
        //CGPoint tpoint2;// = tpoint;
        self.ArrayContainer = [[NSMutableArray alloc]init];
        self.ArrayContainer2 = [[NSMutableArray alloc]init];

        UITouch *touch = [[event allTouches] anyObject];
        location= [touch locationInView:touch.view];
        
        //CGPoint pointToConvert = CGPointMake(location.x, location.y);
        location= [touch locationInView:touch.view];

//        NSValue *valueToStore = [NSValue valueWithCGPoint:pointToConvert];
//        int tapCount = 0;
        
        Pointed *value = [Pointed new];
        value.point1 = location.x;
        value.point2 = location.y;
        
        [self.ArrayContainer addObject:value];
        [self.ArrayContainer2 addObject:value];
        
        self.imageView2.image = [self processImage2:self.imageView2.image startPoint:self.ArrayContainer endPoint:self.ArrayContainer2 newColor:colorz lodiff:10 tap:self.counter];
        
        
        
    }
    


    return;
}

-(IBAction)goBack:(UIButton*)sender{
    
    //UIButton *senderBtn = (UIButton *) sender;
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)clearPhotos:(UIButton *)sender{
    
    self.imageView2.image = nil;
    self.clearPhoto.enabled = NO;
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    if (self.imageView2.image == nil) {
        self.clearPhoto.enabled = NO;
    }
    else{
        self.clearPhoto.enabled = YES;
        
    }
    
}
- (void)ShowInstructions {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Instructions"
                                                                   message:@"Simply select a photo from camera-roll and chose a Color,then touch the parts of the wall you want to paint and tap the Reset button to clear all painting"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)processImage:(cv::Mat &)image {
    
}
- (IBAction)actionStart:(id)sender{
    
}

- (void)encodeWithCoder:(nonnull NSCoder *)aCoder {
    
}

- (void)traitCollectionDidChange:(nullable UITraitCollection *)previousTraitCollection {
    
}

- (void)preferredContentSizeDidChangeForChildContentContainer:(nonnull id<UIContentContainer>)container {
    
}

//- (CGSize)sizeForChildContentContainer:(nonnull id<UIContentContainer>)container withParentContainerSize:(CGSize)parentSize {
//    return
//}

- (void)systemLayoutFittingSizeDidChangeForChildContentContainer:(nonnull id<UIContentContainer>)container {
    
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(nonnull id<UIViewControllerTransitionCoordinator>)coordinator {
    
}

- (void)willTransitionToTraitCollection:(nonnull UITraitCollection *)newCollection withTransitionCoordinator:(nonnull id<UIViewControllerTransitionCoordinator>)coordinator {
    
}

- (void)didUpdateFocusInContext:(nonnull UIFocusUpdateContext *)context withAnimationCoordinator:(nonnull UIFocusAnimationCoordinator *)coordinator {
    
}

- (void)setNeedsFocusUpdate {
    
}

- (BOOL)shouldUpdateFocusInContext:(nonnull UIFocusUpdateContext *)context {
    return YES;
}

- (void)updateFocusIfNeeded {
    
}

-(UIImage *)processViews:(UIImage *)srcimage startPoint:(NSMutableArray* )point newColor:(ColorsRGB *)newcolor lodiff:(int )diff tap:(int )Taps
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
        
        if(_counter >= 3)
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


-(UIImage*)processImage2:(UIImage *)srcimage startPoint:(NSMutableArray* )startPoint endPoint:(NSMutableArray* )endPoint newColor:(ColorsRGB *)newcolor lodiff:(int )diff tap:(int )Taps
{
    cv::Size OriginalSizeOfImage = cv::Size();
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
    
    
    OriginalSizeOfImage = cv::Size(500, 500);
    cv::Mat newImage = cv::Mat(OriginalSizeOfImage, CV_8UC3);
    
    cv::cvtColor(image, newImage, cv::COLOR_RGB2HSV);
    
    cv::resize(newImage, newImage, cv::Size(500.0, 500.0));
    
    int sw = 500;
    int sh = 500;
    
    
    
    cv::Mat newMask = cv::Mat(image.size(),CV_8UC3);
    
    cv::Mat floodFilled = cv::Mat::zeros(500 + 2, 500 + 2,CV_8U);
    
    cv::Mat output = Mat(image.size(), CV_8UC3);
    
    
    
    floodFilled = cv::Mat::zeros(500 + 2, 500 + 2, CV_8U);
    
    newMask = cv::Mat::zeros(newImage.size(), CV_8UC3);
    
    output = cv::Mat::zeros(newImage.size(), CV_8UC3);
    cv::Mat temp;
    
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
    cv::Mat grad = cv::Mat::zeros(500 + 2, 500 + 2, CV_8U);
    
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
    mask = cv::Mat::zeros(500 + 2, 500 + 2, CV_8U);
    
    //mask.create(image.rows+2, image.cols+2, CV_8U);///edges to mask input
    //mask = Scalar::all(0);
    cv::threshold(mask, mask, 1, 128, THRESH_BINARY);
    
    cv::cvtColor(image, image, cv::COLOR_BGR2YCrCb);//in-use
    
    
    int const NUM_SKIN_POINTS = 6;
    cv::Point skinPts[NUM_SKIN_POINTS];
    skinPts[0] = cv::Point(sw/2,          sh/2 - sh/6);
    skinPts[1] = cv::Point(sw/2 - sw/11,  sh/2 - sh/6);
    skinPts[2] = cv::Point(sw/2 + sw/11,  sh/2 - sh/6);
    skinPts[3] = cv::Point(sw/2,          sh/2 + sh/16);
    skinPts[4] = cv::Point(sw/2 - sw/9,   sh/2 + sh/16);
    skinPts[5] = cv::Point(sw/2 + sw/9,   sh/2 + sh/16);
    
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
        cv::resize(image, image, cv::Size(500.0, 500.0));
        for (Pointed* obj in startPoint)
        {
            //cv::Point seed;//(obj.point1,obj.point2);
            cv::Point seed(obj.point1,obj.point2);

            
            double red  = 255.0 * colorz.red;
            double green  = 255.0 * colorz.green;
            double blue  = 255.0 * colorz.blue;
            // double alpha  = 255.0 * colors.alpha;
            
            
            cv::floodFill(image,mask,seed, cv::Scalar(red,green,blue) ,0, cv::Scalar(1.0,1.0,1.0), cv::Scalar(1.0,1.0,1.0),4);
            
           
            cv::subtract(mask, cv::Scalar::all(0.0), mask);
            
            cv::Mat submat(mask, cv::Rect(1, 1, 500, 500));//ROI
            submat.copyTo(temp);
            temp.copyTo(newMask,temp);
            
            // cv::bitwise_not(newMask, newMask);
            image.copyTo(image, newMask);
            
            //   image = grad;
            //cv::blur(image, image,cv::Size(3,3));
            //cv::dilate(image, image, kernel);
            
            // cv::erode(<#cv::InputArray src#>, <#cv::OutputArray dst#>, <#cv::InputArray kernel#>);
            
            // cv::addWeighted(image, alpha, image, beta, 0.0, image);
            
            
            
//            for (Pointed *obj in self.ArrayContainer2) {
//
//                cv::Point seed(obj.point1,obj.point2);
//
//                cv::circle(output, seed, 4, cv::Scalar(255.0, 255.0, 255.0), 4);
//                cv::circle(output, seed, 4, cv::Scalar(red,green,blue), -1);
//
//            }
            
            
            //                if(_saveit >= 1)
            //                {
            //                    [self savePhotoToAlbum: MatToUIImage(image)]; // Saves the image on document directory and not memory
            //
            //                }
        }
        
    }
    srcimage = MatToUIImage(image);

    
    return srcimage;
    
}

@end
