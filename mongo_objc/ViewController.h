//
//  ViewController.h
//  mongo_objc
//
//  Created by Hunter Houston on 12/20/15.
//  Copyright © 2015 Hunter Houston. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>

@property (strong, nonatomic) NSArray *accountNames;
@property (strong, nonatomic) NSArray *companyNames;
@property (nonatomic, retain) id location;


@end

