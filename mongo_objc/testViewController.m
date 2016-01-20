//
//  test.m
//  mongo_objc
//
//  Created by Hunter Houston on 1/4/16.
//  Copyright © 2016 Hunter Houston. All rights reserved.
//

#import "testViewController.h"
#import "ViewController.h"
#import "Account.h"
//#import <NAChloride/NAChloride.h>
#define safeSet(d,k,v) if (v) d[k] = v;

@interface ViewController ()

@end



@implementation testViewController
- (void)viewDidLoad {
    [super viewDidLoad];

    //_accountNames = @[@"Hunter Houston", @"Kate Davis", @"Sam Lahourcade", @"Holly Frost", @"SUPERMAN"];
    
    //_companyNames = @[@"Sungard", @"Georgia", @"AXA", @"Texas RT Systems", @"Krypton"];
    
    
    
    //Account *newUser = [[Account alloc] init];
    //newUser._id = @"99";

    
    //[self addAccount:newUser];
//    for (int i = 0; i < 1000; i++) {
//        newUser._id = [NSString stringWithFormat:@"%d",i];
//        [self addAccount:newUser];
//    }
    
    //[self addAccount:newUser];
    //[self deleteAccount:newUser];
    //[self fetchAccounts:@"C4BA83BB-98E5-4F76-8FD4-D7EFDDAFB902"];
//    [self fetchAccounts:@"3C016D00-84CB-4756-AD54-0EAA7803FB5A"];
//    [self syncUser];
//    [self addUser];
//    [self addAccount];
//    [self updateAccount];
//    [self pullUpdatedAccounts];
    [self NAChlorideTest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)NAChlorideTest {
//    NAChlorideInit();
//    
//    NSData *key = [NARandom randomData:NASecretBoxKeySize];
//    NSData *nonce = [NARandom randomData:NASecretBoxNonceSize];
//    NSData *message = [@"This is a secret message" dataUsingEncoding:NSUTF8StringEncoding];
//    
//    NASecretBox *secretBox = [[NASecretBox alloc] init];
//    NSError *error = nil;
//    NSData *encrypted = [secretBox encrypt:message nonce:nonce key:key error:&error];
//    // If an error occurred encrypted will be nil and error set
//    
//    NSData *decrypted = [secretBox decrypt:encrypted nonce:nonce key:key error:&error];
}

//update and add
-(void)addAccount {

    for (int i = 0; i < 20; i++) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSMutableDictionary* jsonable = [NSMutableDictionary dictionary];
        NSString *accountID = [NSString stringWithFormat:@"%d",i];
        safeSet(jsonable, @"userID", [defaults stringForKey:@"user_id_key"]);
        safeSet(jsonable, @"xcodeID", accountID); //accountID
        safeSet(jsonable, @"companyName", @"co");
        safeSet(jsonable, @"projectName", @"project");
        safeSet(jsonable, @"contact", @"contact");
        safeSet(jsonable, @"plan", @"plan");
        safeSet(jsonable, @"isVIP", @"true");
        //safeSet(jsonable, @"todoItems", [self todoToDict:self.todoItems]);
        safeSet(jsonable, @"lastSync",[defaults stringForKey:@"lastSync"]);

    //check if exists already
    //
    //    if (!newUser._id || newUser._id == nil || newUser._id.length == 0) {
    //        return; //input safety check
    //    }

    NSString *accounts = [@"http://192.168.8.201:3000/" stringByAppendingPathComponent:@"accounts"];
    
    //NSURL *url = [NSURL URLWithString:locations];
    NSURL* url = [NSURL URLWithString:accounts]; //1
    
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST"; //2
    //request.HTTPMethod = @"POST";
    
    //NSLog(@"HTTP:%@",request.HTTPMethod);
    
    NSData* data = [NSJSONSerialization dataWithJSONObject:jsonable options:0 error:NULL]; //3
    
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
}

-(void)deleteAccount:(Account*)newUser {

//check if exists already
//
//    if (!newUser._id || newUser._id == nil || newUser._id.length == 0) {
//        return; //input safety check
//    }
    NSString *accounts = [@"http://192.168.8.201:3000/" stringByAppendingPathComponent:@"accounts"];

    NSURL* url = [NSURL URLWithString:[accounts stringByAppendingPathComponent:newUser._id]];
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
request.HTTPMethod = @"DELETE"; //2
//request.HTTPMethod = @"POST";

//NSLog(@"HTTP:%@",request.HTTPMethod);

//NSLog(@"newUser:%@",[newUser toDictionary]);

//    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:@"_id", @"568a644d58160eb76112cd36", @"name", @"NAME", nil];

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
        NSLog(@"delete account response: %@",responseArray);
        //[self parseAndAddLocations:responseArray toArray:self.objects];
    } else {
        NSLog(@"ERROR:%@",error);
    }
    
}];
    [dataTask resume];

}

- (void)fetchAccounts:(NSString*)userID {
    
    NSString *accounts = [@"http://192.168.8.201:3000/" stringByAppendingPathComponent:@"activities"];
    NSString *q = [NSString stringWithFormat:@"{\"xcodeID\":\"%@\"}",userID];
    q = [q stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet alphanumericCharacterSet]];
    
    NSString *query = [NSString stringWithFormat:@"?query=%@",q];
    NSURL* url = [NSURL URLWithString:[accounts stringByAppendingString:query]];

    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"GET";
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    NSURLSessionConfiguration* config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession* session = [NSURLSession sessionWithConfiguration:config];
    
    NSURLSessionDataTask* dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error == nil) {
            NSArray* responseArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
            NSLog(@"fetch accounts response: %@",responseArray);
            //[self parseAndAddLocations:responseArray toArray:self.objects];
        }
    }];
    
    [dataTask resume]; 
}

-(void)updateAccount {
    NSMutableDictionary* jsonable = [NSMutableDictionary dictionary];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    safeSet(jsonable, @"userID", [defaults stringForKey:@"user_id_key"]);
    safeSet(jsonable, @"xcodeID", @"9"); //accountID
    safeSet(jsonable, @"companyName", @"co");
    safeSet(jsonable, @"projectName", @"project");
    safeSet(jsonable, @"contact", @"contact");
    safeSet(jsonable, @"plan", @"plan");
    safeSet(jsonable, @"isVIP", @"true");
    safeSet(jsonable, @"lastSync",[defaults stringForKey:@"lastSync"]);

    NSString *activities = [@"http://192.168.8.201:3000/" stringByAppendingPathComponent:@"accounts"];
    
    NSURL* url =[NSURL URLWithString:[activities stringByAppendingPathComponent:@"9"]];
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
    
    request.HTTPMethod = @"PUT";
    NSData* data = [NSJSONSerialization dataWithJSONObject:jsonable options:0 error:NULL];
    request.HTTPBody = data;
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSURLSessionConfiguration* config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession* session = [NSURLSession sessionWithConfiguration:config];
    
    NSURLSessionDataTask* dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (!error) {
            NSArray* responseArray = @[[NSJSONSerialization JSONObjectWithData:data options:0 error:NULL]];
            NSLog(@"update account response: %@",responseArray);
        } else {
            NSLog(@"ERROR:%@",error);
        }
        
    }];
    [dataTask resume];
}

- (void) syncUser {
    
    //check user.lastSync against object in mongodb
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *userID = [defaults stringForKey:@"user_id_key"];
    NSString *lastSync = [defaults stringForKey:@"lastSync"];
    
    NSString *accounts = [@"http://192.168.8.201:3000/" stringByAppendingPathComponent:@"users"];
    NSString *q = [NSString stringWithFormat:@"{\"xcodeID\":\"%@\"}",userID];
    
    q = [q stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet alphanumericCharacterSet]];
    
    
    NSString *query = [NSString stringWithFormat:@"?query=%@",q];
    NSURL* url = [NSURL URLWithString:[accounts stringByAppendingString:query]]; //1
    
    
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"GET";
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"]; //3
    
    NSURLSessionConfiguration* config = [NSURLSessionConfiguration defaultSessionConfiguration]; //4
    NSURLSession* session = [NSURLSession sessionWithConfiguration:config];
    
    // Convert string to date object
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    NSDate *coreDataLastSync = [dateFormat dateFromString:lastSync];
    
    
    NSURLSessionDataTask* dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) { //5
        if (error == nil) {
            NSArray* responseArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
            NSString *dbLastSyncStr = responseArray.firstObject[@"lastSync"];
            NSString *temp = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            //NSLog(@"%@",temp);
            //NSLog(@"db last sync string: %@",dbLastSyncStr);
            NSDate *dbLastSync = [dateFormat dateFromString:dbLastSyncStr];
            //NSLog(@"db last sync response: %@",dbLastSync);
            //NSLog(@"core data last sync response: %@",coreDataLastSync);
            //NSLog(@"fetch accounts response: %@",responseArray);
            
            //if updated version availabe, query for accounts with a more recent account.lastUpdate field
            if (   [dbLastSync earlierDate:coreDataLastSync] == coreDataLastSync){
                NSLog(@"needs to sync");
                [self pullUpdatedAccounts];
            }
            
        }
    }];
    
    [dataTask resume];
    
    //update core data and user.lastSync
}

- (void) pullUpdatedAccounts {
    
    NSLog(@"pull updated accounts");
    //check user.lastSync against object in mongodb
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *userID = [defaults stringForKey:@"user_id_key"];
    NSString *lastSync = [defaults stringForKey:@"lastSync"];
    
    NSString *accounts = [@"http://192.168.8.201:3000/" stringByAppendingPathComponent:@"accounts"];
    NSString *q = [NSString stringWithFormat:@"{\"userID\":\"%@\"}",userID];
    
    q = [q stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet alphanumericCharacterSet]];
    
    
    NSString *query = [NSString stringWithFormat:@"?query=%@",q];
    NSLog(@"query%@",query);
    NSURL* url = [NSURL URLWithString:[accounts stringByAppendingString:query]];
    
    
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"GET";
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    NSURLSessionConfiguration* config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession* session = [NSURLSession sessionWithConfiguration:config];
    
    // Convert string to date object
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    NSDate *coreDataLastSync = [dateFormat dateFromString:lastSync];
    
    
    NSURLSessionDataTask* dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (error == nil) {
            NSArray* responseArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
           
            for (NSString *obj in responseArray)
            {
                
                NSString *dbLastSyncStr = [obj valueForKey:@"lastSync"];
                NSDate *dbLastSync = [dateFormat dateFromString:dbLastSyncStr];
                
                if ([dbLastSync earlierDate:coreDataLastSync] == coreDataLastSync){
                    NSLog(@"%@needs to sync", [obj valueForKey:@"xcodeID"]);
                    //add array to core data
                }

            }
            NSString *dbLastSyncStr = responseArray.firstObject[@"lastSync"];
            NSDate *dbLastSync = [dateFormat dateFromString:dbLastSyncStr];

            

            
        }
    }];
    
    [dataTask resume];

}

- (void) addUser {
    
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
        NSString *userID = [defaults stringForKey:@"user_id_key"];

        NSString *lastSync = [defaults stringForKey:@"lastSync"];
        NSString *password = @"cheese";
        
        NSDictionary *userDict = [NSDictionary dictionaryWithObjectsAndKeys:userID,@"xcodeID", password, @"password", lastSync, @"lastSync", nil];
        
        NSString *users = [@"http://192.168.8.203:3000/" stringByAppendingPathComponent:@"users"];
        
        NSURL* url = [NSURL URLWithString:users];
        NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
        
        request.HTTPMethod = @"Post";
        NSData* data = [NSJSONSerialization dataWithJSONObject:userDict options:0 error:NULL];
        request.HTTPBody = data;
        [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        NSURLSessionConfiguration* config = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession* session = [NSURLSession sessionWithConfiguration:config];
        
        
        NSURLSessionDataTask* dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            if (!error) {
                NSArray* responseArray = @[[NSJSONSerialization JSONObjectWithData:data options:0 error:NULL]];
                //NSLog(@"add activity response: %@",responseArray);
            } else {
                NSLog(@"ERROR:%@",error);
            }
            
        }];
    
        [dataTask resume];
    
}



- (void) auth {
    
}

@end