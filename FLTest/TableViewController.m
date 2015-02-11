//
//  TableViewController.m
//  Created by Tao Yang on 24/06/14.
//  Copyright (c) 2013 Tao Yang. All rights reserved.//
//

#import "TableViewController.h"
#import "Movie.h"
#import "MovieTableViewCell.h"


@interface TableViewController ()
@property (nonatomic, strong) NSMutableArray *data;
@end

@implementation TableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        self.data = [NSMutableArray new];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.data = [[TMCache sharedCache] objectForKey:FEED_KEY];
    [self.tableView reloadData];
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"MovieCell";
    MovieTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[MovieTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSDictionary *movie = self.data[indexPath.row];
    
    cell.channelLabel.text = movie[@"channel"];
    cell.nameRatingLabel.text = [NSString stringWithFormat:@"%@(%@)",movie[@"name"], movie[@"rating"]];
    cell.timeLabel.text = [NSString stringWithFormat:@"%@ - %@",movie[@"start_time"], movie[@"end_time"]];
    
    return cell;
}

@end
