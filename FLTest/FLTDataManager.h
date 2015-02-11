//
//  FLTDataManager.h
//  FLTest
//
//  Created by iOS dev on 11/02/2015.
//  Copyright (c) 2015 FreeLancer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FLTDataManager : NSObject
+ (instancetype) sharedInstance;

-(void) getFeeds;
@end
