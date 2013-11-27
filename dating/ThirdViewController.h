//
//  ThirdViewController.h
//  tattoo+
//
//  Created by Amit Barman on 2/4/12.
//  Copyright (c) 2012 Apollo Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MFMailComposeViewController.h>
#import <MessageUI/MFMessageComposeViewController.h>
#import <MessageUI/MessageUI.h>

@interface ThirdViewController : UIViewController <UIWebViewDelegate,UIActionSheetDelegate,MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate>
{
    IBOutlet UILabel *foodDesc,*foodTitle,*pageNumber;  
    IBOutlet UITextField *food;
    IBOutlet UIActivityIndicatorView *activityIndicator;
    IBOutlet UILabel *label2,*lbllink,*lblInfo;
    IBOutlet UIStepper *next1;
    IBOutlet UIWebView *wWw;
}
- (IBAction)loadFood;
- (IBAction)search;
- (IBAction)help;
- (IBAction)changePage;
- (IBAction)copyFood;
- (IBAction)saveImage;
- (IBAction)saveImage1;
- (IBAction)smsLoad;
- (IBAction)dismissKeyboard: (id)sender;
- (IBAction)mailLoad;
- (IBAction)share;
- (IBAction)clear;
@property (nonatomic, retain) UIWebView *wWw;
@end
