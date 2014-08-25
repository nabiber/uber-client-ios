//
//  UBXWebService.h
//  Pods
//
//  Created by Sayeem Hussain on 8/24/14.
//
//

#import <UIKit/UIKit.h>

// Error domain

extern NSString * const UBXErrorDomainWebService;

// Error codes

extern const int UBXErrorCodeTimeout;

@class UBXHistory, UBXUserProfile;

@interface UBXWebService : UIViewController

// Synchronous methods

- (NSArray *)getProducts:(NSError **)error;
- (NSArray *)getPriceEstimates:(NSError **)error;
- (NSArray *)getTimeEstimates:(NSError **)error;
- (UBXHistory *)getHistory:(NSError **)error;
- (UBXUserProfile *)getUserProfile:(NSError **)error;

// Aynchronous methods

- (void)getProductsWithSuccess:(void (^)(NSArray *resources))success failure:(void (^)(NSError *error))failure;
- (void)getPriceEstimatesWithSuccess:(void (^)(NSArray *resources))success failure:(void (^)(NSError *error))failure;
- (void)getTimeEstimatesWithSuccess:(void (^)(NSArray *resources))success failure:(void (^)(NSError *error))failure;
- (void)getHistoryWithSuccess:(void (^)(UBXHistory *resource))success failure:(void (^)(NSError *error))failure;
- (void)getUserProfileWithSuccess:(void (^)(UBXUserProfile *resource))success failure:(void (^)(NSError *error))failure;

@end
