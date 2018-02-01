//
//  DisplayViewController.m
//  EventVer2
//
//  Created by apple on 11/03/16.
//  Copyright © 2016 apple. All rights reserved.
//

#import "DisplayViewController.h"
#import "GalleryCollectionViewController.h"

@interface DisplayViewController ()

@end

@implementation DisplayViewController
@synthesize date1,event1,hall1,loc1,hallCost;
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@",date1);
     NSLog(@"%@",event1);
     NSLog(@"%@",hall1);
     NSLog(@"%@",loc1);
    self.datelbl.text=date1;
    self.eventlbl.text=event1;
    self.halllbl.text=hall1;
    self.loclbl.text=loc1;
    
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"ToThird"])
        {
          GalleryCollectionViewController *galleryController=(GalleryCollectionViewController *)segue.destinationViewController;
        galleryController.hallValue=self.hallCost;
        
           }
}


@end
