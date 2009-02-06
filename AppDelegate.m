//
//  AppDelegate.m
//  FahrenkrugsHash
//
//  Created by Johannes Fahrenkrug on 11/26/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"


@implementation AppDelegate

- (IBAction)login:(id)sender {  
	//display an alert if either username or pwd are empty
	
	receivedData = [[NSMutableData alloc] init];
	NSString *url = @"http://browserspy.dk/password-ok.php";
	
	if ([hashCheckbox state] == 1) {
		url = [url stringByAppendingString:@"#"];
	}
	
	NSLog(url);

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:20];
	[request setHTTPShouldHandleCookies:NO];
	//[NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost: [[NSURL URLWithString:url] host]];
	[[NSURLConnection alloc] initWithRequest:request delegate:self];	
}


#pragma mark urlconnection delegate methods
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
	// this method is called when the server has determined that it
	// has enough information to create the NSURLResponse
	
	// it can be called multiple times, for example in the case of a
	// redirect, so each time we reset the data.
	// receivedData is declared as a method instance elsewhere
	[receivedData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	// append the new data to the receivedData
	// receivedData is declared as a method instance elsewhere
	NSLog(@"did receive data");
	[receivedData appendData:data];
}

- (void)connection:(NSURLConnection *)connection
  didFailWithError:(NSError *)error
{
	[connection release];
	
	NSLog(@"Connection failed! Error - %@ %@",
		  [error localizedDescription],
		  [[error userInfo] objectForKey:NSErrorFailingURLStringKey]);
	
	[receivedData release];
	receivedData = nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	NSLog(@"login succeeded!");
	
	[connection release];
    
	NSString *response = [NSString stringWithCString:[receivedData bytes] length:[receivedData length]];  
	
	NSLog(@"Response length: %i", [receivedData length]);
	[resultTextField setStringValue:response];
	
	[receivedData release];
	receivedData = nil;
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
	NSLog(@"got auth challange");
	
	if ([challenge previousFailureCount] == 0) {
		[[challenge sender]  useCredential:[NSURLCredential credentialWithUser:[usernameTextField stringValue] password:[passwordTextField stringValue] persistence:NSURLCredentialPersistenceNone] forAuthenticationChallenge:challenge];
	} else {
        [[challenge sender] cancelAuthenticationChallenge:challenge];        
    }
}

- (void)dealloc {
	[super dealloc];
}

@end
