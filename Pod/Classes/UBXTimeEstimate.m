//
//  UBXTimeEstimate.m
//  Pods
//
//  Created by Nabib El-RAHMAN on 8/24/14.
//
//

#import "UBXTimeEstimate.h"

@implementation UBXTimeEstimate

+ (NSDictionary *)mapping {
    return @{@"product_id": @"productId",
             @"display_name": @"displayName",
             @"estimate": @"estimate"};
}

+ (NSString *)resourceName {
    return @"time";
}

+ (NSString *)resourcePath {
    return @"/v1/estimates/time";
}

@end
