//
//  DetailsViewController.m
//  ObjTables
//
//  Created by mac on 9/10/18.
//  Copyright © 2018 bergerpaint. All rights reserved.
//

#import "DetailsViewController.h"
#import "DetailsViewCell1.h"
#import "Models/NonDecorative.h"
@interface DetailsViewController ()

@end

@implementation DetailsViewController
@synthesize title = _title;
@synthesize description = _description;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES ];
    
    [self.sampletable registerNib:[UINib nibWithNibName:@"DetailsViewCell1" bundle:nil] forCellReuseIdentifier:@"DetailsViewCell1"];
    
    self.sampletable.delegate = self;
    self.sampletable.dataSource = self;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)gotoBackBtnClicked:(id)sender{
    UIButton *senderBtn = (UIButton *) sender;
    [self.navigationController popViewControllerAnimated:YES];
    
    NSLog(@"current row %ld", senderBtn.tag);
}

NonDecorative *paint1 = [[NonDecorative alloc]initWithValues:@"AUTOLUX" description:@"High Quality auto paint for refurbishing of automobies and bodyframes. They come in three forms: Autolux KH, Autoctryl and Cellulose Primer Grey"];
NonDecorative *paint2 = [[NonDecorative alloc]initWithValues:@"BERGER PROTECTION" description:@"These consist of wide range of protective paints products such as Epoxy Coatingd Acrylic Polyurethane(PM7750/7756), Marine Coatings(Alkyd GlossPM 1800), Auto fouling Paints, Silicone Heat Resisting PM5600/5601, Bright Aluminum and Road Marking." ];
NonDecorative *paint3 = [[NonDecorative alloc]initWithValues:@"BERGERNOL" description:@"Bergernol is a wood paint used for treating and preserving wood from fungi and insect attack. It is ideal for wood surfaces that are to be painted for treatment and for rafter fences." ];
NonDecorative *paint4 = [[NonDecorative alloc]initWithValues:@"PAINT THINNER" description:@"Paint Thinner is a solvent based paint by product used to decrease viscosity of paint. It is available in decorative and non-decorative forms." ];
NonDecorative *paint5 = [[NonDecorative alloc]initWithValues:@"LIGNOLAC" description:@"Lignolac is our trade name for wood finishes that provides the best of finishes to give a charming appearance. It enhances the grain and makes the wood appear attractive" ];

NSArray *paintarray = [NSArray arrayWithObjects:paint1,paint2,paint3,paint4,paint5, nil];

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
   
    
    
    DetailsViewCell1 * cell = (DetailsViewCell1 *)[tableView dequeueReusableCellWithIdentifier:@"DetailsViewCell1"];
    NonDecorative *paintz = (NonDecorative*)paintarray[indexPath.row];
    cell.title.text = paintz.nameOfPaint;
    cell.subdescription.text = paintz.DescriptionOfPaint;
    
    //            [cell.buttonOne addTarget:self action:@selector(gotoDecoProductsListBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    //
    //            [cell.backButton addTarget:self action:@selector(gotoBackBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    if (cell == nil) {
        NSArray *nib =[[NSBundle mainBundle] loadNibNamed:@"DetailsViewCell1" owner:self options:nil ];
        cell = [nib objectAtIndex:0];
    }
    
    return cell;
            
            
    
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  paintarray.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 196;
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
