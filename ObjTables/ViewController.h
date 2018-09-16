//
//  ViewController.h
//  ObjTables
//
//  Created by mac on 8/30/18.
//  Copyright © 2018 bergerpaint. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <opencv2/videoio/cap_ios.h>
using namespace cv;

@interface ViewController : UIViewController<UITableViewDelegate, UITableViewDataSource,CvVideoCameraDelegate,UIImagePickerControllerDelegate,
UINavigationControllerDelegate,
UIPopoverControllerDelegate>
{
    IBOutlet UIImageView* imageView;
    CvPhotoCamera* photoCamera;
    CvVideoCamera* videoCamera;
    CGPoint location;
    UIPopoverController* popoverController;
    
}
@property (nonatomic, weak) IBOutlet UIButton* loadButton;
@property (nonatomic, retain) CvPhotoCamera* photoCamera;
@property (nonatomic, retain) CvVideoCamera* videoCamera;
@property (nonatomic, retain)  UIPopoverController* popoverController;

- (IBAction)actionStart:(id)sender;

@property (nonatomic, retain) IBOutlet UIImageView* imageView;

@property (nonatomic, strong) IBOutlet UITableView *sampletable;
@end

