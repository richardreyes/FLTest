//
//  Movie.h
//  Created by Tao Yang on 24/06/14.
//  Copyright (c) 2013 Tao Yang. All rights reserved.//

#import <Foundation/Foundation.h>

@interface Movie : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *start_time;
@property (nonatomic, copy) NSString *end_time;
@property (nonatomic, copy) NSString *channel;
@property (nonatomic, copy) NSString *rating;

@end
