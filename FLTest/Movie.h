//
//  Movie.h
//  Created by Tao Yang on 24/06/14.
//  Copyright (c) 2013 Tao Yang. All rights reserved.//

#import <Foundation/Foundation.h>

@interface Movie : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *start_time;
@property (nonatomic, strong) NSString *end_time;
@property (nonatomic, strong) NSString *channel;
@property (nonatomic, strong) NSString *rating;

@end
