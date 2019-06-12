//
//  ImageViewController.h
//  ObjTables
//
//  Created by mac on 9/13/18.
//  Copyright © 2018 bergerpaint. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <opencv2/videoio/cap_ios.h>
#import "Models/Pointed.h"

using namespace cv;

@interface ImageViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate,CvVideoCameraDelegate>
{
    //IBOutlet UIImageView* imageView;
    CvPhotoCamera* photoCamera;
    CvVideoCamera* videoCamera;
    CGPoint location;
   // NSMutableArray* mPointsArray;

}
@property (nonatomic, weak) IBOutlet UIButton* loadButton;
@property (nonatomic, retain) CvPhotoCamera* photoCamera;
@property (nonatomic, retain) CvVideoCamera* videoCamera;
@property (nonatomic, retain)  UIPopoverController* popoverController;
@property (nonatomic, weak) IBOutlet UIButton* clearPhoto;
@property (nonatomic, retain) IBOutlet UIButton* showBerger;
@property (nonatomic, retain) IBOutlet UIButton* BackButton;
@property (nonatomic, retain) IBOutlet UIButton* SaveStillButton;
@property (nonatomic, retain) IBOutlet UIButton* FromCameraButton;
@property (nonatomic, retain) NSMutableArray* mPointsArray;
@property (nonatomic, assign) int counter;
@property NSMutableArray *ArrayContainer;
@property NSMutableArray *ArrayContainer2;
@property IBOutlet UIView * curvedView2;

- (IBAction)actionStart:(id)sender;

@property (nonatomic, retain) IBOutlet UIImageView* imageView2;

-(IBAction)goBack:(UIButton*)sender;
-(IBAction)selectPhoto:(UIButton *)sender;
-(IBAction)clearPhotos:(UIButton *)sender;
-(IBAction)saveImage2:(UIButton*)sender;
-(IBAction)ChooseImageFromCamera:(UIButton*)sender;


//@property (nonatomic, strong) IBOutlet UITableView *sampletable;

@end
