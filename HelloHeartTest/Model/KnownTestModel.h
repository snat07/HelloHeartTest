//
//  KnownTestModel.h
//  HelloHeartTest
//
//  Created by Sebastian Natalevich on 13/7/17.
//  Copyright © 2017 Sebastian Natalevich. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>

@interface KnownTestModel : JSONModel

@property (nonatomic) int              categoryId;
@property (nonatomic, strong) NSString *knownTestName;

@end
