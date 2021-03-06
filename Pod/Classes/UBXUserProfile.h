//
//  UBXUserProfile.h
//  Pods
//
//  Created by Nabib El-RAHMAN on 8/24/14.
//
//

#import <Foundation/Foundation.h>
#import "UBXConnecting.h"

@interface UBXUserProfile : NSObject <UBXConnecting>

@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *picture;
@property (nonatomic, strong) NSString *promoCode;

@end
