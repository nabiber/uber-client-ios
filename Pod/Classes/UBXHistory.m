//
//  UBXHistory.m
//  Pods
//
//  Created by Nabib El-RAHMAN on 8/24/14.
//
//

#import "UBXHistory.h"

@implementation UBXHistory

+ (NSDictionary *)mapping {
    return @{@"offset": @"offset",
             @"limit": @"limit",
             @"count": @"count",
             @"history": @"history"};
}

+ (NSString *)resourceName {
    return @"history";
}

+ (NSString *)resourcePath {
    return @"/v1/history";
}

@end
