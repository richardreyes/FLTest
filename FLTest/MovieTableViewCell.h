//
//  MovieTableViewCell.h
//  FLTest
//
//  Created by iOS dev on 11/02/2015.
//  Copyright (c) 2015 FreeLancer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *channelLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameRatingLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@end
