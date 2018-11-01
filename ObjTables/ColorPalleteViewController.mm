//
//  ColorPalleteViewController.m
//  ObjTables
//
//  Created by mac on 9/14/18.
//  Copyright © 2018 bergerpaint. All rights reserved.
//

#import "ColorPalleteViewController.h"
#import "PaintViewCell.h"
#import "VideoViewController.h"
@interface ColorPalleteViewController ()

@end

@implementation ColorPalleteViewController
@synthesize samplecollection = _samplecollection;
@synthesize delegate;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES ];

    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = 8;
    layout.minimumInteritemSpacing = 5;
    layout.itemSize = CGSizeMake(50, 74);
    // Do any additional setup after loading the view.
    self.samplecollection.collectionViewLayout = layout;
    self.samplecollection.delegate = self;
    self.samplecollection.dataSource = self;
    [self.samplecollection registerNib:[UINib nibWithNibName:@"PaintViewCell" bundle:nil] forCellWithReuseIdentifier:@"PaintViewCell"];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/





- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    PaintViewCell *cell = (PaintViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"PaintViewCell" forIndexPath:indexPath];
    //cell.title.text = @"COLORIZER 2000";
    cell.viewer.backgroundColor = [self colorFromHexString:colorarray[indexPath.row]];
    return cell;
}


- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return colorarray.count;
}

- (void)encodeWithCoder:(nonnull NSCoder *)aCoder {
    
}

- (void)traitCollectionDidChange:(nullable UITraitCollection *)previousTraitCollection {
    
}

- (void)preferredContentSizeDidChangeForChildContentContainer:(nonnull id<UIContentContainer>)container {
    
}

//- (CGSize)sizeForChildContentContainer:(nonnull id<UIContentContainer>)container withParentContainerSize:(CGSize)parentSize {
//
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
    return NO;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    VideoViewController *myNewVC = (VideoViewController *)[storyboard instantiateViewControllerWithIdentifier:@"VideoViewController"];
    //myNewVC.showBerger = [[UIButton alloc]init];
   // myNewVC.showBerger.backgroundColor = [self colorFromHexString:colorarray[indexPath.row]];
    [delegate sendColorToVideo:[self colorFromHexString:colorarray[indexPath.row]]];
    [self.navigationController popViewControllerAnimated:YES];

}

- (void)updateFocusIfNeeded {
    
}
-(UIColor *)colorFromHexString:(NSString*)hexString{
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1];
    //bypass # character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000)>>16)/255.0 green:((rgbValue & 0xFF00)>>8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}


-(IBAction)gotoBackBtnClicked:(id)sender{
    UIButton *senderBtn = (UIButton *) sender;
    [self.navigationController popViewControllerAnimated:YES];
    
    NSLog(@"current row %ld", senderBtn.tag);
}




NSArray *colorarray = [NSArray arrayWithObjects:@"#F0FCF0",@"#F5F1E6",@"#F4EEE1",@"#E9F2E3",@"#EFEEE7",@"#F7E7DC",@"F4ECDF",@"F7F0DA",@"#F5F0E4",@"#EBF1E5", @"#EFE8E5", @"#EAE0CF",@"#EBE4DA",@"#ECE2CF",@"#EEF2E9",@"#F6EBDE",@"#F3EBDF",@"#F7ECDC",@"#E2D5BE",@"#F4EFE7",@"#F2E9D6",@"#F2EDE1",@"#ECE2D5",@"#EDE1C8",@"#F3DDE4",@"#F3D4E3",@"#F1C6DC",@"#EEB8D6", @"#E8A1C8",@"#E08CBA",@"#D677AA",@"#AD3B6B",@"#F3E2E3",@"#E3BEC9",@"#D8ADBD",@"#CC9AAC",@"#BF879C",@"#A8697A",@"#985B6D",@"#724750",@"#F1E7E9",@"#EAC4D5",@"#E6B9CD",@"#E2A6BF",@"#DB93B0",@"#D687A6",@"#C26786",@"#9B475A",@"#F2E2E5",@"#F1BAC9",@"#ECA9BB",@"#E796AA",@"#DF8397",@"#CE6171",@"#CD5567",@"#A74140",@"#FAEAE6",@"#F7C4C7",@"#F5B9C1",@"#EFA6B0",@"EF96A5",@"#E3717D",@"#D35661",@"#CF403F",@"#F6E6E6",
                       @"#F2BEC7",
                       @"#EEABB8",
                       @"#E799A6",
                       @"#E18D9B",
                       @"#D5737F",
                       @"#D06B77",
                       @"#B64046",
                       @"#F4E7E4",
                       @"#F3CBCC",
                       @"#EDBBBC",
                       @"#E4A9AB",
                       @"#D79698",
                       @"#C88282",
                       @"#BC6E6B",
                       @"#994E49",
                       @"#F8E2DB",
                       @"#F7DAD2",
                       @"#F0C9C4",
                       @"#E2ABA3",
                       @"#D08E86",
                       @"#B16962",
                       @"#A95B50",
                       @"#965043",
                       @"#F9E8DD",
                       @"#FADED3",
                       @"#FDC7BA",
                       @"#FDB9AA",
                       @"#FBA596",
                       @"#F58A7B",
                       @"#EB725D",
                       @"#DF5043",
                       @"#F9EBE2",
                       @"#F9D0BE",
                       @"#FECDBA",
                       @"#F5B8A3",
                       @"#F5A891",
                       @"#E8886C",
                       @"#DD7057",
                       @"#C25744",
                       @"#F5DFCC",
                       @"#F5D6C2",
                       @"#F0C7AD",
                       @"#E7B397",
                       @"#DDA285",
                       @"#D28F72",
                       @"#C87D5C",
                       @"#AB634C",
                       @"#F6E5DB",
                       @"#F0C9BB",
                       @"#E6B9AA",
                       @"#DDA696",
                       @"#CC8F7E",
                       @"#BC7E6B",
                       @"#AF6A56",
                       @"#8D5346",
                       @"#F8E1D0",
                       @"#F7D5C2",
                       @"#F3C8B2",
                       @"#EDB69E",
                       @"#DC9982",
                       @"#CF7E63",
                       @"#C16E54",
                       @"#A75341",
                       @"#F9ECDF",
                       @"#FBE7D9",
                       @"#FCDBC4",
                       @"#F8CFB5",
                       @"#F8C4A8",
                       @"#F5A581",
                       @"#E97F58",
                       @"#E35E41",
                       @"#F8E5CF",
                       @"#F6DEC3",
                       @"#F4D6B4",
                       @"#F8D1AA",
                       @"#F9B787",
                       @"#F29F6F",
                       @"#EC8E57",
                       @"#E76E44",
                       @"#F7DFD2",
                       @"#F6D7C7",
                       @"#F1C9B8",
                       @"#EABAA5",
                       @"#E2A992",
                       @"#D39178",
                       @"#BC735B",
                       @"#9B5745",
                       @"#F6E6D6",
                       @"#EED1B4",
                       @"#EBC7AB",
                       @"#E1B696",
                       @"#CD9978",
                       @"#C28863",
                       @"#B27451",
                       @"#A0674B",
                       @"#F7E7D3",
                       @"#FAE1C8",
                       @"#F7D8B9",
                       @"#F4CBA7",
                       @"#E7AE80",
                       @"#DC9867",
                       @"#D08956",
                       @"#BC794F",
                       @"#ECD5BA",
                       @"#E4C9B0",
                       @"#E1BFA0",
                       @"#D4AF8E",
                       @"#C99C7A",
                       @"#BD9272",
                       @"#A0704D",
                       @"#91674D",
                       @"#F4E4D1",
                       @"#F4DDC6",
                       @"#EDD2B5",
                       @"#E5C6A5",
                       @"#D7AD84",
                       @"#C49367",
                       @"#BA875A",
                       @"#986C4D",
                       @"#F8EEDB",
                       @"#FFDFB5",
                       @"#FFD293",
                       @"#FFCC86",
                       @"#FFC576",
                       @"#FFB85F",
                       @"#FEA53D",
                       @"#F68B2D",
                       @"#FBECD6",
                       @"#F8DEBA",
                       @"#F9D9A5",
                       @"#FCD191",
                       @"#FDC172",
                       @"#F9B561",
                       @"#F2A641",
                       @"#E68B3E",
                       @"#F8EEE1",
                       @"#E4CEB6",
                       @"#DCC0A3",
                       @"#D0AE8F",
                       @"#BE9B79",
                       @"#B18964",
                       @"#A47B56",
                       @"#8B684E",
                       @"#F6EDDA",
                       @"#F1D8B6",
                       @"#E8CAA4",
                       @"#DFBD91",
                       @"#D4AB7C",
                       @"#C59965",
                       @"#BB8B57",
                       @"#99734B",
                       @"#F7E7C9",
                       @"#F5E1BB",
                       @"#EDD4A8",
                       @"#EBCE9D",
                       @"#DAB679",
                       @"#CDA55F",
                       @"#C39853",
                       @"#A98048",
                       @"#F8EFDB",
                       @"#F5DEB4",
                       @"#F5DBA8",
                       @"#F3D294",
                       @"#EAC480",
                       @"#DAAB57",
                       @"#C59347",
                       @"#A87C39",
                       @"#F8EED6",
                       @"#F6E5C3",
                       @"#F4D8A3",
                       @"#F0C988",
                       @"#E7BC71",
                       @"#DFAE5A",
                       @"#D7A24C",
                       @"#BB8849",
                       @"#FAF2DE",
                       @"#F8EED5",
                       @"#FBEAC7",
                       @"#FBDDA1",
                       @"#F8CD80",
                       @"#F3C36F",
                       @"#EEBB61",
                       @"#CD9037",
                       @"#FBF4DE",
                       @"#FCF3D4",
                       @"#FEEBB6",
                       @"#FFE6A1",
                       @"#FFDC85",
                       @"#FFD167",
                       @"#FFC740",
                       @"#FF9F9B",
                       @"#FAF3DD",
                       @"#F9F0D3",
                       @"#F7EAC3",
                       @"#F9DFA2",
                       @"#F6D68C",
                       @"#EFC66C",
                       @"#E4B653",
                       @"#D29A30",
                       @"#F7ECD1",
                       @"#F5E6C2",
                       @"#F2DEAD",
                       @"#EDD59B",
                       @"#DEBF72",
                       @"#CDA952",
                       @"#C19D42",
                       @"#9D7E37",
                       @"#F9F3DA",
                       @"#F4E9BD",
                       @"#EFE0A9",
                       @"#EAD897",
                       @"#E2CC7F",
                       @"#D8BF6A",
                       @"#CDB254",
                       @"#B49745",
                       @"#F7F1D6",
                       @"#F8EDBD",
                       @"#FCEAAC",
                       @"#FBE79F",
                       @"#F9E08B",
                       @"#F7D46D",
                       @"#F3C547",
                       @"#EDB22E",
                       @"#F7F3E2",
                       @"#FAF0BC",
                       @"#FDEDA9",
                       @"#FFE993",
                       @"#FFE481",
                       @"#FFDE6F",
                       @"#FBD04E",
                       @"#FFFFBE",
                       @"#F9F3DC",
                       @"#FAF1D0",
                       @"#FCEFC3",
                       @"#FFEFB1",
                       @"#FEE893",
                       @"#FFE784",
                       @"#FDDE65",
                       @"#FFC721",
                       @"#F3ECD1",
                       @"#F5EBC3",
                       @"#F5E9B6",
                       @"#F1E197",
                       @"#EDDA87",
                       @"#E8D579",
                       @"#DCC55B",
                       @"#BEA441",
                       @"#F1F3D9",
                       @"#E2EDB0",
                       @"#E2EBA5",
                       @"#E0E791",
                       @"#DDE485",
                       @"#DAE27B",
                       @"#CCD453",
                       @"#A9BC3A",
                       @"#E8EBCD",
                       @"#E2E9C1",
                       @"#DBE4B1",
                       @"#BECE86",
                       @"#ADC070",
                       @"#9EB150",
                       @"#90A94C",
                       @"#5F883A",
                       @"#E8EDD5",
                       @"#DFE9CC",
                       @"#D8E4BD",
                       @"#B9CE94",
                       @"#A9BF7E",
                       @"#99B069",
                       @"#8DA35A",
                       @"#638146",
                       @"#E1EDD0",
                       @"#DBE9B6",
                       @"#D0E5A5",
                       @"#C2DE92",
                       @"#B7D987",
                       @"#A5CD66",
                       @"#9DC861",
                       @"#72B24F",
                       @"#E5EDD6",
                       @"#DEEBCC",
                       @"#D6E7C1",
                       @"#C6DDAB",
                       @"#ADCA8B",
                       @"#9DBF79",
                       @"#8CB161",
                       @"#5B8B40",
                       @"#E4EEDC",
                       @"#DEEAD4",
                       @"#D2E2C7",
                       @"#C4D7B5",
                       @"#AEC597",
                       @"#9DB684",
                       @"#7E9761",
                       @"#5B784B",
                       @"#DDE8DC",
                       @"#C1D4C5",
                       @"#B0C6B6",
                       @"#A5BAA7",
                       @"#99AF99",
                       @"#7A937C",
                       @"#6E856D",
                       @"#526757",
                       @"#E5F2E1",
                       @"#DAF0D8",
                       @"#BCE6BB",
                       @"#9FD8A0",
                       @"#92D293",
                       @"#89CE8C",
                       @"#75C375",
                       @"#1F9752",
                       @"#E4EFE4",
                       @"#D0EADC",
                       @"#C1E4D1",
                       @"#A0D2B6",
                       @"#76B491",
                       @"#61A37B",
                       @"#55956B",
                       @"#356B4D",
                       @"#E5EFE6",
                       @"#CBE0D6",
                       @"#C4DDD1",
                       @"#B1D0C2",
                       @"#9CC0AD",
                       @"#8BB19E",
                       @"#628A73",
                       @"#435950",
                       @"#E5F3EA",
                       @"#C0EADC",
                       @"#ACE5D3",
                       @"#99DDC6",
                       @"#75CFB2",
                       @"#55C09E",
                       @"#30AF86",
                       @"#00815D",
                       @"#D9EFE3",
                       @"#ACE3D3",
                       @"#9EDECC",
                       @"#84D4BE",
                       @"#68C8B6",
                       @"#25AF97",
                       @"#00947D",
                       @"#285F52",
                       @"#E5EEE6",
                       @"#DBEBE3",
                       @"#BDDBD2",
                       @"#A0C8BE",
                       @"#88B5AA",
                       @"#699A8A",
                       @"#5A8879",
                       @"#365B55",
                       @"#E1EEE7",
                       @"#B7DDD3",
                       @"#ABD5CC",
                       @"#96C9BD",
                       @"#7EBBAE",
                       @"#6CAC9D",
                       @"#569A88",
                       @"#416459",
                       @"#D9EFE8",
                       @"#BEE5DD",
                       @"#ADDFD6",
                       @"#79C4B9",
                       @"#64B5A8",
                       @"#43A191",
                       @"#379483",
                       @"#1C6A5E",
                       @"#E5F0E5",
                       @"#D7F0E8",
                       @"#CBECE5",
                       @"#A0E0D8",
                       @"#85D7CD",
                       @"#49C0B1",
                       @"#0DB2A0",
                       @"#007E6C",
                       @"#E1EEE8",
                       @"#BEE1DD",
                       @"#AED7D4",
                       @"#94C7C4",
                       @"#7DB8B6",
                       @"#66A6A4",
                       @"#4C8F8B",
                       @"#395957",
                       @"#D2EBE3",
                       @"#C7E9DF",
                       @"#9CD7D2",
                       @"#80CBC7",
                       @"#66BCBB",
                       @"#38ABAA",
                       @"#009793",
                       @"#006C6E",
                       @"#E3F2EC",
                       @"#C7E8E6",
                       @"#A7DEE0",
                       @"#81CFD5",
                       @"#65C3CA",
                       @"#3EB1BA",
                       @"#00A2A9",
                       @"#00767D",
                       @"#DEEFEA",
                       @"#BDE7E5",
                       @"#A9DAD8",
                       @"#85C7C8",
                       @"#61AAAD",
                       @"#459493",
                       @"#378487",
                       @"#36555A",
                       @"#E5F1EB",
                       @"#CAE1DF",
                       @"#B3D2D1",
                       @"#98BFBF",
                       @"#86B2B2",
                       @"#6F9B9C",
                       @"#588584",
                       @"#405557",
                       @"#DCEAE7",
                       @"#BCD9DD",
                       @"#A8CDD6",
                       @"#8ABBC7",
                       @"#72AAB8",
                       @"#6099A7",
                       @"#447C89",
                       @"#325262",
                       @"#E6F0EC",
                       @"#C4E4E9",
                       @"#B0DCE6",
                       @"#7FC7DD",
                       @"#60B8D4",
                       @"#3FA8C7",
                       @"#0A97B7",
                       @"#005F7E",
                       @"#DEEFEF",
                       @"#AFD8E8",
                       @"#9CCFE7",
                       @"#7DC0E2",
                       @"#64B4DD",
                       @"#2995C8",
                       @"#0080B9",
                       @"#0D5A89",
                       @"#E1EAEC",
                       @"#C1D5E5",
                       @"#ACCBE0",
                       @"#97BED9",
                       @"#81AFCE",
                       @"#689EBE",
                       @"#4A86A8",
                       @"#2B5276",
                       @"#E4ECEA",
                       @"#CBE3EB",
                       @"#AFD6EA",
                       @"#9FCEEB",
                       @"#7EBCE5",
                       @"#63ADDE",
                       @"#1D8CCB",
                       @"#265896",
                       @"#E0EAEC",
                       @"#B4CFE3",
                       @"#A5C9E3",
                       @"#8FB8D9",
                       @"#78A8D1",
                       @"#6D9AC4",
                       @"#4476A8",
                       @"#30477A",
                       @"#E2E6E8",
                       @"#C1CCDA",
                       @"#B6C5D6",
                       @"#A5B7CF",
                       @"#90A5C5",
                       @"#788FB2",
                       @"#677DA0",
                       @"#354769",
                       @"#E4E3E6",
                       @"#C3C8D6",
                       @"#B7BBCD",
                       @"#A7ADC2",
                       @"#919BB3",
                       @"#868EA7",
                       @"#646C85",
                       @"#3E465E",
                       @"#E4E8ED",
                       @"#CCD6E8",
                       @"#B5C7E2",
                       @"#A6BADE",
                       @"#92A9D5",
                       @"#7892C6",
                       @"#556CA6",
                       @"#383F6C",
                       @"#E0DEE7",
                       @"#D2D3E4",
                       @"#C5C6E0",
                       @"#AEB3D7",
                       @"#9DA1CD",
                       @"#898FC2",
                       @"#727AB1",
                       @"#495186",
                       @"#DAD9E4",
                       @"#CDCCDC",
                       @"#C0BDD4",
                       @"#AEADCB",
                       @"#9898BB",
                       @"#8787AF",
                       @"#6B6B95",
                       @"#454666",
                       @"#E5DEE7",
                       @"#E0D7E6",
                       @"#D3C9E1",
                       @"#C2B8D7",
                       @"#B0A5CE",
                       @"#9E8FBF",
                       @"#7E6DA3",
                       @"#47416C",
                       @"#E7DEE7",
                       @"#E7D9E5",
                       @"#DDCDE2",
                       @"#D9C1DC",
                       @"#CEB4D5",
                       @"#B48FBD",
                       @"#8F6BA0",
                       @"#5F466C",
                       @"#EFE3E9",
                       @"#DFCCE2",
                       @"#D2BBD9",
                       @"#C5ABCD",
                       @"#BFA2CB",
                       @"#AF8EBD",
                       @"#8E6699",
                       @"#654977",
                       @"#F2E6E9",
                       @"#E4BCD3",
                       @"#D9AAC6",
                       @"#CD95B5",
                       @"#C083A6",
                       @"#B36F93",
                       @"#97577B",
                       @"#683E45",
                       @"#F3E4E2",
                       @"#DFBABB",
                       @"#D7B0B1",
                       @"#C99FA2",
                       @"#B98A8D",
                       @"#AA7A7E",
                       @"#8C5957",
                       @"#6C4B44",
                       @"#EBDEDA",
                       @"#D6C1BB",
                       @"#CFB8B3",
                       @"#C8ADA7",
                       @"#B89B94",
                       @"#A68780",
                       @"#88655C",
                       @"#664E48",
                       @"#F5E6DC",
                       @"#EED6CA",
                       @"#E5C6B9",
                       @"#DBB6A7",
                       @"#CA9A88",
                       @"#BB8976",
                       @"#AB745F",
                       @"#835347",
                       @"#EEE1D8",
                       @"#E7D1C9",
                       @"#DFC4BB",
                       @"#D0AFA4",
                       @"#AF887D",
                       @"#9F7466",
                       @"#926658",
                       @"#734F44",
                       @"#F5EAE3",
                       @"#E3C8BE",
                       @"#DABAAF",
                       @"#CEA89E",
                       @"#BD9589",
                       @"#AE8374",
                       @"#91675B",
                       @"#69493F",
                       @"#F2E5E0",
                       @"#E6C9C2",
                       @"#DCBAB2",
                       @"#C79A93",
                       @"#B2827A",
                       @"#9D6D66",
                       @"#8E5D52",
                       @"#714E45",
                       @"#ECDFDA",
                       @"#E3D3CD",
                       @"#D8C2BC",
                       @"#C8AEA8",
                       @"#B19089",
                       @"#9B7A75",
                       @"#8A665E",
                       @"#614B45",
                       @"#E9DBD4",
                       @"#E1D1CA",
                       @"#D6C4BC",
                       @"#CBB5AB",
                       @"#B3988E",
                       @"#A38377",
                       @"#92736A",
                       @"#6B534D",
                       @"#E1D6D0",
                       @"#D2C4BD",
                       @"#C5B4AD",
                       @"#BBA8A0",
                       @"#A6928A",
                       @"#98837B",
                       @"#775F55",
                       @"#594741",
                       @"#DAD8D4",
                       @"#CDC9C5",
                       @"#BCB6B2",
                       @"#B4AEAB",
                       @"#ACA6A4",
                       @"#9B9390",
                       @"#837974",
                       @"#59504E",
                       @"#DADAD8",
                       @"#C5C0BF",
                       @"#B4B0AF",
                       @"#A39D9D",
                       @"#98908F",
                       @"#867C79",
                       @"#7C736F",
                       @"#504B4D",
                       @"#F1EEE6",
                       @"#ECE8DF",
                       @"#DFD9D0",
                       @"#CBC3B8",
                       @"#B7AEA2",
                       @"#AAA195",
                       @"#9B8F80",
                       @"#61574F",
                       @"#E3DDD4",
                       @"#D6CABF",
                       @"#C6BAAE",
                       @"#BDB1A5",
                       @"#AE9F92",
                       @"#9E9082",
                       @"#8D7D6D",
                       @"#5C4E44",
                       @"#EFEAE2",
                       @"#E4DBD3",
                       @"#D6CCC2",
                       @"#CCC0B6",
                       @"#B5A69A",
                       @"#998678",
                       @"#887769",
                       @"#5B4E45",
                       @"#F2E7DD",
                       @"#E2CEBF",
                       @"#D8C3B2",
                       @"#CDB7A3",
                       @"#B59B8A",
                       @"#A68773",
                       @"#977863",
                       @"#71594D",
                       @"#F1EBE4",
                       @"#ECE4DA",
                       @"#D7C9BE",
                       @"#C9B9AE",
                       @"#BCAA9D",
                       @"#A79387",
                       @"#867062",
                       @"#635046",
                       @"#EFE7DF",
                       @"#E6DED6",
                       @"#DFD5CC",
                       @"#CABCB1",
                       @"#B8A89C",
                       @"#A8978B",
                       @"#867365",
                       @"#564841",
                       @"#E3DACF",
                       @"#DDD1C4",
                       @"#D3C2B1",
                       @"#C9BAA9",
                       @"#B8A692",
                       @"#AC9785",
                       @"#9A836E",
                       @"#715E51",
                       @"#ECE2D1",
                       @"#E5D8C5",
                       @"#DCCDB9",
                       @"#C6B096",
                       @"#B29A7F",
                       @"#A2886D",
                       @"#91795C",
                       @"#705C4B",
                       @"#E4D9C7",
                       @"#E1D4C0",
                       @"#D9CCB8",
                       @"#CCBEA7",
                       @"#BCAC92",
                       @"#AF9C81",
                       @"#998569",
                       @"#6F5D4B",
                       @"#E6DECD",
                       @"#DFD2BE",
                       @"#D9CAB2",
                       @"#D5C0A1",
                       @"#CAB18D",
                       @"#BDA27B",
                       @"#A0825A",
                       @"#836B4F",
                       @"#F3EDDB",
                       @"#F1E9D5",
                       @"#E9DCBD",
                       @"#E5D5AE",
                       @"#DECCA2",
                       @"#CFBB89",
                       @"#BDA46B",
                       @"#9D8047",
                       @"#F3ECDF",
                       @"#E5D7BD",
                       @"#DCCDB0",
                       @"#CDBB98",
                       @"#C4B08B",
                       @"#AF986E",
                       @"#A28960",
                       @"#806D4F",
                       @"#EEE7D8",
                       @"#E8DFD0",
                       @"#DED3BF",
                       @"#CEC2AA",
                       @"#B7AA8D",
                       @"#9F8E6F",
                       @"#8F8060",
                       @"#6B604B",
                       @"#ECE5D3",
                       @"#E5DDC7",
                       @"#D9D1B7",
                       @"#C6BB99",
                       @"#B8AA82",
                       @"#9E8E65",
                       @"#908159",
                       @"#837657",
                       @"#E9E7CD",
                       @"#E4E1C2",
                       @"#E1D8B2",
                       @"#D7CCA0",
                       @"#CCBF8B",
                       @"#C1B37E",
                       @"#A8995D",
                       @"#867F4E",
                       @"#F5F0DF",
                       @"#F2EDD6",
                       @"#EAE3C4",
                       @"#D3CA9A",
                       @"#C6BB84",
                       @"#BBAD71",
                       @"#AC9D5E",
                       @"#8A7D4D",
                       @"#F0ECD6",
                       @"#E2DDB8",
                       @"#D9D3A8",
                       @"#C9C28F",
                       @"#C1BA84",
                       @"#BAB279",
                       @"#A8A064",
                       @"#84804D",
                       @"#F3EED7",
                       @"#F3EDCE",
                       @"#E9E0AD",
                       @"#E0D398",
                       @"#D2C482",
                       @"#C3B467",
                       @"#B9A85A",
                       @"#9A894B",
                       @"#ECE7D4",
                       @"#E5E0CA",
                       @"#DED7B9",
                       @"#D0CAAA",
                       @"#BEB793",
                       @"#B4AC83",
                       @"#A3996C",
                       @"#726C4F",
                       @"#EFEBD5",
                       @"#DCD9B9",
                       @"#CECCA7",
                       @"#BDBA8F",
                       @"#A9A77A",
                       @"#999566",
                       @"#8E8A5C",
                       @"#6E6F50",
                       @"#E4E5D3",
                       @"#E0E0CA",
                       @"#D9D9BC",
                       @"#CCCCAC",
                       @"#B9B891",
                       @"#9E9E76",
                       @"#8C8D66",
                       @"#646B4C",
                       @"#E6E9DA",
                       @"#DFE4CF",
                       @"#DCDDC4",
                       @"#CBCDAB",
                       @"#A7AB85",
                       @"#9BA17A",
                       @"#868C64",
                       @"#61694B",
                       @"#E5E7D8",
                       @"#DADFD0",
                       @"#D0D7C5",
                       @"#C4CBB5",
                       @"#B3BCA3",
                       @"#9BA68A",
                       @"#848E6F",
                       @"#5C6B57",
                       @"#E5E8DA",
                       @"#DCE2D0",
                       @"#D3DAC8",
                       @"#C5CDBA",
                       @"#B8C1AD",
                       @"#9AA38D",
                       @"#81896F",
                       @"#596252",
                       @"#D6DCCF",
                       @"#CED2C4",
                       @"#C3C7B9",
                       @"#B2B9AC",
                       @"#9FA698",
                       @"#878D7D",
                       @"#798373",
                       @"#4D554E",
                       @"#DADFD7",
                       @"#C7CDC5",
                       @"#B7C0B7",
                       @"#B1BBB2",
                       @"#A2ADA4",
                       @"#8C968D",
                       @"#636B61",
                       @"#474B46",
                       @"#D4D5D1",
                       @"#C5C7C4",
                       @"#B8BCBB",
                       @"#ACB4B4",
                       @"#A1ABAE",
                       @"#929DA0",
                       @"#6E787C",
                       @"#3E4449",
                       @"#E0E5E3",
                       @"#C4CCCD",
                       @"#B0BBBE",
                       @"#9AA6AC",
                       @"#859198",
                       @"#7D8A90",
                       @"#616A70",
                       @"#3E3E3F",
                       @"#E3E9E6",
                       @"#DBE3E1",
                       @"#C4D3D5",
                       @"#A8BDC1",
                       @"#9CB2B5",
                       @"#859DA1",
                       @"#6D888A",
                       @"#3E4E54",
                       @"#E8ECE8",
                       @"#A6BAC7",
                       @"#93AABA",
                       @"#7D99AA",
                       @"#7C909E",
                       @"#627D8E",
                       @"#567080",
                       @"#384150",
                       @"#E5E9E8",
                       @"#C7CFD3",
                       @"#B2C0C9",
                       @"#A8BAC6",
                       @"#96AAB7",
                       @"#8397A4",
                       @"#63747F",
                       @"#39404A",
                       @"#EAE9E6",
                       @"#E2E3E0",
                       @"#D7DBDA",
                       @"#C7CBCD",
                       @"#A8ADB3",
                       @"#8E949B",
                       @"#676B71",
                       @"#403F40",
                       @"#DFDDD7",
                       @"#D1CFCA",
                       @"#BBBCB8",
                       @"#A8ABAA",
                       @"#9DA0A1",
                       @"#888B8E",
                       @"#6A6D6F",
                       @"#3F4346",
                       @"#E7E5DF",
                       @"#DCDCD7",
                       @"#CAC9C6",
                       @"#B9B8B3",
                       @"#AFADA8",
                       @"#918F8A",
                       @"#817E78",
                       @"#515251",
                       @"#E7E6E2",
                       @"#E1E0DD",
                       @"#CCCCCB",
                       @"#B4B2AF",
                       @"#A29F9D",
                       @"#8A8887",
                       @"#74716E",
                       @"#49494A",
                       @"#DED9D8",
                       @"#CECBCB",
                       @"#C3C2C1",
                       @"#B4B2B1",
                       @"#A19F9E",
                       @"#999696",
                       @"#807D7A",
                       @"#4D4A4C",
                       @"#E0DCDC",
                       @"#D2D0D4",
                       @"#BFBFC8",
                       @"#B0B2BF",
                       @"#A1A0B1",
                       @"#8D8C9D",
                       @"#676878",
                       @"#41404D",
                       @"#E4E1E5",
                       @"#C4BECB",
                       @"#B3ACBD",
                       @"#A09AAB",
                       @"#90879B",
                       @"#7F7587",
                       @"#716677",
                       @"#3C3940",
                       @"#E5DFE2",
                       @"#DED6DB",
                       @"#D3C8D4",
                       @"#C1B6C6",
                       @"#ACA1B6",
                       @"#968CA2",
                       @"#83778E",
                       @"#474259",
 nil];


@end
