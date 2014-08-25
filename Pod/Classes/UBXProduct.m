//
//  UBXProduct.m
//  Pods
//
//  Created by Nabib El-RAHMAN on 8/24/14.
//
//

#import "UBXProduct.h"

@implementation UBXProduct

+ (NSDictionary *)mapping {
    return @{@"product_id": @"product_id",
             @"description": @"desc",
             @"display_name": @"displayName",
             @"image": @"image",
             @"capacity": @"capacity"};
}

+ (NSString *)resourceName {
    return @"products";
}

+ (NSString *)resourcePath {
    return @"/v1/products";
}

@end
