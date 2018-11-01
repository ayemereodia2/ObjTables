//
//  ColorPalleteViewController.h
//  ObjTables
//
//  Created by mac on 9/14/18.
//  Copyright © 2018 bergerpaint. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol sendBackData<NSObject>
-(void)sendColorToVideo:(UIColor*)color;
@end
@interface ColorPalleteViewController : UIViewController<UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) IBOutlet UICollectionView *samplecollection;
-(UIColor *)colorFromHexString:(NSString*)hexString;
-(IBAction)gotoBackBtnClicked:(id)sender;
@property (nonatomic, weak) IBOutlet UIButton *backButton;
@property(nonatomic,assign)id delegate;
@end
