//
//  FLTDataManager.m
//  FLTest
//
//  Created by iOS dev on 11/02/2015.
//  Copyright (c) 2015 FreeLancer. All rights reserved.
//

#import "FLTDataManager.h"

@interface FLTDataManager()
@property (nonatomic) int pageToRetrieve;
@property (nonatomic) int totalNumberOfPages;
@end

@implementation FLTDataManager



+ (instancetype) sharedInstance
{
    // 1
    static FLTDataManager *_sharedInstance = nil;
    
    // 2
    static dispatch_once_t oncePredicate;
    
    // 3
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [FLTDataManager new];
    });
    
    
    return _sharedInstance;
}

-(void) getFeeds
{
    [FLTDataManager cancelPreviousPerformRequestsWithTarget:self];
    NSString *urlsString = @"";
    
    if (self.pageToRetrieve == 0) {
        urlsString = [NSString stringWithFormat:@"%@0", URL];
    } else {
        urlsString = [NSString stringWithFormat:@"%@%i", URL, self.pageToRetrieve];
    }
    self.pageToRetrieve += 1 ;
    
    NSLog(@"retrieving page %i", self.pageToRetrieve);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:urlsString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"JSON: %@", responseObject);
        
        NSMutableArray *results = responseObject[@"results"];
        NSNumber *count = responseObject[@"count"];
        
        if (self.pageToRetrieve == 1) {
            self.totalNumberOfPages = [count intValue];
            NSLog(@"");
        }
        
        if (results && [results count] > 0) {
            NSMutableArray *oldResults = [[TMCache sharedCache] objectForKey:FEED_KEY];
            
            if (oldResults && [oldResults count] > 0) {
                NSMutableArray *modifiedOldResults = [NSMutableArray new];
                [modifiedOldResults addObjectsFromArray:oldResults];
                [modifiedOldResults addObjectsFromArray:results];
                
                [[TMCache sharedCache] setObject:modifiedOldResults forKey:FEED_KEY block:nil];
                
                
                
            } else {
                [[TMCache sharedCache] setObject:results forKey:FEED_KEY block:nil];
            }
            
            oldResults = results = nil;
            
            
            dispatch_queue_t myQueue = dispatch_queue_create("Feed Queue",NULL);
            dispatch_async(myQueue, ^{
                // Perform long running process
                
                [self performSelector:@selector(getFeeds) withObject:nil afterDelay:2];
                
                //            dispatch_async(dispatch_get_main_queue(), ^{
                //                // Update the UI
                //                
                //            });
            });
        }
        

        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

@end
