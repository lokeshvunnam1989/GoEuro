//
//  FlightCell.h
//  GoEuro
//
//  Created by lokesh vunnam on 10/8/16.
//  Copyright © 2016 lokesh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FlightCell : UITableViewCell

@property (weak, nonatomic) IBOutlet EMAsyncImageView *logo;
@property (weak, nonatomic) IBOutlet UILabel *timings;
@property (weak, nonatomic) IBOutlet UILabel *journeyHours;
@property (weak, nonatomic) IBOutlet UILabel *cost;

@end
