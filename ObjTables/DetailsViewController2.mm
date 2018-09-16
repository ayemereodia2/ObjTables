//
//  DetailsViewController2.m
//  ObjTables
//
//  Created by mac on 9/14/18.
//  Copyright © 2018 bergerpaint. All rights reserved.
//

#import "DetailsViewController2.h"
#import "DetailsViewCell2.h"
#import "Models/Decorative.h"
@interface DetailsViewController2 ()

@end

@implementation DetailsViewController2
@synthesize title = _title;
@synthesize description = _description;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController setNavigationBarHidden:YES ];
    
    [self.sampletable registerNib:[UINib nibWithNibName:@"DetailsViewCell1" bundle:nil] forCellReuseIdentifier:@"DetailsViewCell1"];
    
    self.sampletable.delegate = self;
    self.sampletable.dataSource = self;
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


Decorative *paint11 = [[Decorative alloc]initWithValues:@"AUTOLUX" description:@"High Quality auto paint for refurbishing of automobies and bodyframes. They come in three forms: Autolux KH, Autoctryl and Cellulose Primer Grey" imagepath:@"images/path"];
Decorative *paint22 = [[Decorative alloc]initWithValues:@"BERGER PROTECTION" description:@"These consist of wide range of protective paints products such as Epoxy Coatingd Acrylic Polyurethane(PM7750/7756), Marine Coatings(Alkyd GlossPM 1800), Auto fouling Paints, Silicone Heat Resisting PM5600/5601, Bright Aluminum and Road Marking." imagepath:@"images/path" ];
Decorative *paint33 = [[Decorative alloc]initWithValues:@"BERGERNOL" description:@"Bergernol is a wood paint used for treating and preserving wood from fungi and insect attack. It is ideal for wood surfaces that are to be painted for treatment and for rafter fences." imagepath:@"images/path" ];
Decorative *paint44 = [[Decorative alloc]initWithValues:@"PAINT THINNER" description:@"Paint Thinner is a solvent based paint by product used to decrease viscosity of paint. It is available in decorative and non-decorative forms." imagepath:@"images/path" ];
Decorative *paint55 = [[Decorative alloc]initWithValues:@"LIGNOLAC" description:@"Lignolac is our trade name for wood finishes that provides the best of finishes to give a charming appearance. It enhances the grain and makes the wood appear attractive" imagepath:@"images/path" ];
Decorative *paint66 = [[Decorative alloc]initWithValues:@"LIGNOLAC" description:@"Lignolac is our trade name for wood finishes that provides the best of finishes to give a charming appearance. It enhances the grain and makes the wood appear attractive" imagepath:@"images/path" ];
Decorative *paint77 = [[Decorative alloc]initWithValues:@"LIGNOLAC" description:@"Lignolac is our trade name for wood finishes that provides the best of finishes to give a charming appearance. It enhances the grain and makes the wood appear attractive" imagepath:@"images/path" ];
Decorative *paint88 = [[Decorative alloc]initWithValues:@"LIGNOLAC" description:@"Lignolac is our trade name for wood finishes that provides the best of finishes to give a charming appearance. It enhances the grain and makes the wood appear attractive" imagepath:@"images/path" ];
Decorative *paint99 = [[Decorative alloc]initWithValues:@"LIGNOLAC" description:@"Lignolac is our trade name for wood finishes that provides the best of finishes to give a charming appearance. It enhances the grain and makes the wood appear attractive" imagepath:@"images/path" ];

NSArray *paintarrays = [NSArray arrayWithObjects:paint11,paint22,paint33,paint44,paint55,paint66,paint77,paint88,paint99, nil];


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {

    DetailsViewCell2 * cell = (DetailsViewCell2 *)[tableView dequeueReusableCellWithIdentifier:@"DetailsViewCell2"];
    Decorative *paintz = (Decorative*)paintarrays[indexPath.row];
    cell.title.text = paintz.nameOfPaint;
    cell.subdescription.text = paintz.DescriptionOfPaint;
    cell.image.image = [UIImage imageNamed:paintz.ImagePath];
    //            [cell.buttonOne addTarget:self action:@selector(gotoDecoProductsListBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    //
    //            [cell.backButton addTarget:self action:@selector(gotoBackBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    if (cell == nil) {
        NSArray *nib =[[NSBundle mainBundle] loadNibNamed:@"DetailsViewCell2" owner:self options:nil ];
        cell = [nib objectAtIndex:0];
    }
    
    return cell;
    
    
    
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  paintarrays.count;
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
    return 200;
}

@end
