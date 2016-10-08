//
//  BusViewController.m
//  GoEuro
//
//  Created by lokesh vunnam on 10/7/16.
//  Copyright © 2016 lokesh. All rights reserved.
//

#import "BusViewController.h"
#import "Bus.h"

@interface BusViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray* busses;

@end

@implementation BusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Call WebService
    [self callWebServiceWithURL:[URLs bus]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - HandleResponse

- (void) handleResponceWithData:(NSData *)data {
    
    self.busses = [Bus arrayOfModelsFromData:data error:nil];
    _tableView.delegate = self;
    _tableView.dataSource = self;
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
    if (self.busses.count) {
        
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
    return self.busses.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *strTableIdentifier = @"BusCell";
    
    BusCell *cell = [tableView dequeueReusableCellWithIdentifier:strTableIdentifier];
    
    if (!cell)
    {
        [tableView registerNib:[UINib nibWithNibName:@"BusCell" bundle:nil] forCellReuseIdentifier:strTableIdentifier];
        cell = [tableView dequeueReusableCellWithIdentifier:strTableIdentifier];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    Bus *bus = self.busses[indexPath.row];
    cell.logo.imageUrl = [self handleImageURL:bus.provider_logo];
    cell.timings.text = [NSString stringWithFormat:@"%@ - %@", bus.departure_time, bus.arrival_time];
    cell.cost.text = [NSString stringWithFormat:@"€ %@", bus.price_in_euros];
    cell.journeyHours.text = [NSString stringWithFormat:@"Stops (%@)", bus.number_of_stops];
    
    return cell;
}

@end
