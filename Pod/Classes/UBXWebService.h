//
//  UBXWebService.h
//  Pods
//
//  Created by Sahel Jalal on 8/24/14.
//
//

#import <UIKit/UIKit.h>

@class UBXHistory, UBXUserProfile;

@interface UBXWebService : UIViewController

- (NSArray *)products;
- (NSArray *)priceEstimates;
- (NSArray *)timeEstimates;
- (UBXHistory *)history;
- (UBXUserProfile *)userProfile;

- (void)productsWithSuccess:(void (^)(NSArray *resources))success failure:(void (^)(NSError *error))failure;
- (void)priceEstimatesWithSuccess:(void (^)(NSArray *resources))success failure:(void (^)(NSError *error))failure;
- (void)timeEstimatesWithSuccess:(void (^)(NSArray *resources))success failure:(void (^)(NSError *error))failure;
- (void)historyWithSuccess:(void (^)(UBXHistory *resource))success failure:(void (^)(NSError *error))failure;
- (void)userProfileWithSuccess:(void (^)(UBXUserProfile *resource))success failure:(void (^)(NSError *error))failure;

@end
