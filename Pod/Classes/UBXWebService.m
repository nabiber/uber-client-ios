//
//  UBXWebService.m
//  Pods
//
//  Created by Sayeem Hussain on 8/24/14.
//
//

#import "UBXWebService.h"
#import "UBXProduct.h"
#import "UBXPriceEstimate.h"
#import "UBXTimeEstimate.h"
#import "UBXHistory.h"
#import "UBXUserProfile.h"
#import "UBXConnecting.h"
#import "RestKit.h"

@implementation UBXWebService {
    BOOL _restKitInitialized;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)_configureRestKit {
    if (!_restKitInitialized) {
        // Initialize AFNetworking HTTPClient
        NSURL *baseURL = [NSURL URLWithString:@"https://api.uber.com"];
        AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:baseURL];
        
        // Initialize RestKit
        RKObjectManager *objectManager = [[RKObjectManager alloc] initWithHTTPClient:client];
        
        // Setup object mappings
        for (NSString *cls in @[@"UBXProduct", @"UBXPriceEstimate", @"UBXTimeEstimate", @"UBXHistory", @"UBXUserProfile"]) {
            // Create a dummy instance and get the mapping
            Class c = NSClassFromString(cls);
            RKObjectMapping *mapping = [RKObjectMapping mappingForClass:c];
            [mapping addAttributeMappingsFromDictionary:[c performSelector:@selector(mapping)]];
            
            // Register mappings with the provider using a response descriptor
            RKResponseDescriptor *responseDescriptor =
            [RKResponseDescriptor responseDescriptorWithMapping:mapping
                                                         method:RKRequestMethodGET
                                                    pathPattern:[c performSelector:@selector(resourcePath)]
                                                        keyPath:[NSString stringWithFormat:@"response.%@", [c performSelector:@selector(resourceName)]]
                                                    statusCodes:[NSIndexSet indexSetWithIndex:200]];
            [objectManager addResponseDescriptor:responseDescriptor];
        }
        _restKitInitialized = YES;
    }
}

- (id)_getResource:(NSString *)resource {
    __block id data = nil;
    dispatch_semaphore_t dsema = dispatch_semaphore_create(0);
    [self _getResource:resource success:^(id resources) {
        data = resources;
        dispatch_semaphore_signal(dsema);
    } failures:nil];
    dispatch_semaphore_wait(dsema, DISPATCH_TIME_FOREVER);
    
    return data;
}

- (NSArray *)products {
    return [self _getResource:[UBXProduct resourcePath]];
}

- (NSArray *)priceEstimates {
    return [self _getResource:[UBXPriceEstimate resourcePath]];
}

- (NSArray *)timeEstimates {
    return [self _getResource:[UBXTimeEstimate resourcePath]];
}

- (UBXHistory *)history {
    return [self _getResource:[UBXHistory resourcePath]];
}

- (UBXUserProfile *)userProfile {
    return [self _getResource:[UBXUserProfile resourcePath]];
}

- (void)_getResource:(NSString *)resource success:(void (^)(id resources))success failures:(void (^)(NSError *error))failure {
    if (!success) {
        return;
    }
    
    [[RKObjectManager sharedManager] getObjectsAtPath:resource parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        success(mappingResult.array);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

- (void)productsWithSuccess:(void (^)(NSArray *resources))success failure:(void (^)(NSError *error))failure {
    [self _getResource:[UBXProduct resourcePath] success:success failures:failure];
}

- (void)priceEstimatesWithSuccess:(void (^)(NSArray *resources))success failure:(void (^)(NSError *error))failure {
    [self _getResource:[UBXPriceEstimate resourcePath] success:success failures:failure];
}

- (void)timeEstimatesWithSuccess:(void (^)(NSArray *resources))success failure:(void (^)(NSError *error))failure {
    [self _getResource:[UBXTimeEstimate resourcePath] success:success failures:failure];
}

- (void)historyWithSuccess:(void (^)(UBXHistory *resource))success failure:(void (^)(NSError *error))failure {
    [self _getResource:[UBXHistory resourcePath] success:success failures:failure];
}

- (void)userProfileWithSuccess:(void (^)(UBXUserProfile *resource))success failure:(void (^)(NSError *error))failure {
    [self _getResource:[UBXUserProfile resourcePath] success:success failures:failure];
}

@end
