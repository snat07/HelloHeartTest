//
//  ModelsCreator.m
//  HelloHeartTest
//
//  Created by Sebastian Natalevich on 13/7/17.
//  Copyright © 2017 Sebastian Natalevich. All rights reserved.
//

#import "ModelsHelper.h"
#import "CategoryModel.h"
#import "IgnoredWordModel.h"
#import "KnownTestModel.h"

static NSString *const kCategories     = @"Categories";
static NSString *const kIngoredWords   = @"IgnoredWords";
static NSString *const kKnownTestNames = @"KnownTestNames";
static NSString *const kFileType       = @"json";

@interface ModelsHelper ()

@property (nonatomic, strong) NSArray *categoriesList;
@property (nonatomic, strong) NSArray *knownTestsList;
@property (nonatomic, strong) NSArray *ignoredWordsList;

@end

@implementation ModelsHelper

+ (instancetype)sharedInstance {
    
    static ModelsHelper *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (NSArray *)getCategoriesList {
    if (!self.categoriesList) {
        self.categoriesList = [self createModel:kCategories class:[CategoryModel class]];
    }
    return self.categoriesList;
}

- (NSArray *)getIgnoredWordsList {
    if (!self.ignoredWordsList) {
        self.ignoredWordsList = [self createModel:kIngoredWords class:[IgnoredWordModel class]];
    }
    return self.ignoredWordsList;
}

- (NSArray *)getKnownTestList {
    if (!self.knownTestsList) {
        self.knownTestsList = [self createModel:kKnownTestNames class:[KnownTestModel class]];
    }
    return self.knownTestsList;
}

- (NSArray *)createModel:(NSString *)key class:(Class)class {
    NSError *error;
    NSDictionary *fileData = [self readFile:key];
    NSArray *fileArray = fileData[key];
    NSMutableArray *results= [class arrayOfModelsFromDictionaries:fileArray error:&error];
    
    return [results copy];
}

- (NSDictionary *)readFile:(NSString *)fileName {

    NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:kFileType];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    NSDictionary *fileData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    return fileData;
}




@end
