//
//  EventDoneViewController.m
//  EventVer2
//
//  Created by apple on 11/03/16.
//  Copyright © 2016 apple. All rights reserved.
//

#import "EventDoneViewController.h"

@interface EventDoneViewController ()

@end

@implementation EventDoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)FinishButton:(id)sender {
    [self performSegueWithIdentifier:@"finish" sender:nil];
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
