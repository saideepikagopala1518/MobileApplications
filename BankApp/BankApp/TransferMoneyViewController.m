//
//  TransferMoneyViewController.m
//  BankApp
//
//  Created by Apple on 08/03/16.
//  Copyright © 2016 cts. All rights reserved.
//

#import "TransferMoneyViewController.h"
#import "SWRevealViewController.h"
#import "FundTransferService.h"


@interface TransferMoneyViewController ()
{
    NSInteger flag;
    NSString *MyString;
}
@end

@implementation TransferMoneyViewController
@synthesize submitButton,webService,payeeAccounts,myPickerView;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    flag=0;
    webService = [[WebService alloc]init];
    NSDate *now=[NSDate date];
    NSDateFormatter *DateFormatter=[[NSDateFormatter alloc] init];
    [DateFormatter setDateFormat:@"yyyy-MM-dd"];
    MyString=[DateFormatter stringFromDate:now];
    
    self.dateField.text=MyString;

    [webService setWebDelegate:self];
        SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sideButton setTarget: self.revealViewController];
        [self.sideButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
          [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ShowMsg:) name:@"msg" object:nil];
    }
    NSDictionary *banacc=@{@"account_number":@"112233445566"};
    [webService callWebServiceURL:@"http://10.251.163.5:8088/MFRPServices/bank_get_other_accounts"  withPayLoad: banacc withType:@"getOtherAccounts"];
    myPickerView = [[UIPickerView alloc]init];
    [myPickerView setDataSource:self];
    [myPickerView setDelegate:self];
    // myPickerview.delegate = self;
    // myPickerview.dataSource = self;
    [self.benAccount setInputView:myPickerView];
    
}
-(IBAction)submitButtonPressed:(id)sender

{
    if([self.accNumber.text isEqualToString:@""] || [self.benAccount.text isEqualToString:@""])
    {
        UIAlertController *uiAlertCtrl = [UIAlertController alertControllerWithTitle:@"Alert!" message:@"Account Number / Beneficiary Account Number cannot be empty " preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
        
        [uiAlertCtrl addAction:okAction];
        
        [self presentViewController:uiAlertCtrl animated:YES completion:nil];
    }
      else if([self.amount.text isEqualToString:@""])
    {
        UIAlertController *uiAlertCtrl = [UIAlertController alertControllerWithTitle:@"Alert!" message:@"Amount cannot be empty" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
        
        [uiAlertCtrl addAction:okAction];
        
        [self presentViewController:uiAlertCtrl animated:YES completion:nil];

    }
      else if([self.transPassword.text isEqualToString:@""])
      {
          UIAlertController *uiAlertCtrl = [UIAlertController alertControllerWithTitle:@"Alert!" message:@"Password cannot be empty" preferredStyle:UIAlertControllerStyleAlert];
          
          UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
          
          [uiAlertCtrl addAction:okAction];
          
          [self presentViewController:uiAlertCtrl animated:YES completion:nil];
      }
      else{
          if([self.accNumber.text isEqualToString:@"112233445566"])
          {
    FundTransferService *MyCall=[[FundTransferService alloc] init];
    [MyCall AccountNumber:self.accNumber.text Beneficiary:self.benAccount.text Password:self.transPassword.text Amount:self.amount.text Date:self.dateField.text];
          }
          else
          {
              UIAlertController *uiAlertCtrl = [UIAlertController alertControllerWithTitle:@"Alert!" message:@"Enter Valid Account Number" preferredStyle:UIAlertControllerStyleAlert];
              
              UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
              
              [uiAlertCtrl addAction:okAction];
              
              [self presentViewController:uiAlertCtrl animated:YES completion:nil];
          }
}
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [[self view]endEditing:YES];
    
}
-(void)getResponseFromWeb:(NSDictionary *)result by:(NSString *)type{
    
    NSLog(@"%@",result);
    
    if([type isEqualToString:@"getOtherAccounts"])
    {
        NSLog(@"%@",result);
        
        payeeAccounts=[result objectForKey:@"Payee_Accounts"];
        NSLog(@"%@",payeeAccounts);
        NSLog(@"%@",[result objectForKey:@"Payee_Accounts"]);
        NSLog(@"pppp");
    }else{
        //Login Failed
        UIAlertController *uiAlertCtrl = [UIAlertController alertControllerWithTitle:@"Alert!" message:@"No Benificiary accounts" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
        
        [uiAlertCtrl addAction:okAction];
        
        [self presentViewController:uiAlertCtrl animated:YES completion:nil];
        
    }
    
}

/*-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    NSLog(@"jkhagsldkgaksf");
    if(textField.tag==1)
    {
        
        
        NSString *RegEx = @"([0-9]{12})";
        NSPredicate *Test = [NSPredicate predicateWithFormat:@"Self matches %@", RegEx];
        
        if([Test evaluateWithObject:textField.text]==NO)
        {
            
            UIAlertController *uiAlertCtrl = [UIAlertController alertControllerWithTitle:@"Alert" message:@"Invalid Account Number" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Return" style:UIAlertActionStyleCancel handler:nil];
            
            [uiAlertCtrl addAction:okAction];
            
            [self presentViewController:uiAlertCtrl animated:YES completion:nil];
            return NO;
        }
        flag++;
        return YES;
    }
    
    else if(textField.tag==2)
    {
        NSString *RegEx = @"([0-9]{12})";
        NSPredicate *Test = [NSPredicate predicateWithFormat:@"Self matches %@", RegEx];
        
        if([Test evaluateWithObject:textField.text]==NO)
        {
            /*UIAlertView *MyV=[[UIAlertView alloc] initWithTitle:@"Invalid Account Number !!" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
             [MyV show];
             */
        /*    UIAlertController *uiAlertCtrl = [UIAlertController alertControllerWithTitle:@"Alert!" message:@"Invalid Account Number" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Return" style:UIAlertActionStyleCancel handler:nil];
            
            [uiAlertCtrl addAction:okAction];
            
            [self presentViewController:uiAlertCtrl animated:YES completion:nil];
            return NO;
            
        }
        flag++;
        return YES;
    }
    
    else if(textField.tag==3)
    {
        
        NSString *RegEx = @"([0-9]{1,10})";
        NSPredicate *Test = [NSPredicate predicateWithFormat:@"Self matches %@", RegEx];
        
        if([Test evaluateWithObject:textField.text]==NO)
        {
            /* UIAlertView *MyV=[[UIAlertView alloc] initWithTitle:@"Incorrect Ammount !!" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
             [MyV show];
             */
   /*         UIAlertController *uiAlertCtrl = [UIAlertController alertControllerWithTitle:@"Invalid Amount" message:@"Enter Appropriate Amount" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Return" style:UIAlertActionStyleCancel handler:nil];
            
            [uiAlertCtrl addAction:okAction];
            
            [self presentViewController:uiAlertCtrl animated:YES completion:nil];
            return NO;
        }
        flag++;
        return YES;
        
        
        
    }
    
    else if(textField.tag==4)
    {
        
        if(self.transPassword.text.length==0)
        {
            
            /*  UIAlertView *MyV=[[UIAlertView alloc] initWithTitle:@"Password Cannot Be Empty !!" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
             
             [MyV show];*/
   /*         UIAlertController *uiAlertCtrl = [UIAlertController alertControllerWithTitle:@"Password Alert" message:@"Password cannot be empty..!!!" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Return" style:UIAlertActionStyleCancel handler:nil];
            
            [uiAlertCtrl addAction:okAction];
            
            [self presentViewController:uiAlertCtrl animated:YES completion:nil];
            return NO;
            
        }
        flag++;
        if (flag==4)
        {
            self.submitButton.enabled=YES;
        }
        
        
        return YES;
        
        
    }
    
    
    return YES;
}
*/

#pragma mark - UIPickerDataSource Functions
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return  [payeeAccounts count];
}
#pragma mark - UIPickerDelegate Functions
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [payeeAccounts objectAtIndex:row];
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    // when PickerView Items is selected
    [self.benAccount setText:[payeeAccounts objectAtIndex:row]];
    [[self view]endEditing:YES];
}
-(void)ShowMsg:(NSNotification *)TheNotification
{
    
   /* UIAlertView *MyMsg=[[UIAlertView alloc] initWithTitle:@"Amount Transfered !" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [MyMsg show];*/
    UIAlertController *uiAlertCtrl = [UIAlertController alertControllerWithTitle:@"Congratulations!" message:@"Amount Transferred Successfully" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Return" style:UIAlertActionStyleCancel handler:nil];
    
    [uiAlertCtrl addAction:okAction];
    
    [self presentViewController:uiAlertCtrl animated:YES completion:nil];
 //   MainViewController *mv=[[MainViewController alloc]init];
 //   int value = [mv.balance.text intValue];
   // int tamt=[self.amount.text intValue];
   // int bal=value-tamt;
  //  NSString *acbal = [@(bal) stringValue];
   // [mv.balance setText:acbal];
    
}



    
    

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





@end
