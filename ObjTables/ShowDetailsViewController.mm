//
//  ShowDetailsViewController.m
//  ObjTables
//
//  Created by mac on 11/11/18.
//  Copyright © 2018 bergerpaint. All rights reserved.
//

#import "ShowDetailsViewController.h"
#import "ShowDetails1ViewCell.h"
#import "ShowDetails2ViewCell.h"
#import "Models/Decorative.h"

@interface ShowDetailsViewController ()

@end

@implementation ShowDetailsViewController
@synthesize detailviewtable = _detailviewtable;
@synthesize decorate = _decorate;
- (void)viewDidLoad {
    [super viewDidLoad];

    [self.navigationController setNavigationBarHidden:YES ];
    [self.detailviewtable registerNib:[UINib nibWithNibName:@"ShowDetails1ViewCell" bundle:nil] forCellReuseIdentifier:@"ShowDetails1ViewCell"];
    [self.detailviewtable registerNib:[UINib nibWithNibName:@"ShowDetails2ViewCell" bundle:nil] forCellReuseIdentifier:@"ShowDetails2ViewCell"];
    self.detailviewtable.separatorColor = UIColor.whiteColor;
    self.detailviewtable.delegate = self;
    self.detailviewtable.dataSource = self;
    self.Headerdescription.text = _decorate.nameOfPaint;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


//- (id)initWithDecor:(Decorative *)decor {
//    //self = [super initWithNibName:@"ShowDetailsViewController" bundle:nil];
//    if (self) {
//        self.decorate = decor;
//    }
//    return self;
//}



NSArray *detailscellarray = [NSArray arrayWithObjects:@"ShowDetails1ViewCell",@"ShowDetails2ViewCell",nil];

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    // static NSString *cellId = @"SimpleTableViewCell";
    ShowDetails1ViewCell *cell = [[ShowDetails1ViewCell alloc] init];
    switch (indexPath.row) {
        case 0:
        {
            ShowDetails1ViewCell * cell = (ShowDetails1ViewCell *)[tableView dequeueReusableCellWithIdentifier:detailscellarray[0]];
            
            cell.shownproductImage.image = [UIImage imageNamed:_decorate.ImagePath];
            cell.subheaderdescription.text = _decorate.DescriptionOfPaint;
            
            //cell.buttonOne.tag = indexPath.row;
            //cell.backButton.tag = indexPath.row;
            
//            [cell.buttonOne addTarget:self action:@selector(gotoVideoBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
            
            //            [cell.backButton addTarget:self action:@selector(gotoBackBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
            
            if (cell == nil) {
                NSArray *nib =[[NSBundle mainBundle] loadNibNamed:@"ShowDetails1ViewCell" owner:self options:nil ];
                cell = [nib objectAtIndex:0];
            }
            
            return cell;
        }
        case 1:{
            ShowDetails2ViewCell * cell = (ShowDetails2ViewCell *)[tableView dequeueReusableCellWithIdentifier:detailscellarray[1]];
            cell.TDTH.text = _decorate.TouchDryTime;
            cell.HDTH.text = _decorate.HardDryTime;
            cell.AREA.text =_decorate.AreaOfUse;
            cell.CCH.text = _decorate.CoverageCapacity;
            
//            cell.buttonOne.tag = indexPath.row;
//            [cell.buttonOne addTarget:self action:@selector(gotoImageBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
            
            if (cell == nil) {
                NSArray *nib =[[NSBundle mainBundle] loadNibNamed:@"ShowDetails2ViewCell" owner:self options:nil ];
                cell = [nib objectAtIndex:0];
            }
            
            return cell;
            
        }
            
            
            
    }
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  detailscellarray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
            return 289;
            break;
        case 1:
            return 149;
            break;
            
            
    }
    return 0;
}

- (IBAction)goBackBtnClicked:(UIButton*)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
}
/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
