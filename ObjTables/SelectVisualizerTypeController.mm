//
//  SelectVisualizerTypeController.m
//  ObjTables
//
//  Created by mac on 9/13/18.
//  Copyright © 2018 bergerpaint. All rights reserved.
//

#import "SelectVisualizerTypeController.h"
#import "VideoViewCell.h"
#import "ImageViewCell.h"
@interface SelectVisualizerTypeController ()

@end

@implementation SelectVisualizerTypeController
@synthesize sampletable = _sampletable;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:YES ];
    [self.sampletable registerNib:[UINib nibWithNibName:@"VideoViewCell" bundle:nil] forCellReuseIdentifier:@"VideoViewCell"];
    [self.sampletable registerNib:[UINib nibWithNibName:@"ImageViewCell" bundle:nil] forCellReuseIdentifier:@"ImageViewCell"];
    
    self.sampletable.delegate = self;
    self.sampletable.dataSource = self;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES ];

}

NSArray *cellarray = [NSArray arrayWithObjects:@"VideoViewCell",@"ImageViewCell",nil];

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
   // static NSString *cellId = @"SimpleTableViewCell";
    VideoViewCell *cell = [[VideoViewCell alloc] init];
    switch (indexPath.row) {
        case 0:
        {
            VideoViewCell * cell = (VideoViewCell *)[tableView dequeueReusableCellWithIdentifier:cellarray[0]];
            cell.buttonOne.tag = indexPath.row;
            //cell.backButton.tag = indexPath.row;
            
            [cell.buttonOne addTarget:self action:@selector(gotoVideoBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
            
//            [cell.backButton addTarget:self action:@selector(gotoBackBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
            
            if (cell == nil) {
                NSArray *nib =[[NSBundle mainBundle] loadNibNamed:@"VideoViewCell" owner:self options:nil ];
                cell = [nib objectAtIndex:0];
            }
        
            return cell;
        }
        case 1:{
            ImageViewCell * cell = (ImageViewCell *)[tableView dequeueReusableCellWithIdentifier:cellarray[1]];
            cell.buttonOne.tag = indexPath.row;
            [cell.buttonOne addTarget:self action:@selector(gotoImageBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
            
            if (cell == nil) {
                NSArray *nib =[[NSBundle mainBundle] loadNibNamed:@"ImageViewCell" owner:self options:nil ];
                cell = [nib objectAtIndex:0];
            }
          
            return cell;
            
        }
      
            
            
    }
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  cellarray.count;
}

-(void)gotoVideoBtnClicked:(id)sender{
    UIButton *senderBtn = (UIButton *) sender;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    UITableViewController *myNewVC = [storyboard instantiateViewControllerWithIdentifier:@"VideoViewController"];
    [self.navigationController pushViewController:myNewVC animated:YES];
    
    NSLog(@"current row %ld", senderBtn.tag);
}

-(void)gotoImageBtnClicked:(id)sender{
    UIButton *senderBtn = (UIButton *) sender;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    UITableViewController *myNewVC = [storyboard instantiateViewControllerWithIdentifier:@"ImageViewController"];
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
