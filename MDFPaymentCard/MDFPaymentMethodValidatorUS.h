//
//  MDFPaymentMethodValidatorUS.h
//  MDFPaymentCard
//
//  Created by Sam de Freyssinet on 04/05/2014.
//  Copyright (c) 2014 Maison de Freyssinet. All rights reserved.
//

#ifndef __MDFPaymentMethodValidatorUS__
#define __MDFPaymentMethodValidatorUS__

FOUNDATION_EXPORT NSString * const MDFPaymentMethodValidatorUSErrorDomain;
FOUNDATION_EXPORT NSUInteger const MDFPaymentMethodValidatorUSErrorCode;

#import <Foundation/Foundation.h>
#import "MDFPaymentMethodValidator.h"

@interface MDFPaymentMethodValidatorUS : NSObject <MDFPaymentMethodValidator>

@property (weak) MDFPaymentMethod *paymentMethod;

- (id)initWithPaymentMethod:(id<MDFPaymentMethod>)paymentMethod;

- (BOOL)isValidPaymentMethod:(MDFPaymentMethodValidateOptions)options error:(NSError **)error;

- (BOOL)isValidPaymentMethodCheckBasic:(NSError **)error;
- (BOOL)isValidPaymentMethodCheckFull:(NSError **)error;

- (BOOL)isValidLuhnChecksum:(NSError **)error;

@end

#endif