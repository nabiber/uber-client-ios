//
//  UBXPriceEstimate.h
//  Pods
//
//  Created by Nabib El-RAHMAN on 8/24/14.
//
//

#import <Foundation/Foundation.h>
#import "UBXConnecting.h"

@interface UBXPriceEstimate : NSObject <UBXConnecting>

@property (nonatomic, strong) NSString *productId;
@property (nonatomic, strong) NSString *currentCode;
@property (nonatomic, strong) NSString *displayName;
@property (nonatomic, strong) NSString *estimate;
@property (nonatomic, assign) NSNumber *lowEstimate;
@property (nonatomic, assign) NSNumber *highEstimate;
@property (nonatomic, assign) NSNumber *surgeMultipier;

@end
