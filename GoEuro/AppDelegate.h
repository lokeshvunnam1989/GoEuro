//
//  AppDelegate.h
//  GoEuro
//
//  Created by lokesh vunnam on 10/7/16.
//  Copyright © 2016 lokesh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

+ (AppDelegate *)sharedAppDelegate;

@end

