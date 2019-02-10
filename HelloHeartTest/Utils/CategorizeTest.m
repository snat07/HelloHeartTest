//
//  CategorizeTest.m
//  HelloHeartTest
//
//  Created by Sebastian Natalevich on 13/7/17.
//  Copyright © 2017 Sebastian Natalevich. All rights reserved.
//

#import "CategorizeTest.h"
#import "ModelsHelper.h"
#import "CategoryModel.h"
#import "KnownTestModel.h"
#import "IgnoredWordModel.h"

static NSString *const kCategoryNotFound = @"Category Not Found";

@implementation CategorizeTest

+ (NSString *)categoriesNameForTestName:(NSString *)testName {

    testName = [testName lowercaseString];
    testName = [[self class] removeIngoredWords:testName];
    
    NSArray *categories = [[self class] categoriesIdForTestName:testName];
    
    return [[self class] categoriesNames:categories];
}

+ (NSString *)removeIngoredWords:(NSString *)testName {
    
    NSArray *ignoredWords = [[ModelsHelper sharedInstance] getIgnoredWordsList];
    for (IgnoredWordModel *ignoredWord in ignoredWords) {
        NSRange range = [testName localizedStandardRangeOfString:[ignoredWord.ignoredWord lowercaseString]];
        if (range.location != NSNotFound) {
            testName = [testName stringByReplacingCharactersInRange:range withString:@""];
        }
    }
    
    return [testName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

+ (NSArray *)categoriesIdForTestName:(NSString *)testName {
    NSArray *knownTestNames = [[ModelsHelper sharedInstance] getKnownTestList];
    NSArray *words = [testName componentsSeparatedByString:@" "];
    NSMutableArray *categories = [[NSMutableArray alloc] init];
    for (KnownTestModel *knownTestModel in knownTestNames) {
        for (NSString *word in words) {
            if ([[knownTestModel.knownTestName lowercaseString] containsString:word] && ![categories containsObject:[NSNumber numberWithInt:knownTestModel.categoryId]]) {
                [categories addObject:[NSNumber numberWithInt:knownTestModel.categoryId]];
                break;
            }
        }
    }
    
    return [categories copy];
}

+ (NSString *)categoriesNames:(NSArray *)categories {
    
    NSString *categoriesName = @"";
    if(categories.count > 0) {
        for (NSNumber *i in categories) {
            categoriesName = [NSString stringWithFormat:@"%@, %@", [[self class] categoryName:[i intValue]], categoriesName];
        }
        categoriesName = [categoriesName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        categoriesName = [categoriesName substringToIndex:categoriesName.length - 1];
    }
    
    return ![categoriesName isEqualToString:@""] ? categoriesName : kCategoryNotFound;
}

+ (NSString *)categoryName:(int)categoryId {
    NSString *categoryName = @"";
    NSArray *categories = [[ModelsHelper sharedInstance] getCategoriesList];
    for (CategoryModel *categoryModel in categories) {
        if (categoryModel.categoryId == categoryId) {
            categoryName = categoryModel.name;
            break;
        }
    }
    return categoryName;
}
@end
