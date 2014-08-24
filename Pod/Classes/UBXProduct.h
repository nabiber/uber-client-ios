//
//  UBXProduct.h
//  Pods
//
//  Created by Nabib El-RAHMAN on 8/24/14.
//
//

#import <Foundation/Foundation.h>

@interface UBXProduct : NSObject

@property (nonatomic, strong) NSString *productId;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSString *displayName;
@property (nonatomic, strong) NSURL *image;
@property (nonatomic, assign) int capacity;

@end
