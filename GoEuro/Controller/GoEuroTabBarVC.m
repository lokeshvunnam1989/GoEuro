//
//  GoEuroTabBarVC.m
//  GoEuro
//
//  Created by lokesh vunnam on 10/7/16.
//  Copyright © 2016 lokesh. All rights reserved.
//

#import "GoEuroTabBarVC.h"

@interface GoEuroTabBarVC () <YSLContainerViewControllerDelegate>

@end

@implementation GoEuroTabBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Go Euro";
    // SetUp ViewControllers
    FlightViewController *flightVC = [[FlightViewController alloc]initWithNibName:@"FlightViewController" bundle:nil];
    flightVC.title = @"FLIGHT";

    TrainViewController *trainVC = [[TrainViewController alloc]initWithNibName:@"TrainViewController" bundle:nil];
    trainVC.title = @"TRAIN";
    
    BusViewController *busVC = [[BusViewController alloc]initWithNibName:@"BusViewController" bundle:nil];
    busVC.title = @"BUS";
    
    
    // ContainerView
    YSLContainerViewController *containerVC = [[YSLContainerViewController alloc]initWithControllers:@[flightVC,busVC,trainVC]
                                                                                        topBarHeight:STATUS_HEIGHT + NAVIG_HEIGHT
                                                                                parentViewController:self];
    containerVC.delegate = self;
    containerVC.menuItemFont = [UIFont fontWithName:@"Futura-Medium" size:16];
    
    [self.view addSubview:containerVC.view];
}

#pragma mark -- YSLContainerViewControllerDelegate

- (void)containerViewItemIndex:(NSInteger)index currentController:(UIViewController *)controller
{
    [controller viewWillAppear:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
