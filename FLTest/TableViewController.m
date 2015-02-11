//
//  TableViewController.m
//  Created by Tao Yang on 24/06/14.
//  Copyright (c) 2013 Tao Yang. All rights reserved.//
//

#import "TableViewController.h"
#import "Movie.h"
#import "ASIHTTPRequest.h"
#import "JSONKit.h"


@interface TableViewController ()

@property (nonatomic) int maxRequest;
@property (nonatomic) int currentPage;

@end

@implementation TableViewController

@synthesize movies = _movies;
@synthesize maxRequest;
@synthesize currentPage;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    _movies = [[NSMutableArray alloc] init];
    currentPage = 0;
    [self requestMovies:currentPage];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


- (void)requestMovies:(int)page {
    NSString *u = [NSString stringWithFormat:@"%@%d", URL, page];
    NSURL *url = [NSURL URLWithString:u];
    __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
     [request startSynchronous];
    
    NSData *responseData = [request responseData];
    NSDictionary *resultsDictionary = [responseData objectFromJSONData];
    maxRequest = [[resultsDictionary objectForKey:@"count"] intValue];
    
    NSArray *ms = [resultsDictionary objectForKey:@"results"];
    for (NSDictionary *m in ms) {
        NSString *name = [m objectForKey:@"name"];
        NSString *start_time = [m objectForKey:@"start_time"];
        NSString *end_time = [m objectForKey:@"end_time"];
        NSString *channel = [m objectForKey:@"channel"];
        NSString *rating = [m objectForKey:@"rating"];
        
        Movie *movie = [[Movie alloc] init];
        movie.name = name;
        movie.start_time = start_time;
        movie.end_time = end_time;
        movie.channel = channel;
        movie.rating = rating;
        
        [_movies addObject:movie];
        [movie release];
    }
    [self.tableView reloadData];
    
    currentPage ++;
    
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if([_movies count] > 0 && [_movies count] < maxRequest) {
        return [_movies count] + 1;
    }
    return [_movies count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == [_movies count]) {
        
        static NSString *CellIdentifier = @"CellIdentifier";
        
        // Dequeue or create a cell of the appropriate type.
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
            
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UIActivityIndicatorView *spinner = [[[UIActivityIndicatorView alloc]
                                             initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray] autorelease];
        [spinner startAnimating];
        cell.accessoryView = spinner;
        cell.textLabel.numberOfLines = 2;
        cell.textLabel.font = [UIFont boldSystemFontOfSize:16];
		cell.textLabel.textColor = [UIColor colorWithRed:0.353 green:0.353 blue:0.353 alpha:1.0];
        cell.textLabel.text = @"Loading";
        
        return cell;
    } else {
        static NSString *CellIdentifier = @"MovieCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
        Movie *m = [_movies objectAtIndex:indexPath.row];
        UILabel *channelLabel = (UILabel *)[cell viewWithTag:100];
        channelLabel.text = m.channel;
        
        UILabel *nameRatingLabel = (UILabel *)[cell viewWithTag:101];
        nameRatingLabel.text = [NSString stringWithFormat:@"%@(%@)",m.name, m.rating];
        
        UILabel *timeLabel = (UILabel *)[cell viewWithTag:102];
        timeLabel.text = [NSString stringWithFormat:@"%@ - %@",m.start_time, m.end_time];
        
        return cell;
    }
    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *) cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //do another request
    [self requestMovies:currentPage];

}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}

@end
