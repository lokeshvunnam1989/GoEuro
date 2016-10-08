//
//  TrainCell.m
//  GoEuro
//
//  Created by lokesh vunnam on 10/7/16.
//  Copyright © 2016 lokesh. All rights reserved.
//

#import "TrainCell.h"

@implementation TrainCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)prepareForReuse {
    [super prepareForReuse];
    self.logo.imageUrl = nil;
}

@end
