//
//  MainViewController.m
// JobApplicationForm
//
//  Created by Apple on 08/03/16.
//  Copyright © 2016 cts. All rights reserved.
//

#import "MainViewController.h"


@interface MainViewController ()<UITextFieldDelegate>{

CGSize pageSize;
   
    
}
@end

@implementation MainViewController
@synthesize firstName,lastName,dateOfBirth,city,address,state,zipCode,telephoneNumber,jobApplyingFor,totalExperience,whatWillYouDoIfHired,textFieldArray,generatePDFButton;

- (void)viewDidLoad {
    [super viewDidLoad];
    //intialize the text field array which is used for validations
    self.textFieldArray=[[NSMutableArray alloc]init];
    [self.textFieldArray addObject:self.firstName];
    self.firstName.delegate=self;
    [self.textFieldArray addObject:self.lastName];
    self.lastName.delegate=self;
    [self.textFieldArray addObject:self.address];
    self.address.delegate=self;
    [self.textFieldArray addObject:self.city];
    self.city.delegate=self;
    [self.textFieldArray addObject:self.state];
    self.state.delegate=self;
    [self.textFieldArray addObject:self.zipCode];
    self.zipCode.delegate=self;
    [self.textFieldArray addObject:self.telephoneNumber];
    self.telephoneNumber.delegate=self;
    [self.textFieldArray addObject:self.jobApplyingFor];
    self.jobApplyingFor.delegate=self;
    [self.textFieldArray addObject:self.totalExperience];
    self.totalExperience.delegate=self;
    [self.textFieldArray addObject:self.whatWillYouDoIfHired];
    self.whatWillYouDoIfHired.delegate=self;
    
    
    [[self.textFieldArray objectAtIndex:0] becomeFirstResponder];

    // Do any additional setup after loading the view.
    //intially make the signature view hidden
    
    self.signatureView.hidden=YES;
    drawImage.hidden=YES;
   
    
    //initialize the drawImage object with an empty image
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    drawImage.image=[defaults objectForKey:@"drawImageKey"];
    drawImage=[[UIImageView alloc] initWithImage:nil];
    drawImage.frame=self.view.frame;
    [self.view addSubview:drawImage];
   
}

#pragma mark - SignatureDrawingMethods

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
    UITouch *touch=[[event allTouches]anyObject];
    if([touch tapCount]==2){
        //double tap to clear the screen
        drawImage.image=nil;
    }
    //get the location where the user click/touch
    location=[touch locationInView:touch.view];
    lastClick=[NSDate date];
    //get the last touched point of the signature view
    lastPoint = [touch locationInView:self.signatureView];
    [super touchesBegan:touches withEvent:event];
    
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    mouseSwiped=YES;
    UITouch *touch=[touches anyObject];
    //get the location to which the user moves( G->sai)
    currentPoint=[touch locationInView:self.signatureView];
    //get the current context and add image to it
    UIGraphicsBeginImageContext(CGSizeMake(self.signatureView.frame.size.width,self.signatureView.frame.size.height));
    [drawImage.image drawInRect:CGRectMake(0,0, self.signatureView.frame.size.width,self.signatureView.frame.size.height)];
    //set line cap
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), 3.0);
    //set color
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 0, 0, 0, 1);
    //get the touched point
    CGContextBeginPath(UIGraphicsGetCurrentContext());
    //last point
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
    //add line from current to last point
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y);
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    //add the line/curve obtained to drawImage
    [drawImage setFrame:CGRectMake(self.signatureView.frame.origin.x,self.signatureView.frame.origin.y, self.signatureView.frame.size.width,self.signatureView.frame.size.height)];
    drawImage.image=UIGraphicsGetImageFromCurrentImageContext();
    //make the end point as the current point
    UIGraphicsEndImageContext();
    lastPoint=currentPoint;
    [self.view addSubview:drawImage];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - PDFGenerationMethods

- (IBAction)pdfButtonPressed:(UIButton *)sender {
    pageSize=CGSizeMake(850,1100);
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)firstObject];
    NSString *filePath = [docPath stringByAppendingPathComponent:@"JobAppForm.pdf"];
    
    NSLog(@"%@",filePath);
    [self generatePDF:filePath];
}

-(void)generatePDF:(NSString *)filePath{
    if ([firstName.text isEqualToString:@""]||[lastName.text isEqualToString:@""]||[city.text isEqualToString:@""]||[address.text isEqualToString:@""]||[state.text isEqualToString:@""]||[zipCode.text isEqualToString:@""]||[telephoneNumber.text isEqualToString:@""]||[jobApplyingFor.text isEqualToString:@""]||[totalExperience.text isEqualToString:@""]||[whatWillYouDoIfHired.text isEqualToString:@""]) {
        
        UIAlertController *controller=[UIAlertController alertControllerWithTitle:@"Failure" message:@"Enter all the fields" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [controller addAction:okAction];
        [self presentViewController:controller animated:YES completion:nil];
    }
      else{

    
    if (!drawImage.image) {
        UIAlertView *warningAlert=[[UIAlertView alloc]initWithTitle:@"Warning" message:@"can not keep signature empty" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [warningAlert show];
    }
    else{
        //create context by specifying destination path,bounds,add info
        UIGraphicsBeginPDFContextToFile(filePath, CGRectZero, nil);
        

        //open the file and set to customized size
        UIGraphicsBeginPDFPageWithInfo(CGRectMake(0, 0, 850, 1100), nil);
        [self drawBackground];
        [self drawImage];
        [self drawText];
        //closes the pdf context
        UIGraphicsEndPDFContext();
        //creating an actionsheet with preview and email opt
        UIActionSheet* actionSheet = [[UIActionSheet alloc] initWithTitle:@"Would you like to preview or email this PDF?"                                                               delegate:self                                                        cancelButtonTitle:@"Cancel"                                                   destructiveButtonTitle:nil                                                        otherButtonTitles:@"Preview", @"Email", nil] ;
        [actionSheet showInView:self.view];
    }
}
}
-(void)drawBackground{
    //for setting background of the page
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGRect textRect=CGRectMake(0, 0, pageSize.width, pageSize.height);
    CGContextSetFillColorWithColor(context, [[UIColor whiteColor]CGColor]);
    CGContextFillRect(context, textRect);
    
}
-(void)drawImage{
    //for getting the signature from signature view
    CGRect imageRect=CGRectMake(40, 775, 250, 200);
    [drawImage.image drawInRect:imageRect];
   
    
}
-(void)drawText{
    //for displaying info of all text fields
    UIFont *font=[UIFont fontWithName:@"Helvetica" size:25];
    CGRect textRect=CGRectMake(300,10, 300, 100);
    NSString *myString=@"JOB APPLICATION FORM";
    [myString drawInRect:textRect withAttributes:@{NSFontAttributeName:font,NSForegroundColorAttributeName:[UIColor blackColor]}];
    
    font=[UIFont fontWithName:@"Helvetica" size:20];
    textRect=CGRectMake(50, 120, 350, 50);
    myString=[NSString stringWithFormat:@"First Name: %@",self.firstName.text];
    [myString drawInRect:textRect withAttributes:@{NSFontAttributeName:font,NSForegroundColorAttributeName:[UIColor blackColor]}];
    
   textRect=CGRectMake(50, 170, 350,50);
    myString=[NSString stringWithFormat:@"Last Name: %@",self.lastName.text];
    [myString drawInRect:textRect withAttributes:@{NSFontAttributeName:font,NSForegroundColorAttributeName:[UIColor blackColor]}];
    textRect=CGRectMake(50, 220, 350,50);
    NSDate *date=[self.dateOfBirth date];
    NSDateFormatter *format=[[NSDateFormatter alloc]init];
    [format setDateFormat:@"dd-MMMM-yyyy"];
    myString=[NSString stringWithFormat:@"Date of Birth: %@",[format stringFromDate:date]];
    [myString drawInRect:textRect withAttributes:@{NSFontAttributeName:font,NSForegroundColorAttributeName:[UIColor blackColor]}];
    
textRect=CGRectMake(50, 270, 350, 50);
      myString=[NSString stringWithFormat:@"Address: %@",self.address.text];
    [myString drawInRect:textRect withAttributes:@{NSFontAttributeName:font,NSForegroundColorAttributeName:[UIColor blackColor]}];
    
    textRect=CGRectMake(50, 320, 350, 50);
       myString=[NSString stringWithFormat:@"City: %@",self.city.text];
    [myString drawInRect:textRect withAttributes:@{NSFontAttributeName:font,NSForegroundColorAttributeName:[UIColor blackColor]}];
    
    textRect=CGRectMake(50, 370, 350, 50);
    
    myString=[NSString stringWithFormat:@"State: %@",self.state.text];
    [myString drawInRect:textRect withAttributes:@{NSFontAttributeName:font,NSForegroundColorAttributeName:[UIColor blackColor]}];
    
    textRect=CGRectMake(50, 420, 350, 50);
    
    myString=[NSString stringWithFormat:@"Zip Code: %@",self.zipCode.text];
    [myString drawInRect:textRect withAttributes:@{NSFontAttributeName:font,NSForegroundColorAttributeName:[UIColor blackColor]}];
    
    textRect=CGRectMake(50, 470, 350, 50);
    
    myString=[NSString stringWithFormat:@"Mobile Number: %@",self.telephoneNumber.text];
    [myString drawInRect:textRect withAttributes:@{NSFontAttributeName:font,NSForegroundColorAttributeName:[UIColor blackColor]}];
    
    textRect=CGRectMake(50, 520, 350, 50);
   
    myString=[NSString stringWithFormat:@"Job Applying For: %@",self.jobApplyingFor.text];
    [myString drawInRect:textRect withAttributes:@{NSFontAttributeName:font,NSForegroundColorAttributeName:[UIColor blackColor]}];
    
    textRect=CGRectMake(50, 570, 350, 50);
    
    myString=[NSString stringWithFormat:@"Total Experience In Years: %@",self.totalExperience.text];
    [myString drawInRect:textRect withAttributes:@{NSFontAttributeName:font,NSForegroundColorAttributeName:[UIColor blackColor]}];
    
    textRect=CGRectMake(50, 620, 350, 50);
    
    myString=[NSString stringWithFormat:@"What next if hired? %@",self.whatWillYouDoIfHired.text];
    [myString drawInRect:textRect withAttributes:@{NSFontAttributeName:font,NSForegroundColorAttributeName:[UIColor blackColor]}];
    
    textRect=CGRectMake(50, 700, 770, 50);
   
    myString=@"I hereby declare that the details I have shared are true to the best of my knowledge and belief.";
    [myString drawInRect:textRect withAttributes:@{NSFontAttributeName:font,NSForegroundColorAttributeName:[UIColor blackColor]}];
    
    
    font=[UIFont fontWithName:@"Helvetica" size:17];
    
    textRect=CGRectMake(50, 780, 100, 20);
    myString=@"Signature";
    [myString drawInRect:textRect withAttributes:@{NSFontAttributeName:font,NSForegroundColorAttributeName:[UIColor blackColor]}];
    
    textRect=CGRectMake(580, 780, 250, 50);
    
    format=[[NSDateFormatter alloc]init];
    [format setDateFormat:@"dd-MMMM-yyyy"];
    myString=[NSString stringWithFormat:@"Date: %@",[format stringFromDate:[NSDate date]]];
    [myString drawInRect:textRect withAttributes:@{NSFontAttributeName:font,NSForegroundColorAttributeName:[UIColor blackColor]}];
    
    
    
}


#pragma mark -listener methods implementation
- (IBAction)signatureButtonPressed:(UIButton *)sender {
    self.signatureView.hidden=NO;
    drawImage.hidden=NO;
    drawImage.image=nil;
}

- (IBAction)doneButtonPressed:(UIButton *)sender {
    self.signatureView.hidden=YES;
    drawImage.hidden=YES;
}

- (IBAction)declarationButtonPressed:(UIButton *)sender {
    //enable & disable of generate pdf button based on check mark
    if((!self.declarationButtonOutlet.titleLabel.text)||([self.declarationButtonOutlet.titleLabel.text isEqualToString:@" "])){
        [self.declarationButtonOutlet setTitle:@"√" forState:UIControlStateNormal];
        self.generatePdfOutlet.enabled=YES;
    }
    else{
        [self.declarationButtonOutlet setTitle:@" " forState:UIControlStateNormal];
        self.generatePdfOutlet.enabled=NO;
    }}


- (IBAction)resetButtonPressed:(UIButton *)sender {
    self.firstName.text=@"";
    self.lastName.text=@"";
    self.address.text=@"";
    self.city.text=@"";
    self.telephoneNumber.text=@"";
    self.zipCode.text=@"";
    self.whatWillYouDoIfHired.text=@"";
    self.jobApplyingFor.text=@"";
    self.totalExperience.text=@"";
    self.state.text=@"";
    [self.declarationButtonOutlet setTitle:@" " forState:UIControlStateNormal];
}
#pragma mark - UITextFieldDelegate
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    return YES;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
   
    if (range.length==0) {
        char character=[string characterAtIndex:0];
        if((textField.tag==777)||(textField.tag==666)||(textField.tag==999)){
        //char character=[string characterAtIndex:0];
        if((range.location==0)&&(!((character>='a' && character<='z')||(character>='A' && character<='Z')||(character>='0'&&character<='9')))){
            return NO;
        }
        }else {
            
            if((range.location==0)&&(!((character>='a' && character<='z')||(character>='A' && character<='Z')))){
                return NO;
            }
        }
    
        //first name,last name,city,job applying for
        if(((textField.tag==111)||(textField.tag==222)||(textField.tag==444)||(textField.tag==888))&&(range.location>0)&&(!((character>='a' && character<='z')||(character>='A' && character<='Z'))))
        {
            return NO;
        }
        //phone number, zipcode, experience
        if((textField.tag==777)&&(([textField.text length]>9)||(!((character>='0' && character<='9')))))
        {
            return NO;
        }
        
        if((textField.tag==666)&&(([textField.text length]>5)||(!((character>='0' && character<='9')))))
        {
            return NO;
        }
        if((textField.tag==999)&&(!((character>='0'&&character<='9'))||([textField.text length]>1)))
        {
            return NO;
        }
        //state
        
        if((textField.tag==555)&&(range.location>0)&&(!((character>='a' && character<='z')||(character>='A' && character<='Z'))))        {
            return NO;
        }
        //address, what will you do
        
        if(((textField.tag==1111)||(textField.tag==333))&&(range.location>0)&&(!((character>='a' && character<='z')||(character>='A' && character<='Z')||(character>='0'&&character<='9')||(character=='-')||(character==',')||(character==' ')||(character=='.')||(character=='/')))){
            return NO;
        }
        return YES;
    }
    return YES;
    
    
}
#pragma mark - MFMailComposerDelegate
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        // present a preview of this PDF File.
        QLPreviewController* preview = [[QLPreviewController alloc] init];
        preview.dataSource = self;
        [self presentViewController:preview animated:YES completion:nil];
        
    }
    else if(buttonIndex == 1)
    {
        // email the PDF File.
        MFMailComposeViewController* mailComposer = [[MFMailComposeViewController alloc] init];
        mailComposer.mailComposeDelegate = self;
        [mailComposer setSubject:@"Test mail"];
        [mailComposer setMessageBody:@"Testing message for the test mail" isHTML:NO];
        //specify the path
        NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)firstObject];
        NSString *filePath = [docPath stringByAppendingPathComponent:@"JobAppForm.pdf"];
        //specify the attachment file and type
        [mailComposer addAttachmentData:[NSData dataWithContentsOfFile:filePath]
                               mimeType:@"application/pdf" fileName:@"JobAppForm.pdf"];
        [self presentViewController:mailComposer animated:YES completion:nil];
    }
}

#pragma mark - QLPreviewControllerDataSource
- (NSInteger) numberOfPreviewItemsInPreviewController: (QLPreviewController *) controller
{
    return 1;
}

- (id <QLPreviewItem>)previewController:(QLPreviewController *)controller previewItemAtIndex:(NSInteger)index
//returns the obj to be previewed as nSURL obj
{
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)firstObject];
    NSString *filePath = [docPath stringByAppendingPathComponent:@"JobAppForm.pdf"];
    NSLog(@"filePath is %@",filePath);
    return [NSURL fileURLWithPath:filePath];
}

@end
