//
//  CategoryViewController.m
//  ObjTables
//
//  Created by mac on 9/14/18.
//  Copyright © 2018 bergerpaint. All rights reserved.
//

#import "CategoryViewController.h"
#import "decorativeViewCell.h"
#import "nonDecorativeViewCell.h"
@interface CategoryViewController ()

@end

@implementation CategoryViewController
@synthesize sampletable = _sampletable;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController setNavigationBarHidden:YES];
    
    [self.sampletable registerNib:[UINib nibWithNibName:@"decorativeViewCell" bundle:nil] forCellReuseIdentifier:@"decorativeViewCell"];
    [self.sampletable registerNib:[UINib nibWithNibName:@"nonDecorativeViewCell" bundle:nil] forCellReuseIdentifier:@"nonDecorativeViewCell"];
    
    self.sampletable.delegate = self;
    self.sampletable.dataSource = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES ];
    
}


NSArray *cellarrays = [NSArray arrayWithObjects:@"decorativeViewCell",@"nonDecorativeViewCell",nil];

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    // static NSString *cellId = @"SimpleTableViewCell";
    decorativeViewCell *cell = [[decorativeViewCell alloc] init];
    switch (indexPath.row) {
        case 0:
        {
            decorativeViewCell * cell = (decorativeViewCell *)[tableView dequeueReusableCellWithIdentifier:cellarrays[0]];
            cell.buttonOne.tag = indexPath.row;
            //cell.backButton.tag = indexPath.row;
            
            [cell.buttonOne addTarget:self action:@selector(gotoDecoProductsListBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
            
//            [cell.backButton addTarget:self action:@selector(gotoBackBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
            
            if (cell == nil) {
                NSArray *nib =[[NSBundle mainBundle] loadNibNamed:@"decorativeViewCell" owner:self options:nil ];
                cell = [nib objectAtIndex:0];
            }
            
            return cell;
        }
        case 1:{
            nonDecorativeViewCell * cell = (nonDecorativeViewCell *)[tableView dequeueReusableCellWithIdentifier:cellarrays[1]];
            cell.buttonOne.tag = indexPath.row;
            [cell.buttonOne addTarget:self action:@selector(gotoNonDecoListBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
            
            if (cell == nil) {
                NSArray *nib =[[NSBundle mainBundle] loadNibNamed:@"nonDecorativeViewCell" owner:self options:nil ];
                cell = [nib objectAtIndex:0];
            }
            
            return cell;
            
        }
            
            
            
    }
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  cellarrays.count;
}

-(void)gotoDecoProductsListBtnClicked:(id)sender{
    UIButton *senderBtn = (UIButton *) sender;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    UITableViewController *myNewVC = [storyboard instantiateViewControllerWithIdentifier:@"DetailsViewController2"];
    [self.navigationController pushViewController:myNewVC animated:YES];
    
    NSLog(@"current row %ld", senderBtn.tag);
}

-(void)gotoNonDecoListBtnClicked:(id)sender{
    UIButton *senderBtn = (UIButton *) sender;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    UITableViewController *myNewVC = [storyboard instantiateViewControllerWithIdentifier:@"DetailsViewController"];
    [self.navigationController pushViewController:myNewVC animated:YES];
    
    NSLog(@"current row %ld", senderBtn.tag);
}

-(IBAction)gotoBackBtnClicked:(id)sender{
    UIButton *senderBtn = (UIButton *) sender;
    [self.navigationController popViewControllerAnimated:YES];
    
    NSLog(@"current row %ld", senderBtn.tag);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
            return 280;
            break;
        case 1:
            return 280;
            break;
            
            
    }
    return 0;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
