//
//  Trains.h
//  GoEuro
//
//  Created by lokesh vunnam on 10/7/16.
//  Copyright © 2016 lokesh. All rights reserved.
//

#import "JSONModel.h"

@interface Trains : JSONModel

@property (nonatomic) NSInteger id;
@property (strong, nonatomic) NSString<Optional>* provider_logo;
@property (strong, nonatomic) NSString<Optional>* price_in_euros;
@property (strong, nonatomic) NSString<Optional>* departure_time;
@property (strong, nonatomic) NSString<Optional>* arrival_time;
@property (strong, nonatomic) NSString<Optional>* number_of_stops;

@end
