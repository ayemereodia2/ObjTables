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
#import "ShowDetailsViewController.h"

@interface DetailsViewController2 ()

@end

@implementation DetailsViewController2
@synthesize title = _title;
@synthesize description = _description;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController setNavigationBarHidden:YES ];
    
    [self.sampletable registerNib:[UINib nibWithNibName:@"DetailsViewCell2" bundle:nil] forCellReuseIdentifier:@"DetailsViewCell2"];
    
    
    self.sampletable.delegate = self;
    self.sampletable.dataSource = self;
    self.sampletable.allowsSelection = YES;
    
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


Decorative *paint11 = [[Decorative alloc]initWithValues:@"LUXOL EMULSION-4L & 20L" description:@"Luxol is a premium water based acrylic matt emulsion, suitable for interior and exterior decoration. it gives a brilliant finish on the wall and specially fortified against fungi and mould attack,leaving the walls beautiful for a lonf time" imagepath:@"1" TDT:@"30 minutes" HDT:@"2 hours" AREOU:@"Interior and Exterior" CC:@"10-12 meters square per litre"];
Decorative *paint22 = [[Decorative alloc]initWithValues:@"LUXOL GLOSS-4L &  20L" description:@"Air drying paint with high gloss. Specially formulated to prevent mould and fungi growth on walls. It is suitable for internal and External decoration." imagepath:@"2" TDT:@"6 hours" HDT:@"24 hours" AREOU:@"Interior or Exterior" CC:@"10 meters square per litre"];
Decorative *paint33 = [[Decorative alloc]initWithValues:@"SUPER STAR EMULSION-4L & 20L" description:@"Water based Matt finish, suitable for interior and exterior purpose. Specially formulted to prevent Mould growth." imagepath:@"3" TDT:@"18 minutes" HDT:@"2 hours" AREOU:@"Interior or Exterior" CC:@"8-9 meters square per litre" ];
Decorative *paint44 = [[Decorative alloc]initWithValues:@"SUPER STAR GLOSS-4L & 20L" description:@"This is a quality and affordable air drying paint, perfect for transforming the outdoor and indoor space into a colorful environment in a very short time." imagepath:@"3" TDT:@"5 minutes" HDT:@"18 minutes" AREOU:@"Interior or Exterior" CC:@"8-9 meters square per litre" ];
Decorative *paint55 = [[Decorative alloc]initWithValues:@"SUPATEX-4L & 20L" description:@"An affordable quality textured paint that provides a stony and fine patterned finish on walls" imagepath:@"4" TDT:@"" HDT:@"" AREOU:@"" CC:@"" ];
Decorative *paint66 = [[Decorative alloc]initWithValues:@"CLINSTAY 20L" description:@"A washable emulsion paint with satin finish(mild gloss). Easily washable to remove dirt and stains. It is a high perfomance finish that allows for easy cleaning , light scrubbing and specially formulated for high traffic areas." imagepath:@"5" TDT:@"30 minutes" HDT:@"2 hours" AREOU:@"Interior or Exterior" CC:@"12 meters square per litre" ];
Decorative *paint77 = [[Decorative alloc]initWithValues:@"RUFHIDE-20L" description:@"A premium water based putty with superior adhesive strenght for wall preparation, covering of minor cracks and holes before painting" imagepath:@"6" TDT:@"3 hours" HDT:@"8 hours" AREOU:@"Interior and Exterior" CC:@"10 meters square per litre" ];
Decorative *paint88 = [[Decorative alloc]initWithValues:@"ROBBIALAC-4L & 20L" description:@"Robbialac Emulsion is an emulsion paint that provides long lasting smooth finish on walls. It is very affordable, durable and highly recommended for interior purpose" imagepath:@"7" TDT:@"18 minutes" HDT:@"24 hours" AREOU:@"Interior and Exterior" CC:@"6-8 meters square per litre"];
Decorative *paint99 = [[Decorative alloc]initWithValues:@"FIRE RETARDANT TEXCOTE-20L" description:@"A high quality textured paint with superior light fast pigment. Specially formulated to retard the spread of fire and also prevent the growth of algea and fungi attack." imagepath:@"9"  TDT:@"18 minutes" HDT:@"24 hours" AREOU:@"Interior and Exterior" CC:@"8-9 meters square per liter"];

NSArray *paintarrays = [NSArray arrayWithObjects:paint11,paint22,paint33,paint55,paint66,paint77,paint88,paint99, nil];


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {

    DetailsViewCell2 * cell = (DetailsViewCell2 *)[tableView dequeueReusableCellWithIdentifier:@"DetailsViewCell2"];
    Decorative *paintj = (Decorative*)paintarrays[indexPath.row];
    cell.title.text = paintj.nameOfPaint;
    cell.subdescription.text = paintj.DescriptionOfPaint;
    cell.image.image = [UIImage imageNamed:paintj.ImagePath];
//                [cell.transButton addTarget:self action:@selector(gotoDecoProductsListBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
//
    //            [cell.backButton addTarget:self action:@selector(gotoBackBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    if (cell == nil) {
        NSArray *nib =[[NSBundle mainBundle] loadNibNamed:@"DetailsViewCell2" owner:self options:nil ];
        cell = [nib objectAtIndex:0];
    }
    
    return cell;
    
    
    
}

-(void)gotoDecoProductsListBtnClicked:(id)sender{
    UIButton *senderBtn = (UIButton *) sender;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    UITableViewController *myNewVC = [storyboard instantiateViewControllerWithIdentifier:@"ShowDetailsViewController"];
    [self.navigationController pushViewController:myNewVC animated:YES];
    
    NSLog(@"current row %ld", senderBtn.tag);
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


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"%@", paintarrays[indexPath.row]);
   // Decorative *paintk = (Decorative*)paintarrays[indexPath.row];

    //UIButton *senderBtn = (UIButton *) sender;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
     ShowDetailsViewController *myNewVC = [storyboard instantiateViewControllerWithIdentifier:@"ShowDetailsViewController"];
//    NSError* error = nil;//[[NSError alloc]initWithDomain:@"world" code:200 userInfo:nil];
//    NSArray* notifications = [NSArray arrayWithObjects:paintk.dictionary, nil];
    
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:notifications options:NSJSONWritingPrettyPrinted error:&error];
//
//    NSDictionary *result = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    //NSLog(@"%@",notifications[0]);
    //ShowDetailsViewController * Shwvc = [[ShowDetailsViewController alloc] init];
    myNewVC.decorate = (Decorative*)paintarrays[indexPath.row];
    
    //[[NSUserDefaults standardUserDefaults] setObject:notifications[0] forKey:@"myJSONParsed"];
    
    [self.navigationController pushViewController:myNewVC animated:YES];
}



@end
