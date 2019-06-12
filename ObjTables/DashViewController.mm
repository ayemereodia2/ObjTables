//
//  DashViewController.m
//  ObjTables
//
//  Created by mac on 3/18/19.
//  Copyright © 2019 bergerpaint. All rights reserved.
//

#import "DashViewController.h"
#import "WelcomeViewCell2.h"
#import "DashboardOptionViewCell2.h"

@interface DashViewController ()

@end

@implementation DashViewController
@synthesize NewDashboardTable = _NewDashboardTable;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.navigationController setNavigationBarHidden:YES ];
    
    [self.NewDashboardTable registerNib:[UINib nibWithNibName:@"WelcomeViewCell2" bundle:nil] forCellReuseIdentifier:@"WelcomeViewCell2"];
    
     [self.NewDashboardTable registerNib:[UINib nibWithNibName:@"DashboardOptionViewCell2" bundle:nil] forCellReuseIdentifier:@"DashboardOptionViewCell2"];
    
    self.NewDashboardTable.delegate = self;
    self.NewDashboardTable.dataSource = self;
    self.NewDashboardTable.allowsSelection = YES;
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    [self.view addGestureRecognizer:singleTap];
}


NSArray *dashbarrays = [NSArray arrayWithObjects:@"WelcomeViewCell2",@"DashboardOptionViewCell2",nil];


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    WelcomeViewCell2 *cell = [[WelcomeViewCell2 alloc] init];

    switch (indexPath.row) {
        case 0:
        {
            WelcomeViewCell2 * cell = (WelcomeViewCell2 *)[tableView dequeueReusableCellWithIdentifier:dashbarrays[0]];
            
            cell.optionsButton.tag = indexPath.row;
            [cell.optionsButton addTarget:self action:@selector(ShowMenuBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
            
            if (cell == nil) {
                NSArray *nib =[[NSBundle mainBundle] loadNibNamed:@"WelcomeViewCell2" owner:self options:nil ];
                cell = [nib objectAtIndex:0];
            }
            
            return cell;
        }
        case 1:
        {
            DashboardOptionViewCell2 * cell = (DashboardOptionViewCell2 *)[tableView dequeueReusableCellWithIdentifier:dashbarrays[1]];
            cell.visualizerOptionsButton.tag = indexPath.row;

             [cell.visualizerOptionsButton addTarget:self action:@selector(visualizerOptionsClicked:) forControlEvents:UIControlEventTouchUpInside];
             [cell.mapButton addTarget:self action:@selector(mapBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
             [cell.colorsButton addTarget:self action:@selector(colorsBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
             [cell.selectProductsButton addTarget:self action:@selector(selectProductsClicked:) forControlEvents:UIControlEventTouchUpInside];
            
            if (cell == nil) {
                NSArray *nib =[[NSBundle mainBundle] loadNibNamed:@"DashboardOptionViewCell2" owner:self options:nil ];
                cell = [nib objectAtIndex:0];
            }
            
            return cell;
        }
            
    }
    
    return cell;
}


- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  dashbarrays.count;
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0)
    {
        return 125;
    }
    else{
        return 477;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}

-(void)ShowMenuBtnClicked:(id)sender{
    self.alertVC = [UIAlertController alertControllerWithTitle:@"" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *button = [UIAlertAction actionWithTitle:@"Share App"
                                                     style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction *action){
                                                       //add code to make something happen once tapped
                                                   }];
    UIAlertAction *button2 = [UIAlertAction actionWithTitle:@"Return to Home"
                                                      style:UIAlertActionStyleDefault
                                                    handler:^(UIAlertAction *action){
                                                        //add code to make something happen once tapped
                                                    }];
    
    UIAlertAction *button3 = [UIAlertAction actionWithTitle:@"Exit"
                                                      style:UIAlertActionStyleDefault
                                                    handler:^(UIAlertAction *action){
                                                        //add code to make something happen once tapped
                                                    }];

    [self.alertVC addAction:button3];
    [self.alertVC addAction:button2];
    [self.alertVC addAction:button];

    [self presentViewController:self.alertVC animated:YES completion:nil];
}



-(void)visualizerOptionsClicked:(id)sender
{
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    UITableViewController *myNewVC = [storyboard instantiateViewControllerWithIdentifier:@"SelectVisualizerTypeController"];
    [self.navigationController pushViewController:myNewVC animated:YES];

}

-(void)colorsBtnClicked:(id)sender{
    
    
    
}

-(void)mapBtnClicked:(id)sender{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];

    UITableViewController *myNewVC = [storyboard instantiateViewControllerWithIdentifier:@"MapViewController"];
    [self.navigationController pushViewController:myNewVC animated:YES];
    
}
-(void)selectProductsClicked:(id)sender{
    
    
    
}


@end
