//
//  ThirdViewController.m
//  art+
//
//  Created by Amit Barman on 2/4/12.
//  Copyright (c) 2012 Apollo Software. All rights reserved.
//

#import "ThirdViewController.h"

@implementation ThirdViewController
@synthesize wWw;

int pageNo;

NSString *str;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Search Art", @"Search Art");
        self.tabBarItem.image = [UIImage imageNamed:@"second"];
    }
    return self;
}

- (IBAction)changePage
{ 
    
    pageNo = next1.value;
    
    NSString *tit = [NSString stringWithFormat:@"Search Results for %@",[food text]];
    [foodTitle setText:tit];
    
    NSString *outputText = [[NSString alloc] initWithFormat:@"Page %d",pageNo];
    pageNumber.text = outputText;
    
    label2.text = @"loading art...";
    activityIndicator.hidden = 0;label2.hidden=0;
    [activityIndicator startAnimating];
    [self performSelector:@selector(searchTats) withObject:nil afterDelay:0.01]; 
}

+(BOOL) isIPad {
    BOOL isIPad=NO;
    NSString* model = [UIDevice currentDevice].model;
    if ([model rangeOfString:@"iPad"].location != NSNotFound) {
        return YES;
    }
    return isIPad;
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
    //message.hidden = NO;
    switch (result)
    {
        case MessageComposeResultCancelled:
            //        message.text = @"Result: canceled";
            NSLog(@"Result: canceled");
            break;
        case MessageComposeResultSent:
            //      message.text = @"Result: sent";
            NSLog(@"Result: sent");
            break;
        case MessageComposeResultFailed:
            //    message.text = @"Result: failed";
            NSLog(@"Result: failed");
            break;
        default:
            //  message.text = @"Result: not sent";
            NSLog(@"Result: not sent");
            break;
    }
    
    [self dismissModalViewControllerAnimated:YES];
    
}
- (IBAction) smsLoad
{
    label2.text = @"loading SMS...";
    activityIndicator.hidden = 0;label2.hidden=0;
    [activityIndicator startAnimating];
    [self performSelector:@selector(sms) withObject:nil afterDelay:0.01];

}

- (IBAction)loadFood
{
    label2.text = @"loading art...";
    activityIndicator.hidden = 0;label2.hidden=0;
    [activityIndicator startAnimating];
    [self performSelector:@selector(loadFood1) withObject:nil afterDelay:0.01];
}
- (IBAction)copyFood
{
    NSString *outputText = [[NSString alloc] initWithFormat:@"%@ - URL:%@",foodTitle.text,lbllink.text];
    
    UIPasteboard *appPasteBoard = [UIPasteboard generalPasteboard];
    appPasteBoard.persistent = YES;
    [appPasteBoard setString:outputText];
    
    UIAlertView *fullAlert = [[UIAlertView alloc] initWithTitle:@"art+ art info" message:@"art info link copied to clipboard" delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil];
    
    [fullAlert show];
}

- (IBAction) mailLoad
{
    label2.text = @"loading e-mail...";
    activityIndicator.hidden = 0;label2.hidden=0;
    [activityIndicator startAnimating];
    [self performSelector:@selector(mail) withObject:nil afterDelay:0.01];
    
}
- (IBAction) saveImage1
{
    label2.text = @"saving art...";
    activityIndicator.hidden = 0;label2.hidden=0;
    [activityIndicator startAnimating];
    [self performSelector:@selector(saveTat) withObject:nil afterDelay:0.01];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    activityIndicator.hidden = 1;label2.hidden=1;
}

- (void) saveTat
{
    if([lbllink.text hasSuffix:@".jpg"])
    {
        NSLog(@"Downloading...");
        @try
        {
            
            NSLog(@"Downloading...");
            // Get an image from the URL below
            NSString *msgText = [[NSString alloc] initWithFormat:@"%@",lbllink.text];
            
            UIImage *image = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:msgText]]];
            
            NSLog(@"%f,%f",image.size.width,image.size.height);
            
            NSLog(@"saving jpeg");
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
            
            NSLog(@"saving image done");
            
            [image release];
            
            UIAlertView *fullAlert = [[UIAlertView alloc] initWithTitle:@"art+ Save Image" message:@"Image has been saved to Camera Roll" delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil];
            
            [fullAlert show];
        }
        @catch (NSException *e) {
            UIAlertView *fullAlert = [[UIAlertView alloc] initWithTitle:@"art+ Error" message:@"Image can't be saved!" delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil];
            
            [fullAlert show];
        }
        
    }
    else
    {
        UIAlertView *fullAlert = [[UIAlertView alloc] initWithTitle:@"art+ Error" message:@"Image can't be saved!" delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil];
        
        [fullAlert show]; 
    }
    
        activityIndicator.hidden = 1;label2.hidden=1;

}
- (IBAction) saveImage
{
    NSLog(@"Downloading...");
    @try
    {

        NSLog(@"Downloading...");
        // Get an image from the URL below
       
             NSString *msgText = [[NSString alloc] initWithFormat:@"%@",lbllink.text];
        
        UIImage *image = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:msgText]]];
        
        NSLog(@"%f,%f",image.size.width,image.size.height);
           NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSPicturesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        
        NSLog(@"%@",docDir);
        
        NSLog(@"saving jpeg");
        NSString *jpegFilePath = [NSString stringWithFormat:@"%@/test.jpeg",docDir];
        NSData *data2 = [NSData dataWithData:UIImageJPEGRepresentation(image, 1.0f)];//1.0f = 100% quality
        [data2 writeToFile:jpegFilePath atomically:YES];
        
        NSLog(@"saving image done");
        
        [image release];
        
            UIAlertView *fullAlert = [[UIAlertView alloc] initWithTitle:@"art+ Save Image" message:@"Image has been saved to Camera Roll" delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil];
            
            [fullAlert show];
    }
    @catch (NSException *e) {
        UIAlertView *fullAlert = [[UIAlertView alloc] initWithTitle:@"art+ Error" message:@"Image can't be saved!" delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil];
        
        [fullAlert show];
    }

}

- (void) mail
{
    NSString *urlpath = [[NSString alloc] initWithFormat:@"%@", [lbllink text]];
    int numLtrs = [urlpath length];
    
    
    
    if (numLtrs > 1)
    {    
        NSString *urlpath = [[NSString alloc] initWithFormat:@"%@", [foodDesc text]];
        NSString *urlString = [NSString stringWithFormat:urlpath];
        NSURL *url = [NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        NSMutableURLRequest* request = [[[NSMutableURLRequest alloc] initWithURL:url] autorelease];
        [request setValue:@"Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:2.0.1) Gecko/20100101 Firefox/4.0.1" forHTTPHeaderField:@"User-Agent"];
        
        MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
        picker.mailComposeDelegate = self; 
        
        NSString *subText = [[NSString alloc] initWithFormat:@"art+ %@",foodTitle.text];
        NSString *msgText = [[NSString alloc] initWithFormat:@"<br>%@",foodDesc.text];
        
        [picker setSubject:subText];
        [picker setMessageBody:msgText isHTML:YES];
        picker.navigationBar.barStyle = UIBarStyleDefault; 
        [self presentModalViewController:picker animated:YES];
    }
    else
    {
        UIAlertView *fullAlert = [[UIAlertView alloc] initWithTitle:@"art+ art info" message:@"art info not available" delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil];
        
        [fullAlert show];
        
    }
    
    
    activityIndicator.hidden = 1;label2.hidden=1;
    
    
}

- (void) sms
{
    
    NSString *urlpath = [[NSString alloc] initWithFormat:@"%@", [lbllink text]];
    int numLtrs = [urlpath length];
    
    if (numLtrs > 1)
    {  
        @try
        {
            NSString *outputText = [[NSString alloc] initWithFormat:@"URL: %@ - %@ ",lbllink.text,foodTitle.text];
            
            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"sms:11111"]]){
                //do stuff for sms
                MFMessageComposeViewController *picker = [[MFMessageComposeViewController alloc] init];
                picker.messageComposeDelegate = self;
                
                //picker.recipients = [NSArray arrayWithObject:@"123456789"];   // your recipient number or self for testing
                picker.body = outputText;
                [activityIndicator stopAnimating];
                
                [self presentModalViewController:picker animated:YES];
                [picker release];
                
            }else{
                [activityIndicator stopAnimating];
                NSLog(@"I don't suport sms");
                UIAlertView *fullAlert = [[UIAlertView alloc] initWithTitle:@"art+ SMS" message:@"Sorry. I don't support SMS™ on this device." delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil];
                
                [fullAlert show];
            }
        }
        @catch (NSException *e) {
            UIAlertView *fullAlert = [[UIAlertView alloc] initWithTitle:@"art+ SMS" message:@"Sorry. I don't support SMS™ on this device." delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil];
            
            [fullAlert show];
            
        }
    }
    else
    {
        UIAlertView *fullAlert = [[UIAlertView alloc] initWithTitle:@"art+ art info" message:@"art info not available" delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil];
        
        [fullAlert show];
        
    }
    
    [activityIndicator stopAnimating];
    activityIndicator.hidden = 1;label2.hidden=1;
    
    
}

- (void) loadFood2
{
    
}

- (void) loadFood1
{
    wWw.hidden = false;
    NSString *request = [NSString stringWithFormat:@"http://www.fatsecret.com/calories-nutrition/search?q=%@",[food text]];
   
    NSString *escapedUrl = [request   
                            stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *URL = [NSURL URLWithString:escapedUrl];
    
    NSError *error;
    NSString *XML = [NSString stringWithContentsOfURL:URL encoding:NSASCIIStringEncoding error:&error];
    
    @try {
        [foodDesc setText:@""];
        
        NSString *link = [[[[XML componentsSeparatedByString:@"prominent\" href=\""] objectAtIndex:1] componentsSeparatedByString:@"\""] objectAtIndex:0];
        
        str = [[[[XML componentsSeparatedByString:@"- Calories"] objectAtIndex:1] componentsSeparatedByString:@"| Protein: "] objectAtIndex:0];
   
        NSString *str2 = [NSString stringWithFormat:@"Calories%@",str];
        
        [lblInfo setText:str2];
        
        NSLog(@"Request: %@", str);
        NSString *request = [NSString stringWithFormat:@"http://www.fatsecret.com/calories-nutrition%@",link];
        
        [lbllink setText:request];

        NSLog(@"Request: %@", request);

        NSString *escapedUrl = [request   
                                stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        NSURL *URL = [NSURL URLWithString:escapedUrl];
        
        NSError *error;
        NSString *XML = [NSString stringWithContentsOfURL:URL encoding:NSASCIIStringEncoding error:&error];
        
        NSString *link2 = [[[[XML componentsSeparatedByString:@"<div class=\"nutpanel\">"] objectAtIndex:1] componentsSeparatedByString:@"Your daily values "] objectAtIndex:0];
       
        NSString *chart = [[[[XML componentsSeparatedByString:@"cfp_breakdown_container\" style=\"width:255px\">"] objectAtIndex:1] componentsSeparatedByString:@"</table>"] objectAtIndex:0];
        
        chart = [chart stringByReplacingOccurrencesOfString:@"/static/" withString:@"http://www.fatsecret.com/static/"]; 
        
        NSString *title = [[[[XML componentsSeparatedByString:@"<title>"] objectAtIndex:1] componentsSeparatedByString:@"</title>"] objectAtIndex:0];
        
        NSLog(@"%@", link2);
        
           NSLog(@"%@", title);
        title = [title stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""]; 
        title = [title stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"]; 
        [foodTitle setText:title];
        
        //http://www.fatsecret.com/static/css/default_16.css?v=3
        //
        
        
        NSString* wwwTextAppend = [NSString stringWithFormat:@"<link rel=\"stylesheet\" href=\"http://www.fatsecret.com/static/css/default_16.css?v=3\" type=\"text/css\"/>"];
        
        NSString* wwwText = [NSString stringWithFormat:@"%@<font face=\"Arial\">%@</font><br><br>%@", wwwTextAppend,link2,chart];
        [foodDesc setText:wwwText];
        
        [wWw loadHTMLString:wwwText baseURL:nil];
        
        //[wWw loadHTMLString:translation baseURL:nil];
        
                
        NSLog(@"%@",request);
        
    }
    @catch (NSException *e) {
        NSString *answer = @"Invalid Query.";
        
             [self performSelector:@selector(clear) withObject:nil afterDelay:0.01];
        
        NSLog(@"%@", answer);
        //[foodDesc setText:answer];
        UIAlertView *fullAlert = [[UIAlertView alloc] initWithTitle:@"art+ art info" message:@"art info not available" delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil];
        
        [fullAlert show];
        NSLog(@"Exception: %@", e);
    }
   // activityIndicator.hidden = 1;label2.hidden=1;   
     
    [food resignFirstResponder];
}

-(IBAction)dismissKeyboard: (id)sender {
    [sender resignFirstResponder];

    
    NSString *urlpath = [[NSString alloc] initWithFormat:@"%@", [food text]];
    int numLtrs = [urlpath length];
    
    
    
    if (numLtrs > 1)
    {    
    label2.text = @"searching art...";
    activityIndicator.hidden = 0;label2.hidden=0;
    [activityIndicator startAnimating];
    [self performSelector:@selector(search) withObject:nil afterDelay:0.01];
    }
    
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error 
{   
    [self dismissModalViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}
- (IBAction)search
{
    
       NSString *tit = [NSString stringWithFormat:@"Search Results for %@",[food text]];
    [foodTitle setText:tit];
    foodTitle.text = tit;
    pageNo = 1;
  //  next1.value = 1;
    
    
    NSString *outputText = [[NSString alloc] initWithFormat:@"Page %d",pageNo];
    pageNumber.text = outputText;

    next1.enabled = YES;
    label2.text = @"searching art...";
    activityIndicator.hidden = 0;label2.hidden=0;
    [activityIndicator startAnimating];
    [self performSelector:@selector(searchTats) withObject:nil afterDelay:0.01];
}

- (BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType {
        label2.text = @"loading art...";
    activityIndicator.hidden = 0;label2.hidden=0;
    if (navigationType == UIWebViewNavigationTypeLinkClicked) {
        
        
        NSURL *URL = [request URL]; 
        NSString *urlString = [URL absoluteString];
        NSLog(@"url is: %@ ", urlString);
        
        
        NSString *tit = [NSString stringWithFormat:@"%@",urlString];
        
        @try {
            [foodDesc setText:@""];
            
 
            NSString *request = [NSString stringWithFormat:@"%@",tit];
            
            [lbllink setText:request];
            
            NSLog(@"Request: %@", request);
         
            
            NSString *escapedUrl = [request   
                                    stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            
            NSURL *URL = [NSURL URLWithString:escapedUrl];
            
            NSError *error;
            NSString *XML = [NSString stringWithContentsOfURL:URL encoding:NSASCIIStringEncoding error:&error];
            //<td class="header" colspan=2>
            NSLog(@"XML*1111111: %@", XML);
            
            //<td class=\"details\">
            //</table>
          
            NSString *title = [[[[XML componentsSeparatedByString:@"<meta name=\"title\" content=\"artnet Galleries:"] objectAtIndex:1] componentsSeparatedByString:@"\""] objectAtIndex:0];
            
            
            NSString *desc = [[[[XML componentsSeparatedByString:@"<img src=\"/art"] objectAtIndex:1] componentsSeparatedByString:@"/>"] objectAtIndex:0];
            
            
            
            NSString* wwwText = [NSString stringWithFormat:@"<body bgcolor=\"Black\"><font face=\"Arial\"><img src=\"http://images.artnet.com/art%@\"/></font><br><br><br><br>", desc];
 
            NSString *link = [[[[wwwText componentsSeparatedByString:@"<img src=\""] objectAtIndex:1] componentsSeparatedByString:@".jpg"] objectAtIndex:0];
            
            NSString *outputText = [[NSString alloc] initWithFormat:@"%@.jpg",link];
           
            lbllink.text = outputText;
            
            [foodDesc setText:wwwText];
            [foodTitle setText:title];
            [lbllink setText:outputText];
            
            [wWw loadHTMLString:wwwText baseURL:nil];
            
            //[wWw loadHTMLString:translation baseURL:nil];
            
            
            NSLog(@"%@",request);
            
        }
        @catch (NSException *e) {
            NSString *answer = @"Invalid Query.";
            
            [self performSelector:@selector(clear) withObject:nil afterDelay:0.01];
            
            NSLog(@"%@", answer);
            //[foodDesc setText:answer];
            UIAlertView *fullAlert = [[UIAlertView alloc] initWithTitle:@"art+ art info" message:@"art info not available" delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil];
            
            [fullAlert show];
            NSLog(@"Exception: %@", e);
        }
       
   
    }   
    return YES;   
}


- (void)searchTats
{
    wWw.hidden = false;
    lbllink.text = @"";
    
    NSString *searchCriteria = food.text;
    searchCriteria = [searchCriteria stringByReplacingOccurrencesOfString:@" " withString:@"+"]; 

    NSString *request = [NSString stringWithFormat:@"http://www.artnet.com/ag/fulltextsearch.asp?searchstring=%@&currentCategory=Artwork&page=%d",searchCriteria,pageNo];
    

    
    [lbllink setText:request];
    [lblInfo setText:@"No Info"]; 
    
    NSString *escapedUrl = [request   
                            stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *URL = [NSURL URLWithString:escapedUrl];
    
    NSError *error;
    NSString *XML = [NSString stringWithContentsOfURL:URL encoding:NSASCIIStringEncoding error:&error];
              NSLog(@"XML*** :%@", XML);
    @try {
        [foodDesc setText:@""];
        
        NSString *link = [[[[XML componentsSeparatedByString:@"<b>ARTWORKS</b>"] objectAtIndex:1] componentsSeparatedByString:@"</table>"] objectAtIndex:0];

          link = [link stringByReplacingOccurrencesOfString:@"<a href=\"/artists/" withString:@"<a rel=\"/artists/"];
               link = [link stringByReplacingOccurrencesOfString:@"<a href=\"/Auctions" withString:@"<a rel=\"/Auctions"];
        
            link = [link stringByReplacingOccurrencesOfString:@"<a href=\"/AuctionHouses" withString:@"<a rel=\"/AuctionHouses"];
        
        
          link = [link stringByReplacingOccurrencesOfString:@"<a href=\"/auctions" withString:@"<a rel=\"/auctions"];
           link = [link stringByReplacingOccurrencesOfString:@"<a href=\"/gallery" withString:@"<a rel=\"/gallery"];
       
        link = [link stringByReplacingOccurrencesOfString:@"<a href=\"" withString:@"<font color='white'><a href=\"http://www.artnet.com"];
        
        link = [link stringByReplacingOccurrencesOfString:@"</td>" withString:@"</font></td>"];
        
        link = [link stringByReplacingOccurrencesOfString:@"<img src='/images/white.gif' " withString:@"<img src='http://www.artnet.com/images/white.gif' "];
        //<a href="/artists/
        //<a href="/Auctions
        //<img src='/images/white.gif' 
        NSLog(@"link*** :%@", link);
        
        
        //www.artdesign.com
        
        //<tr align=center><td align=center colspan=6><script type=\"text/javascript\">
        NSString *HTML = [NSString stringWithFormat:@"<body bgcolor='black'><table>%@</table><br><br><br></body>",link];
        
             NSLog(@"HTML*** :%@", HTML);
        
        
        [wWw loadHTMLString:HTML baseURL:nil];
         HTML = [HTML stringByReplacingOccurrencesOfString:@"'white'" withString:@"'black'"];
        [foodDesc setText:HTML];
        
        NSLog(@"%@",request);
        
    }
    @catch (NSException *e) {
        NSString *answer = @"Invalid Query.";
        
        [self performSelector:@selector(clear) withObject:nil afterDelay:0.01];
        
        NSLog(@"%@", answer);
        //[foodDesc setText:answer];
        UIAlertView *fullAlert = [[UIAlertView alloc] initWithTitle:@"art+ art info" message:@"art info not available" delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil];
        
        [fullAlert show];
        NSLog(@"Exception: %@", e);
    }
    //activityIndicator.hidden = 1;label2.hidden=1;   
    
    [food resignFirstResponder];

}
- (IBAction)help
{
    UIAlertView *fullAlert = [[UIAlertView alloc] initWithTitle:@"art+ Help" message:@"Please enter art search criteria and click the search button to find search results for art. You may click on the individual items in the search results for more information and a higer resolution pic. You may also click the plus or minus button to increment or decrement the displayed page (up to 20 and only with iOS 5.0). You may also e-mail art info, or SMS info/URL as well.  You may also copy description information and art image URL to the clipboard, Also finally you are able to share on different social networking platforms. Just click paste (art information is on clipboard). " delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil];
    
    [fullAlert show];
}

- (IBAction)clear
{
    foodDesc.text = @"";
    foodTitle.text = @"";
    food.text = @"";
    pageNumber.text = @"Page 1";
    wWw.Hidden = true;
    
    NSString* wwwText = @"";
    [food resignFirstResponder];
    
    [wWw loadHTMLString:wwwText baseURL:nil];
    
}
- (void)actionSheet:(UIActionSheet *)popup clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    switch (popup.tag) {
        case 1:
        {
            NSString *outputText = [[NSString alloc] initWithFormat:@"%@ - URL:%@",foodTitle.text,lbllink.text];
            
            UIPasteboard *appPasteBoard = [UIPasteboard generalPasteboard];
            appPasteBoard.persistent = YES;
            [appPasteBoard setString:outputText];
            
            
            
            switch (buttonIndex) {
                    
                    
                case 0: 
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.facebook.com/dialog/feed?app_id=349094268455466&redirect_uri=http%3A//www.facebook.com/apps/application.php?id=349094268455466&to&message=@[199116963445570%3A2048%3ACHANGE_OR_ALTER_THIS_WITH_YOUR_OWN_YOUR_OWN_MESSAGE]&display=touch"]];
                    
                    break;
                case 1: 
                    
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.myspace.com/Modules/PostTo/Pages/?t=translate%20plus:click%20paste%20on%20text%20box&c=message&l=1"]];
                    
                    break;                        
                case 2:
                
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://twitter.com/intent/tweet?source=webclient&text="]];
                    
                    break; 
                case 3:   
                    
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://m.google.com/app/plus/x/976fbnrafv3e/?content=Paste%20Here&v=compose&pli=1&login=1"]];
                case 4:
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.tumblr.com/share"]];
                    
                    break;
                default: 
                    break; 
                        
            }
            break;  
        }
        default:break;
    }
}

- (IBAction)share
{
    
    UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:@"Select Sharing option (the art name and url info is copied to your clipboard. Click the textbox and select paste):" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:
                            @"Share on Facebook",
                            @"Share on MySpace",
                            @"Share on Twitter",
                            @"Share on Google+",
                            @"Share on tumblr",
                            nil];
    
    [[[popup valueForKey:@"_buttons"] objectAtIndex:0] setImage:[UIImage imageNamed:@"facebook-icon.png"] forState:UIControlStateNormal];
    [[[popup valueForKey:@"_buttons"] objectAtIndex:1] setImage:[UIImage imageNamed:@"myspace-icon.png"] forState:UIControlStateNormal];
    [[[popup valueForKey:@"_buttons"] objectAtIndex:2] setImage:[UIImage imageNamed:@"twitter-icon.png"] forState:UIControlStateNormal];
    [[[popup valueForKey:@"_buttons"] objectAtIndex:3] setImage:[UIImage imageNamed:@"google-icon.png"] forState:UIControlStateNormal];
    [[[popup valueForKey:@"_buttons"] objectAtIndex:4] setImage:[UIImage imageNamed:@"Tumblr-icon.png"] forState:UIControlStateNormal];
    
    popup.tag = 1;
    
    [popup showInView:[UIApplication sharedApplication].keyWindow];
    
    //[popup release];
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (motion == UIEventSubtypeMotionShake)
    {

    }
}

#pragma mark - View lifecycle

-(BOOL)canBecomeFirstResponder {
    return YES;
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self resignFirstResponder];
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad
{    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque];
    wWw.delegate = self;
    [super viewDidLoad];
    activityIndicator.hidden = TRUE;
    pageNo = 1;
  //  next1.value = 1;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


@end
