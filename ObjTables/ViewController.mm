//
//  ViewController.m
//  ObjTables
//
//  Created by mac on 8/30/18.
//  Copyright © 2018 bergerpaint. All rights reserved.
//

#import "ViewController.h"
#import "SimpleTableViewCell.h"
#import "SimpleTableViewCell1.h"
#import "SimpleTableViewCell2.h"
#import "SelectVisualizerTypeController.h"
#import "CategoryViewController.h"
#import "DetailsViewController.h"
#import "VideoViewController.h"
#include <opencv2/core/core.hpp>
#include <opencv2/highgui/highgui.hpp>
#include <opencv2/imgproc/imgproc.hpp>
#include <opencv2/videoio/cap_ios.h>


@interface ViewController ()

@end

@implementation ViewController
@synthesize sampletable = _sampletable;
@synthesize videoCamera;
@synthesize photoCamera;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:YES ];
    [self.sampletable registerNib:[UINib nibWithNibName:@"SimpleTableCell" bundle:nil] forCellReuseIdentifier:@"SimpleTableViewCell"];
     [self.sampletable registerNib:[UINib nibWithNibName:@"SimpleTableViewCell1" bundle:nil] forCellReuseIdentifier:@"SimpleTableViewCell1"];
     [self.sampletable registerNib:[UINib nibWithNibName:@"SimpleTableViewCell2" bundle:nil] forCellReuseIdentifier:@"SimpleTableViewCell2"];
    self.sampletable.delegate = self;
    self.sampletable.dataSource = self;
    
    
//    self.videoCamera = [[CvVideoCamera alloc] initWithParentView:imageView];
//    self.videoCamera.delegate = self;
//    self.videoCamera.defaultAVCaptureDevicePosition = AVCaptureDevicePositionBack;//AVCaptureDevicePositionFront
//    //self.videoCamera.defaultAVCaptureSessionPreset = AVCaptureSessionPreset640x480;
//    self.videoCamera.defaultAVCaptureSessionPreset = AVCaptureSessionPresetHigh;
//    self.videoCamera.defaultAVCaptureVideoOrientation = AVCaptureVideoOrientationPortrait;
//    self.videoCamera.defaultFPS = 30;
//    self.videoCamera.grayscaleMode = NO;
  
    
    
    imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    UIImage *image0 = [UIImage imageNamed:@"bae.jpg" inBundle:nil compatibleWithTraitCollection:nil];
    cv::Mat image = [self cvMatFromUIImage:image0] ;//cv::imread("");
    cv::Mat image1 = image;
    cv::Mat gray;
    
    cv::cvtColor(image, gray, COLOR_RGB2GRAY); //step2
    // Apply Gaussian filter to remove small edges
    cv::GaussianBlur(gray, gray,
                     cv::Size(5, 5), 1.2, 1.2);// step3
   // cv::threshold(image, image, 25, 60, 3);
    
    cv::Mat edges;
    cv::Canny(gray,edges, 45, 90,3);
    
    cv::Size size;
    size.height = 3;
    size.width = 3;
    cv::Mat kernel = cv::getStructuringElement(cv::MORPH_RECT, size);
    double alpha = 0.5;double beta; double input;
    input = 0.4;
    if( input >= 0 && input <= 1 )
    { alpha = input; }
    
    beta = ( 1.0 - alpha );
    cv::Mat output;
    cv::Point seed(490,215);
    cv::Point seed2(203,43);
    cv::Point seed3(36,243);
    //cv::Point seed(location.x, location.y);
    
    cv::Mat mask = cv::Mat::zeros(edges.rows + 2, edges.cols + 2, CV_8U);
    
    //cv::Mat binaryMat(image.size(), image.type());
    
    //    imageView.image = [self UIImageFromCVMat:image];
    cv::cvtColor(image, image, cv::COLOR_BGR2RGB);//in-use
    
    try {
        if(seed.x > 0 && seed.y > 0){
            cv::floodFill(image, mask, seed, cv::Scalar(50, 155, 20) ,0, cv::Scalar(2,2, 2), cv::Scalar(2,2, 2), 8);
            cv::dilate(image, image, kernel);
            cv::addWeighted(image1, alpha, image, beta, 0.0, image);
            
            cv::floodFill(image, mask, seed2, cv::Scalar(50, 155, 20) ,0, cv::Scalar(2,2, 2), cv::Scalar(2,2, 2), 8);
            cv::dilate(image, image, kernel);
            cv::addWeighted(image1, alpha, image, beta, 0.0, image);
            
            cv::floodFill(image, mask, seed3, cv::Scalar(50, 155, 20) ,0, cv::Scalar(2,2, 2), cv::Scalar(2,2, 2), 8);
            
            cv::dilate(image, image, kernel);
            
            cv::addWeighted(image1, alpha, image, beta, 0.0, image);
            
        }
    } catch (Exception ex) {
        //NSLog(@"%@", ex.);
    }
    
    cv::cvtColor(image, image, cv::COLOR_RGB2BGR);//in-use
    
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.image = [self UIImageFromCVMat:image];
    
    

    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

NSArray *array = [NSArray arrayWithObjects:@"SimpleTableViewCell",@"SimpleTableViewCell1",@"SimpleTableViewCell2",nil];


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
   static NSString *cellId = @"SimpleTableViewCell";
    SimpleTableViewCell *cell = [[SimpleTableViewCell alloc] init];
    switch (indexPath.row) {
        case 0:
        {
            SimpleTableViewCell * cell = (SimpleTableViewCell *)[tableView dequeueReusableCellWithIdentifier:array[0]];
            cell.buttonOne.tag = indexPath.row;
            [cell.buttonOne addTarget:self action:@selector(selectVizBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
            
            if (cell == nil) {
                NSArray *nib =[[NSBundle mainBundle] loadNibNamed:@"SimpleTableViewCell" owner:self options:nil ];
                cell = [nib objectAtIndex:0];
            }
            
//            cell.productTitle.text = @"Berger Vanisher";
//            cell.companyName.text = @"Berger Paint Nigeria Limited";
//            cell.imageView.image = [UIImage imageNamed:@"images/realngn"];
            
            return cell;
        }
        case 1:{
            SimpleTableViewCell1 * cell = (SimpleTableViewCell1 *)[tableView dequeueReusableCellWithIdentifier:array[1]];
            cell.buttonOne.tag = indexPath.row;
            [cell.buttonOne addTarget:self action:@selector(mapBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
            
            if (cell == nil) {
                NSArray *nib =[[NSBundle mainBundle] loadNibNamed:@"SimpleTableViewCell1" owner:self options:nil ];
                cell = [nib objectAtIndex:0];
            }
            
//            cell.productTitle.text = @"Berger Vanisher";
//            cell.companyName.text = @"Berger Paint Nigeria Limited";
//            cell.imageView.image = [UIImage imageNamed:@"images/realngn"];
            
            return cell;
      
    }
        case 2:{
            SimpleTableViewCell2 * cell = (SimpleTableViewCell2 *)[tableView dequeueReusableCellWithIdentifier:array[2]];
            cell.buttonOne.tag = indexPath.row;
            [cell.buttonOne addTarget:self action:@selector(motionBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
            
            if (cell == nil) {
                NSArray *nib =[[NSBundle mainBundle] loadNibNamed:@"SimpleTableViewCell2" owner:self options:nil ];
                cell = [nib objectAtIndex:0];
            }
            
//            cell.productTitle.text = @"Berger Vanisher";
//            cell.companyName.text = @"Berger Paint Nigeria Limited";
//            cell.imageView.image = [UIImage imageNamed:@"images/realngn"];
            
            return cell;
        }
    
        
}
    return cell;
}
-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES ];

}

-(void)motionBtnClicked:(id)sender{
    UIButton *senderBtn = (UIButton *) sender;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    UITableViewController *myNewVC = [storyboard instantiateViewControllerWithIdentifier:@"CategoryViewController"];
    [self.navigationController pushViewController:myNewVC animated:YES];

    NSLog(@"current row %ld", senderBtn.tag);
}

-(void)mapBtnClicked:(id)sender{
    UIButton *senderBtn = (UIButton *) sender;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    UITableViewController *myNewVC = [storyboard instantiateViewControllerWithIdentifier:@"MapViewController"];
    [self.navigationController pushViewController:myNewVC animated:YES];
    
    NSLog(@"current row %ld", senderBtn.tag);
}
-(void)selectVizBtnClicked:(id)sender{
    UIButton *senderBtn = (UIButton *) sender;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    UITableViewController *myNewVC = [storyboard instantiateViewControllerWithIdentifier:@"SelectVisualizerTypeController"];
    [self.navigationController pushViewController:myNewVC animated:YES];
    
    NSLog(@"current row %ld", senderBtn.tag);
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  array.count;
}

- (cv::Mat)cvMatFromUIImage:(UIImage *)image
{
    CGColorSpaceRef colorSpace = CGImageGetColorSpace(image.CGImage);
    CGFloat cols = image.size.width;
    CGFloat rows = image.size.height;
    
    cv::Mat cvMat(rows, cols, CV_8UC4); // 8 bits per component, 4 channels (color channels + alpha)
    
    CGContextRef contextRef = CGBitmapContextCreate(cvMat.data,                 // Pointer to  data
                                                    cols,                       // Width of bitmap
                                                    rows,                       // Height of bitmap
                                                    8,                          // Bits per component
                                                    cvMat.step[0],              // Bytes per row
                                                    colorSpace,                 // Colorspace
                                                    kCGImageAlphaNoneSkipLast |
                                                    kCGBitmapByteOrderDefault); // Bitmap info flags
    
    CGContextDrawImage(contextRef, CGRectMake(0, 0, cols, rows), image.CGImage);
    CGContextRelease(contextRef);
    
    return cvMat;
}

-(UIImage *)UIImageFromCVMat:(cv::Mat)cvMat
{
    NSData *data = [NSData dataWithBytes:cvMat.data length:cvMat.elemSize()*cvMat.total()];
    CGColorSpaceRef colorSpace;
    
    if (cvMat.elemSize() == 1) {
        colorSpace = CGColorSpaceCreateDeviceGray();
    } else {
        colorSpace = CGColorSpaceCreateDeviceRGB();
    }
    
    CGDataProviderRef provider = CGDataProviderCreateWithCFData((__bridge CFDataRef)data);
    
    // Creating CGImage from cv::Mat
    CGImageRef imageRef = CGImageCreate(cvMat.cols,                                 //width
                                        cvMat.rows,                                 //height
                                        8,                                          //bits per component
                                        8 * cvMat.elemSize(),                       //bits per pixel
                                        cvMat.step[0],                            //bytesPerRow
                                        colorSpace,                                 //colorspace
                                        kCGImageAlphaNone|kCGBitmapByteOrderDefault,// bitmap info
                                        provider,                                   //CGDataProviderRef
                                        NULL,                                       //decode
                                        false,                                      //should interpolate
                                        kCGRenderingIntentDefault                   //intent
                                        );
    
    
    // Getting UIImage from CGImage
    UIImage *finalImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    CGDataProviderRelease(provider);
    CGColorSpaceRelease(colorSpace);
    
    return finalImage;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    location= [touch locationInView:touch.view];
    NSLog(@"%f%f",location.x,location.y);
    
    [self reloadInputViews];
}
//- (void)encodeWithCoder:(nonnull NSCoder *)aCoder {
//    <#code#>
//}
//
//- (void)traitCollectionDidChange:(nullable UITraitCollection *)previousTraitCollection {
//    <#code#>
//}
//
//- (void)preferredContentSizeDidChangeForChildContentContainer:(nonnull id<UIContentContainer>)container {
//    <#code#>
//}

//- (CGSize)sizeForChildContentContainer:(nonnull id<UIContentContainer>)container withParentContainerSize:(CGSize)parentSize {
//    <#code#>
//}

//- (void)systemLayoutFittingSizeDidChangeForChildContentContainer:(nonnull id<UIContentContainer>)container {
//    <#code#>
//}
//
//- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(nonnull id<UIViewControllerTransitionCoordinator>)coordinator {
//    <#code#>
//}
//
//- (void)willTransitionToTraitCollection:(nonnull UITraitCollection *)newCollection withTransitionCoordinator:(nonnull id<UIViewControllerTransitionCoordinator>)coordinator {
//    <#code#>
//}
//
//- (void)didUpdateFocusInContext:(nonnull UIFocusUpdateContext *)context withAnimationCoordinator:(nonnull UIFocusAnimationCoordinator *)coordinator {
//    <#code#>
//}
//
//- (void)setNeedsFocusUpdate {
//    <#code#>
//}
//
//- (BOOL)shouldUpdateFocusInContext:(nonnull UIFocusUpdateContext *)context {
//    return false;
//}
//
//- (void)updateFocusIfNeeded {
//    <#code#>
//}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
            return 215;
            break;
        case 1:
            return 215;
            break;
        case 2:
            return 215;
            break;
            
    }
    return 0;
}
@end
