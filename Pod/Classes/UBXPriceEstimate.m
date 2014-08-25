//
//  UBXPriceEstimate.m
//  Pods
//
//  Created by Nabib El-RAHMAN on 8/24/14.
//
//

#import "UBXPriceEstimate.h"

@implementation UBXPriceEstimate

+ (NSDictionary *)mapping {
    return @{@"product_id": @"productId",
             @"current_code": @"currentCode",
             @"display_name": @"displayName",
             @"estimate": @"estimate",
             @"low_estimate": @"lowEstimate",
             @"high_estimate": @"highEstimate",
             @"surge_multiplier": @"surgeMultipier"};
}

+ (NSString *)resourceName {
    return @"price";
}

+ (NSString *)resourcePath {
    return @"/v1/estimates/price";
}

@end
