//
//  TrainViewController.m
//  GoEuro
//
//  Created by lokesh vunnam on 10/7/16.
//  Copyright © 2016 lokesh. All rights reserved.
//

#import "TrainViewController.h"
#import "Trains.h"

@interface TrainViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSArray* trains;

@end

@implementation TrainViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //Add Sorting observer
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sortButtonToggle:) name:TravelBy.Train object:nil];
    
    //Call WebService
    [self callWebServiceWithURL:[URLs train]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action

- (void) sortButtonToggle:(NSNotification *) notification {
    
    SortClass *sorting = [[SortClass alloc] init];
    _trains = [sorting sortTrainsWithArray:_trains sortKey:notification.object];
    [_tableView reloadData];
}

#pragma mark - HandleResponse

- (void) handleResponceWithData:(NSData *)data {
    
    self.trains = [Trains arrayOfModelsFromData:data error:nil];
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
    if (self.trains.count) {
        
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
    return self.trains.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *strTableIdentifier = @"TrainCell";
    
    TrainCell *cell = [tableView dequeueReusableCellWithIdentifier:strTableIdentifier];
    
    if (!cell)
    {
        [tableView registerNib:[UINib nibWithNibName:@"TrainCell" bundle:nil] forCellReuseIdentifier:strTableIdentifier];
        cell = [tableView dequeueReusableCellWithIdentifier:strTableIdentifier];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    Trains *train = self.trains[indexPath.row];
    cell.logo.imageUrl = [self handleImageURL:train.provider_logo];
    cell.timings.text = [NSString stringWithFormat:@"%@ - %@", train.departure_time, train.arrival_time];
    cell.cost.text = [NSString stringWithFormat:@"%@ %@",@"€", train.price_in_euros];
    cell.journeyHours.text = [NSString stringWithFormat:@"Stops (%@)", train.number_of_stops];
    
    return cell;
}

@end
