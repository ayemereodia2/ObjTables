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

@interface ImageViewController ()

@end

@implementation ImageViewController
@synthesize photoCamera = _photoCamera;
@synthesize videoCamera = _videoCamera;
@synthesize imageView2 = _imageView2;

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
        
        
        self.imageView2.image = [VideoViewController processViews:self.imageView2.image startPoint:tpoint newColor:colorz lodiff:10];

        NSLog(@"%f%f",location.x,location.y);
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

@end
