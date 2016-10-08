//
//  BaseViewController.m
//  GoEuro
//
//  Created by lokesh vunnam on 10/8/16.
//  Copyright © 2016 lokesh. All rights reserved.
//

#import "BaseViewController.h"
#import "Reachability.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Check internet connection
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable) {
        NSLog(@"There IS NO internet connection");
        self.hasInternet = NO;
    } else {
        NSLog(@"There IS internet connection");
        self.hasInternet = YES;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - NSURLSession Request
-(void) callWebServiceWithURL:(NSString*)url {
    
    if (self.hasInternet) {
        NSURL* jokesUrl = [NSURL URLWithString:url];
        
        [[[NSURLSession sharedSession] dataTaskWithURL:jokesUrl completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self handleResponceWithData:data];
            });
        }] resume];
    }
}

- (NSString *) handleImageURL:(NSString *)url {
    return [url stringByReplacingOccurrencesOfString:@"{size}"
                                          withString:@"63"];
}

- (void)displayTableViewMessage:(NSString *)message onTableView:(UITableView *)tableView {
    // Display a message when the table is empty
    UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    
    messageLabel.text = message;
    messageLabel.textColor = [UIColor blackColor];
    messageLabel.numberOfLines = 0;
    messageLabel.textAlignment = NSTextAlignmentCenter;
    messageLabel.font = [UIFont fontWithName:@"Palatino-Italic" size:20];
    [messageLabel sizeToFit];
    
    tableView.backgroundView = messageLabel;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

@end
