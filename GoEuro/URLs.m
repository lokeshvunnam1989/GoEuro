//
//  URLs.m
//  GoEuro
//
//  Created by lokesh vunnam on 10/8/16.
//  Copyright © 2016 lokesh. All rights reserved.
//

#import "URLs.h"

@implementation URLs

#define BASE_URL @"https://api.myjson.com/bins/"

+(NSString *)train {
    return BASE_URL @"3zmcy";
}

+(NSString *)bus {
    return BASE_URL @"37yzm";
}

+(NSString *)flight {
    return BASE_URL @"w60i";
}

@end
