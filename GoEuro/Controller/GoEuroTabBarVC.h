//
//  GoEuroTabBarVC.h
//  GoEuro
//
//  Created by lokesh vunnam on 10/7/16.
//  Copyright © 2016 lokesh. All rights reserved.
//

#import <UIKit/UIKit.h>

// add __unsafe_unretained if compiling for ARC
struct TravelStruct {
    __unsafe_unretained NSString * const Flight;
    __unsafe_unretained NSString * const Train;
    __unsafe_unretained NSString * const Bus;
};

extern const struct TravelStruct TravelBy;

@interface GoEuroTabBarVC : UIViewController

@end
