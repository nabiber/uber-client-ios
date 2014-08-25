//
//  UBXHistory.h
//  Pods
//
//  Created by Nabib El-RAHMAN on 8/24/14.
//
//

#import <Foundation/Foundation.h>
#import "UBXConnecting.h"

@interface UBXHistory : NSObject <UBXConnecting>

@property (nonatomic, assign) NSNumber *offset;
@property (nonatomic, assign) NSNumber *limit;
@property (nonatomic, assign) NSNumber *count;
@property (nonatomic, strong) NSDictionary *history;

@end
