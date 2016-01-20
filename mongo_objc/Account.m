//
//  Location.m
//  TourMyTown
//
//  Created by Michael Katz on 8/15/13.
//  Copyright (c) 2013 mikekatz. All rights reserved.
//

#import "Account.h"

#define safeSet(d,k,v) if (v) d[k] = v;

@interface Account ()
@property (nonatomic, retain) id location;

@end

@implementation Account


//- (instancetype) init
//{
//    self = [super init];
//    if (self) {
//        _categories = [NSMutableArray array];
//    }
//    return self;
//}

#pragma mark - MKAnnotation

- (NSString *)title
{
    return self.name;
}

- (NSString *)subtitle
{
    return (self.details != nil && self.details.length > 0) ? self.details : self.placeName;
}



#pragma mark - GeoJSON



- (void) setGeoJSON:(id)geoPoint
{
    _location = geoPoint;
}

#pragma mark - serialization

- (instancetype) initWithDictionary:(NSDictionary*)dictionary
{
    self = [super init];
    if (self) {
        _name = dictionary[@"name"];
//        _location = dictionary[@"location"];
//        _placeName = dictionary[@"placename"];
//        _imageId = dictionary[@"imageId"];
//        _details = dictionary[@"details"];
//        _categories = [NSMutableArray arrayWithArray:dictionary[@"categories"]];
        __id = dictionary[@"_id"];
    }
    return self;
}

- (NSDictionary*) toDictionary
{
    NSMutableDictionary* jsonable = [NSMutableDictionary dictionary];
    //safeSet(jsonable, @"name", self.name);
//    safeSet(jsonable, @"placename", self.placeName);
//    safeSet(jsonable, @"location", self.location);
//    safeSet(jsonable, @"details", self.details);
//    safeSet(jsonable, @"imageId", self.imageId);
//    safeSet(jsonable, @"categories", self.categories);
    safeSet(jsonable, @"_id", self._id);
    return jsonable;
}
@end