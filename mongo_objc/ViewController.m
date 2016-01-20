//
//  ViewController.m
//  mongo_objc
//
//  Created by Hunter Houston on 12/20/15.
//  Copyright © 2015 Hunter Houston. All rights reserved.
//

#import "ViewController.h"
#import "Account.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _accountNames = @[@"Hunter Houston", @"Kate Davis",
                      @"Sam Lahourcade", @"Holly Frost", @"SUPERMAN"];
    
    _companyNames = @[@"Sungard", @"Georgia",
                      @"AXA", @"Texas RT Systems", @"Krypton"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)addAccount:(id)sender {
    // Create your request string with parameter name as defined in PHP file
    
    NSString *userID = @"23";
    
    //account attributes
    NSString *accountID = @"32";
    NSString *companyName = @"company name";
    NSString *projectName = @"project name";
    BOOL isVIP = YES;
    
    
    //contact attributes
    NSString *firstName = @"john";
    NSString *lastName = @"thompson";
    NSString *email = @"hunter@houston.com";
    NSString *phone = @"7137038501";
    NSString *phone2 = @"8123940493";
    
//    NSString *myRequestString = [NSString stringWithFormat:@"userID=%@&accountID=%@&companyName=%@&projectName=%@&isVIP=%d&firstName=%@&lastName=%@&email=%@&phone=%@&phone2=%@",userID,accountID,companyName,projectName,isVIP,firstName,lastName,email,phone,phone2];
    
    NSString *myRequestString = [NSString stringWithFormat:@"name=%@",firstName];
    // Create Data from request
    NSData *myRequestData = [NSData dataWithBytes: [myRequestString UTF8String] length: [myRequestString length]];
    //NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL: [NSURL URLWithString: @"http://ec2-52-88-55-141.us-west-2.compute.amazonaws.com/add_account.php"]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL: [NSURL URLWithString: @"http://192.168.8.201/add_account.js"]];
    // set Request Type
    [request setHTTPMethod: @"POST"];
    // Set content-type
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
    // Set Request Body
    [request setHTTPBody: myRequestData];
    // Now send a request and get Response
    NSData *returnData = [NSURLConnection sendSynchronousRequest: request returningResponse: nil error: nil];
    // Log Response
    NSString *response = [[NSString alloc] initWithBytes:[returnData bytes] length:[returnData length] encoding:NSUTF8StringEncoding];
    NSLog(@"%@",response);
}

- (IBAction)addAccounts:(id)sender {
    int counter = 0;
    
    for (int i = 0; i < 100; i++) {
        
        counter = i;
    NSString *userID = @"23";
    
    //account attributes
    NSString *accountID = @"32";
    NSString *companyName = @"company name";
    NSString *projectName = @"project name";
    BOOL isVIP = YES;
    
    
    //contact attributes
    NSString *firstName = @"john";
    NSString *lastName = @"thompson";
    NSString *email = @"hunter@houston.com";
    NSString *phone = @"7137038501";
    NSString *phone2 = @"8123940493";
    
    NSString *myRequestString = [NSString stringWithFormat:@"userID=%i&accountID=%@&companyName=%@&projectName=%@&isVIP=%d&firstName=%@&lastName=%@&email=%@&phone=%@&phone2=%@",counter,accountID,companyName,projectName,isVIP,firstName,lastName,email,phone,phone2];
    
    // Create Data from request
    NSData *myRequestData = [NSData dataWithBytes: [myRequestString UTF8String] length: [myRequestString length]];
    //NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL: [NSURL URLWithString: @"http://ec2-52-88-55-141.us-west-2.compute.amazonaws.com/add_account.php"]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL: [NSURL URLWithString: @"http://192.168.1.201/add_account.php"]];
    // set Request Type
    [request setHTTPMethod: @"POST"];
    // Set content-type
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
    // Set Request Body
    [request setHTTPBody: myRequestData];
    // Now send a request and get Response
    NSData *returnData = [NSURLConnection sendSynchronousRequest: request returningResponse: nil error: nil];
    // Log Response
    NSString *response = [[NSString alloc] initWithBytes:[returnData bytes] length:[returnData length] encoding:NSUTF8StringEncoding];
    NSLog(@"%@",response);
    }

}

- (IBAction)deleteAccount:(id)sender {
    // Create your request string with parameter name as defined in PHP file
    
    NSString *userID = @"23";
    
    //account attributes
    NSString *accountID = @"32";
    
    NSString *myRequestString = [NSString stringWithFormat:@"userID=%@&accountID=%@",userID,accountID];
    
    // Create Data from request
    NSData *myRequestData = [NSData dataWithBytes: [myRequestString UTF8String] length: [myRequestString length]];
    //NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL: [NSURL URLWithString: @"http://ec2-52-88-55-141.us-west-2.compute.amazonaws.com/delete_account.php"]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL: [NSURL URLWithString: @"http://192.168.1.201/delete_account.php"]];
    // set Request Type
    [request setHTTPMethod: @"POST"];
    // Set content-type
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
    // Set Request Body
    [request setHTTPBody: myRequestData];
    // Now send a request and get Response
    NSData *returnData = [NSURLConnection sendSynchronousRequest: request returningResponse: nil error: nil];
    // Log Response
    NSString *response = [[NSString alloc] initWithBytes:[returnData bytes] length:[returnData length] encoding:NSUTF8StringEncoding];
    NSLog(@"%@",response);
}
- (IBAction)fetchAccounts:(id)sender {
    // Create your request string with parameter name as defined in PHP file
    
    NSString *userID = @"23";
    
    NSString *myRequestString = [NSString stringWithFormat:@"userID=%@",userID];
    
    // Create Data from request
    NSData *myRequestData = [NSData dataWithBytes: [myRequestString UTF8String] length: [myRequestString length]];
    //NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL: [NSURL URLWithString: @"http://ec2-52-88-55-141.us-west-2.compute.amazonaws.com/fetch_accounts.php"]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL: [NSURL URLWithString: @"http://192.168.1.201/fetch_accounts.php"]];
    // set Request Type
    [request setHTTPMethod: @"POST"];
    // Set content-type
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
    // Set Request Body
    [request setHTTPBody: myRequestData];
    // Now send a request and get Response
    NSData *returnData = [NSURLConnection sendSynchronousRequest: request returningResponse: nil error: nil];
    // Log Response
    NSString *response = [[NSString alloc] initWithBytes:[returnData bytes] length:[returnData length] encoding:NSUTF8StringEncoding];
    NSLog(@"%@",response);
}
- (IBAction)addActivity:(id)sender {
    // Create your request string with parameter name as defined in PHP file
    
    NSString *userID = @"23";
    NSString *accountID = @"32";
    NSString *activityID = @"55";
    int type = 7;
    NSDate *dateCreated = [NSDate date];
    NSString *notes = @"notes";
    bool inbound = false;
    
    NSString *myRequestString = [NSString stringWithFormat:@"userID=%@&activityID=%@&accountID=%@&type=%d&dateCreated%@&notes=%@&inbound=%d",userID,activityID,accountID,type,dateCreated,notes,inbound];
    
    // Create Data from request
    NSData *myRequestData = [NSData dataWithBytes: [myRequestString UTF8String] length: [myRequestString length]];
    
    //NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL: [NSURL URLWithString: @"http://ec2-52-88-55-141.us-west-2.compute.amazonaws.com/add_activity.php"]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL: [NSURL URLWithString: @"http://192.168.8.201/add_activity.php"]];
    // set Request Type
    [request setHTTPMethod: @"POST"];
    // Set content-type
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
    // Set Request Body
    [request setHTTPBody: myRequestData];
    // Now send a request and get Response
    NSData *returnData = [NSURLConnection sendSynchronousRequest: request returningResponse: nil error: nil];
    // Log Response
    NSString *response = [[NSString alloc] initWithBytes:[returnData bytes] length:[returnData length] encoding:NSUTF8StringEncoding];
    NSLog(@"%@",response);
}
- (IBAction)deleteActivity:(id)sender {
    // Create your request string with parameter name as defined in PHP file
    
    NSString *userID = @"23";
    NSString *activityID = @"55";
    
    NSString *myRequestString = [NSString stringWithFormat:@"userID=%@&activityID=%@",userID,activityID];
    
    // Create Data from request
    NSData *myRequestData = [NSData dataWithBytes: [myRequestString UTF8String] length: [myRequestString length]];
    //NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL: [NSURL URLWithString: @"http://ec2-52-88-55-141.us-west-2.compute.amazonaws.com/delete_activity.php"]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL: [NSURL URLWithString: @"http://192.168.1.201/delete_activity.php"]];
    // set Request Type
    [request setHTTPMethod: @"POST"];
    // Set content-type
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
    // Set Request Body
    [request setHTTPBody: myRequestData];
    // Now send a request and get Response
    NSData *returnData = [NSURLConnection sendSynchronousRequest: request returningResponse: nil error: nil];
    // Log Response
    NSString *response = [[NSString alloc] initWithBytes:[returnData bytes] length:[returnData length] encoding:NSUTF8StringEncoding];
    NSLog(@"%@",response);
}

- (void)parseAndAddLocations:(NSArray*)locations toArray:(NSMutableArray*)destinationArray
{
    for (NSDictionary* item in locations) {
        Account* location = [[Account alloc] initWithDictionary:item];
        [destinationArray addObject:location];
        
//        if (location.imageId) { //1
//            [self loadImage:location];
//        }
    }

}

//update and add
- (IBAction)addAccountNode:(id)sender {
    
    //check if exists already
    //
    
    Account *newUser = [[Account alloc] init];
    newUser._id = @"568a644d58160eb76112cd36";
    newUser.name = @"NAME";

    
//    if (!newUser._id || newUser._id == nil || newUser._id.length == 0) {
//        return; //input safety check
//    }
    
    NSString* locations = [@"http://192.168.8.201:3000/" stringByAppendingPathComponent:@"locations"];
    
    BOOL isExistingLocation = newUser._id != nil;
    //NSURL *url = [NSURL URLWithString:locations];
    NSURL* url = isExistingLocation ? [NSURL URLWithString:[locations stringByAppendingPathComponent:newUser._id]] :
    [NSURL URLWithString:locations]; //1
    
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = isExistingLocation ? @"PUT" : @"POST"; //2
    //request.HTTPMethod = @"POST";
    NSLog(@"HTTP:%@",request.HTTPMethod);
    NSLog(@"newUser:%@",[newUser toDictionary]);
    NSData* data = [NSJSONSerialization dataWithJSONObject:[newUser toDictionary] options:0 error:NULL]; //3
    request.HTTPBody = data;
    
    NSLog(@"data:%@",data);
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"]; //4
    NSLog(@"request:%@",request);
    NSURLSessionConfiguration* config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession* session = [NSURLSession sessionWithConfiguration:config];
    
    NSURLSessionDataTask* dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) { //5
        if (!error) {
            NSArray* responseArray = @[[NSJSONSerialization JSONObjectWithData:data options:0 error:NULL]];
            NSLog(@"add account response: %@",responseArray);
            //[self parseAndAddLocations:responseArray toArray:self.objects];
        } else {
            NSLog(@"ERROR:%@",error);
        }
        
    }];
    [dataTask resume];
    
}
- (IBAction)fetchAccountsNode:(id)sender {
    NSURL* url = [NSURL URLWithString:[@"http://192.168.8.201:3000/" stringByAppendingPathComponent:@"locations"]]; //1
    
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"GET"; //2
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"]; //3
    
    NSURLSessionConfiguration* config = [NSURLSessionConfiguration defaultSessionConfiguration]; //4
    NSURLSession* session = [NSURLSession sessionWithConfiguration:config];
    
    NSURLSessionDataTask* dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) { //5
        if (error == nil) {
            NSArray* responseArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL]; //6
            NSLog(@"fetch accounts response: %@",responseArray);
            //[self parseAndAddLocations:responseArray toArray:self.objects];
        }
    }];
    
    [dataTask resume]; //8
}

@end