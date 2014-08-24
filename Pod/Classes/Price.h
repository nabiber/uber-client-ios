//
//  Price.h
//  Pods
//
//  Created by Nabib El-RAHMAN on 8/24/14.
//
//

#import <Foundation/Foundation.h>

@interface Price : NSObject

@property (nonatomic, strong) NSString *productId;
@property (nonatomic, strong) NSString *currentCode;
@property (nonatomic, strong) NSString *displayName;
@property (nonatomic, strong) NSString *estimate;
@property (nonatomic, assign) int lowEstimate;
@property (nonatomic, assign) int highEstimate;
@property (nonatomic, assign) float surgeMultipier;

@end
