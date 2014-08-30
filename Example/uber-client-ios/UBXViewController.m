//
//  UBXViewController.m
//  uber-client-ios
//
//  Created by Nabib El-Rahman on 08/24/2014.
//  Copyright (c) 2014 Nabib El-Rahman. All rights reserved.
//

#import "UBXViewController.h"
#import "NXOAuth2.h"

#import <uber-client-ios/UBXProduct.h>
#import <uber-client-ios/UBXPriceEstimate.h>
#import <uber-client-ios/UBXTimeEstimate.h>
#import <uber-client-ios/UBXHistory.h>
#import <uber-client-ios/UBXUserProfile.h>



@interface UBXViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *loginWebView;

@end

@implementation UBXViewController

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"WEBVIEW REQUEST %@", webView.request.URL.absoluteString);
    if ([webView.request.URL.absoluteString rangeOfString:@"https://login.uber.com/oauth/authorize" options:NSCaseInsensitiveSearch].location != NSNotFound) {
        self.loginWebView.hidden = NO;
    } else {
        //otherwise hide the UIWebView, we've left the authorization flow
        self.loginWebView.hidden = YES;
        
        //TODO: Need to get correct redirect URL to continue..
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.loginWebView.delegate = self;
    
	 [self setupOAuth2AccountStore];
    [self requestOAuth2Access];
}



#pragma mark - OAuth2 Logic

- (void)setupOAuth2AccountStore
{
    [[NXOAuth2AccountStore sharedStore] setClientID:@"client_id_here"
                                             secret:@"secret_here"
                                   authorizationURL:[NSURL URLWithString:@"https://login.uber.com/oauth/authorize"]
                                           tokenURL:[NSURL URLWithString:@"https://login.uber.com/oauth/token"]
                                        redirectURL:[NSURL URLWithString:@"http://localhost/home"]
                                     forAccountType:@"UberService"];
    

    
    [[NSNotificationCenter defaultCenter] addObserverForName:NXOAuth2AccountStoreAccountsDidChangeNotification
                                                      object:[NXOAuth2AccountStore sharedStore]
                                                       queue:nil
                                                  usingBlock:^(NSNotification *aNotification){
                                                      
                                                      if (aNotification.userInfo) {
                                                          //account added, we have access
                                                          //we can now request protected data
                                                          NSLog(@"Success!! We have an access token.");
                                                      } else {
                                                          //account removed, we lost access
                                                      }
                                                  }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:NXOAuth2AccountStoreDidFailToRequestAccessNotification
                                                      object:[NXOAuth2AccountStore sharedStore]
                                                       queue:nil
                                                  usingBlock:^(NSNotification *aNotification){
                                                      
                                                      NSError *error = [aNotification.userInfo objectForKey:NXOAuth2AccountStoreErrorKey];
                                                      NSLog(@"Error!! %@", error.localizedDescription);
                                                      
                                                  }];
}

-(void)requestOAuth2Access
{
    [[NXOAuth2AccountStore sharedStore] requestAccessToAccountWithType:@"UberService"
                                   withPreparedAuthorizationURLHandler:^(NSURL *preparedURL){
                                      
                                       NSLog(@"CALLED IN PREPARE AUTH HANDLER! %@", preparedURL);
                                       [self.loginWebView loadRequest:[NSURLRequest requestWithURL:preparedURL]];
                                   }];
}

@end
