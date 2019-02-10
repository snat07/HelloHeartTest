//
//  ModelsHelper
//  HelloHeartTest
//
//  Created by Sebastian Natalevich on 13/7/17.
//  Copyright © 2017 Sebastian Natalevich. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ModelsHelper : NSObject

+ (instancetype)sharedInstance;

- (NSArray *)getCategoriesList;
- (NSArray *)getIgnoredWordsList;
- (NSArray *)getKnownTestList;

@end
