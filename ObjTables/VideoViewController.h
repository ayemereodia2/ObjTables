//
//  VideoViewController.h
//  ObjTables
//
//  Created by mac on 9/13/18.
//  Copyright © 2018 bergerpaint. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <opencv2/videoio/cap_ios.h>
#import "ColorsRGB.h"
#import <Photos/Photos.h>

using namespace cv;

@interface VideoViewController : UIViewController<CvVideoCameraDelegate>
{
    IBOutlet UIImageView* imageView;
    CvPhotoCamera* photoCamera;
    CvVideoCamera* videoCamera;
    CGPoint location;
    cv::Mat marker;
    cv::Point pointos;
    cv::Scalar SelectedColor;
}
@property (nonatomic, weak) IBOutlet UIButton* loadButton;
@property (nonatomic, retain) CvPhotoCamera* photoCamera;
@property (nonatomic, retain) CvVideoCamera* videoCamera;
@property (nonatomic, retain)  UIPopoverController* popoverController;
@property (nonatomic, retain) IBOutlet UIButton* showBerger;
@property (nonatomic, weak) IBOutlet UIButton* saveImage;
@property (nonatomic, weak) IBOutlet UIButton* goBackOnce;

@property (nonatomic, retain) ColorsRGB* selectedColors;
+(UIImage *)processViews:(UIImage *)srcimage startPoint:(CGPoint )point newColor:(ColorsRGB *)newcolor lodiff:(int )diff;

- (IBAction)goBack:(UIButton*)sender;
- (IBAction)showBerger:(id)sender;
-(IBAction)saveImage:(UIButton*)sender;


//@property (nonatomic, retain) IBOutlet UIImageView* imageView;

//@property (nonatomic, strong) IBOutlet UITableView *sampletable;

@end
