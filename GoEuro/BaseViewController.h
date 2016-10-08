//
//  BaseViewController.h
//  GoEuro
//
//  Created by lokesh vunnam on 10/8/16.
//  Copyright © 2016 lokesh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

@property (nonatomic) BOOL hasInternet;

- (void) callWebServiceWithURL:(NSString*)url;

- (void) handleResponceWithData:(NSData *)data;

- (NSString *) handleImageURL:(NSString *)url;

- (void)displayTableViewMessage:(NSString *)message onTableView:(UITableView *)tableView;

@end
