//
//  UBXTimeEstimate.h
//  Pods
//
//  Created by Nabib El-RAHMAN on 8/24/14.
//
//

#import <Foundation/Foundation.h>
#import "UBXConnecting.h"

@interface UBXTimeEstimate : NSObject <UBXConnecting>

@property (nonatomic, strong) NSString *productId;
@property (nonatomic, assign) NSNumber *displayName;
@property (nonatomic, assign) NSNumber *estimate;

@end
