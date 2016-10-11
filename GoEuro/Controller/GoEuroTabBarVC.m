//
//  GoEuroTabBarVC.m
//  GoEuro
//
//  Created by lokesh vunnam on 10/7/16.
//  Copyright © 2016 lokesh. All rights reserved.
//

#import "GoEuroTabBarVC.h"

enum {
    kFlight = 0,
    kBus,
    kTrain
};

@interface GoEuroTabBarVC () <YSLContainerViewControllerDelegate>

@property (nonatomic) NSInteger currentClass;

@end

@implementation GoEuroTabBarVC

const struct TravelStruct TravelBy = {
    .Flight = @"trvelBy_Flight",
    .Train = @"trvelBy_Train",
    .Bus = @"trvelBy_Bus"
};

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
    
    //default class to manage Sorting
    _currentClass = kFlight;

    //Setup Sort Button
    UIBarButtonItem *sortButton = [[UIBarButtonItem alloc] initWithImage:kSortIcon
                                                                   style:UIBarButtonItemStyleBordered
                                                                  target:self
                                                                  action:@selector(toggleSortButton)];
    self.navigationItem.rightBarButtonItem = sortButton;
}

#pragma mark -- YSLContainerViewControllerDelegate

- (void)containerViewItemIndex:(NSInteger)index currentController:(UIViewController *)controller
{
    [controller viewWillAppear:YES];[controller viewWillDisappear:YES];
    
    if ([controller isKindOfClass:[FlightViewController class]])
        _currentClass = kFlight;
    else if ([controller isKindOfClass:[BusViewController class]])
        _currentClass = kBus;
    else if ([controller isKindOfClass:[TrainViewController class]])
        _currentClass = kTrain;
}

#pragma mark - Action

- (void) toggleSortButton {
    //Currently Sorting based on only 'Price'
    switch (_currentClass) {
        case kFlight:
            [[NSNotificationCenter defaultCenter] postNotificationName:TravelBy.Flight object:@"price_in_euros"];
            break;
        case kBus:
            [[NSNotificationCenter defaultCenter] postNotificationName:TravelBy.Bus object:@"price_in_euros"];
            break;
        case kTrain:
            [[NSNotificationCenter defaultCenter] postNotificationName:TravelBy.Train object:@"price_in_euros"];
            break;
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
