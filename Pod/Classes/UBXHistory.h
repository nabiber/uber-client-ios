//
//  UBXHistory.h
//  Pods
//
//  Created by Nabib El-RAHMAN on 8/24/14.
//
//

#import <Foundation/Foundation.h>

@interface UBXHistory : NSObject

@property (nonatomic, assign) int offset;
@property (nonatomic, assign) int limit;
@property (nonatomic, assign) int count;
@property (nonatomic, strong) NSDictionary *history;

@end
