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

#define WEB_SERVICE_TIMEOUT 60

NSString * const UBXErrorDomainWebService = @"UBXWebServiceErrorDomain";

const int UBXErrorCodeTimeout = 1;

@implementation UBXWebService

- (instancetype)init {
    self = [super init];
    if (self) {
        // Custom initialization
        [self _configureRestKit];
    }
    return self;
}

- (void)_configureRestKit {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
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
    });
}

- (id)_getResource:(NSString *)resource error:(NSError **)error {
    __block id data = nil;
    dispatch_semaphore_t dsema = dispatch_semaphore_create(0);
    [self _getResource:resource success:^(id resources) {
        data = resources;
        dispatch_semaphore_signal(dsema);
    } failures:^(NSError *error) {
        if (error) {
            error = error;
        }
    }];
    
    if (dispatch_semaphore_wait(dsema, dispatch_time(DISPATCH_TIME_NOW, WEB_SERVICE_TIMEOUT * NSEC_PER_SEC))) {
        // Timeout occurred
        if (error) {
            NSDictionary *userInfo = @{NSLocalizedDescriptionKey: NSLocalizedString(@"Operation was unsuccessful.", nil),
                                       NSLocalizedFailureReasonErrorKey: NSLocalizedString(@"The operation timed out.", nil),
                                       NSLocalizedRecoverySuggestionErrorKey: NSLocalizedString(@"Have you tried turning it off and on again?", nil)};
            *error = [NSError errorWithDomain:UBXErrorDomainWebService
                                        code:UBXErrorCodeTimeout
                                    userInfo:userInfo];
        }
    }
    
    return data;
}

- (NSArray *)getProducts:(NSError **)error {
    return [self _getResource:[UBXProduct resourcePath] error:error];
}

- (NSArray *)getPriceEstimates:(NSError **)error {
    return [self _getResource:[UBXPriceEstimate resourcePath] error:error];
}

- (NSArray *)getTimeEstimates:(NSError **)error {
    return [self _getResource:[UBXTimeEstimate resourcePath] error:error];
}

- (UBXHistory *)getHistory:(NSError **)error {
    return [self _getResource:[UBXHistory resourcePath] error:error];
}

- (UBXUserProfile *)getUserProfile:(NSError **)error {
    return [self _getResource:[UBXUserProfile resourcePath] error:error];
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

- (void)getProductsWithSuccess:(void (^)(NSArray *resources))success failure:(void (^)(NSError *error))failure {
    [self _getResource:[UBXProduct resourcePath] success:success failures:failure];
}

- (void)getPriceEstimatesWithSuccess:(void (^)(NSArray *resources))success failure:(void (^)(NSError *error))failure {
    [self _getResource:[UBXPriceEstimate resourcePath] success:success failures:failure];
}

- (void)getTimeEstimatesWithSuccess:(void (^)(NSArray *resources))success failure:(void (^)(NSError *error))failure {
    [self _getResource:[UBXTimeEstimate resourcePath] success:success failures:failure];
}

- (void)getHistoryWithSuccess:(void (^)(UBXHistory *resource))success failure:(void (^)(NSError *error))failure {
    [self _getResource:[UBXHistory resourcePath] success:success failures:failure];
}

- (void)getUserProfileWithSuccess:(void (^)(UBXUserProfile *resource))success failure:(void (^)(NSError *error))failure {
    [self _getResource:[UBXUserProfile resourcePath] success:success failures:failure];
}

@end
