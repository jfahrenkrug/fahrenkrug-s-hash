//
//  AppDelegate.h
//  FahrenkrugsHash
//
//  Created by Johannes Fahrenkrug on 11/26/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface AppDelegate : NSObject {
	IBOutlet NSTextField *usernameTextField;
	IBOutlet NSTextField *passwordTextField;
	IBOutlet NSButton *hashCheckbox;
	IBOutlet NSTextField *resultTextField;
	
	NSMutableData *receivedData;
}

- (IBAction)login:(id)sender;

@end
