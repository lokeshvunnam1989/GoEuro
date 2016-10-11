//
//  FlightViewController.m
//  GoEuro
//
//  Created by lokesh vunnam on 10/7/16.
//  Copyright © 2016 lokesh. All rights reserved.
//

#import "FlightViewController.h"
@class SortClass;

@interface FlightViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray* flights;

@end

@implementation FlightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Add Sorting observer
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sortButtonToggle:) name:TravelBy.Flight object:nil];

    //Call WebService
    [self callWebServiceWithURL:[URLs flight]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Action

- (void) sortButtonToggle:(NSNotification *) notification {

    SortClass *sorting = [[SortClass alloc] init];
    _flights = [sorting sortFlightsWithArray:_flights sortKey:notification.object];
    [_tableView reloadData];
}

#pragma mark - HandleResponse

- (void) handleResponceWithData:(NSData *)data {
    //handle data here
    self.flights = [Flight arrayOfModelsFromData:data error:nil];
    [_tableView reloadData];
}

#pragma mark - UITableView Delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - UITableView DataSource methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    if (self.flights.count) {
        
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        return 1;
        
    } else {
        
        // Display a message when the table is empty
        if (self.hasInternet)
            [self displayTableViewMessage:@"Please Wait..."
                              onTableView:self.tableView];
        else
            [self displayTableViewMessage:@"No data is currently available. Please check your internet connectivity"
                              onTableView:self.tableView];
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.flights.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *strTableIdentifier = @"FlightCell";
    
    FlightCell *cell = [tableView dequeueReusableCellWithIdentifier:strTableIdentifier];
    
    if (!cell)
    {
        [tableView registerNib:[UINib nibWithNibName:@"FlightCell" bundle:nil] forCellReuseIdentifier:strTableIdentifier];
        cell = [tableView dequeueReusableCellWithIdentifier:strTableIdentifier];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    Flight *flight = self.flights[indexPath.row];
    cell.logo.imageUrl = [self handleImageURL:flight.provider_logo];
    cell.timings.text = [NSString stringWithFormat:@"%@ - %@", flight.departure_time, flight.arrival_time];
    cell.cost.text = [NSString stringWithFormat:@"€ %@", flight.price_in_euros];
    cell.journeyHours.text = [NSString stringWithFormat:@"Stops (%@)", flight.number_of_stops];
    
    return cell;
}

@end
