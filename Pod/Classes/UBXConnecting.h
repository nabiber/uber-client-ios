//
//  UBXConnecting.h
//  Pods
//
//  Created by Sahel Jalal on 8/24/14.
//
//

#ifndef Pods_UBXConnecting_h
#define Pods_UBXConnecting_h

@protocol UBXConnecting <NSObject>

+ (NSDictionary *)mapping;
+ (NSString *)resourceName;
+ (NSString *)resourcePath;

@end

#endif
