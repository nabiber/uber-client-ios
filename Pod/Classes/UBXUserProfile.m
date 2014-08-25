//
//  UBXUserProfile.m
//  Pods
//
//  Created by Nabib El-RAHMAN on 8/24/14.
//
//

#import "UBXUserProfile.h"

@implementation UBXUserProfile

+ (NSDictionary *)mapping {
    return @{@"first_name": @"firstName",
             @"last_name": @"lastName",
             @"email": @"email",
             @"picture": @"picture",
             @"promo_code": @"promoCode"};
}

+ (NSString *)resourceName {
    return @"user";
}

+ (NSString *)resourcePath {
    return @"/v1/me";
}

@end
