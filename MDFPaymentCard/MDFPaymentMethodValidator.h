//
//  MDFPaymentMethodValidator.h
//  MDFPaymentCard
//
//  Created by Sam de Freyssinet on 04/05/2014.
//  Copyright (c) 2014 Maison de Freyssinet. All rights reserved.
//

#ifndef __MDFPaymentMethodValidator__
#define __MDFPaymentMethodValidator__

#import <Foundation/Foundation.h>
#import "MDFPaymentMethod.h"

typedef NS_ENUM(NSUInteger, MDFPaymentMethodValidateOptions)
{
    MDFPaymentMethodValidateOptionsCardHolderName         = 1 << 0,
    MDFPaymentMethodValidateOptionsCardNumber             = 1 << 1,
    MDFPaymentMethodValidateOptionsCardCCV                = 1 << 2,
    MDFPaymentMethodValidateOptionsExpirationDate         = 1 << 3,
    MDFPaymentMethodValidateOptionsBillingPostalCode      = 1 << 4,
    MDFPaymentMethodValidateOptionsBillingStreetAddress   = 1 << 5,
    MDFPaymentMethodValidateOptionsBillingCityName        = 1 << 6,
    MDFPaymentMethodValidateOptionsBillingStateName       = 1 << 7,
    MDFPaymentMethodValidateOptionsBillingUnitAddress     = 1 << 8,
    MDFPaymentMethodValidateOptionsBillingCountryName     = 1 << 9,
    MDFPaymentMethodValidateOptionsBillingCompanyName     = 1 << 10,
    MDFPaymentMethodValidateOptionsBillingName            = 1 << 11,
    MDFPaymentMethodValidateOptionsCardLuhnChecksum       = 1 << 12
};

@protocol MDFPaymentMethodValidator <NSObject>

- (BOOL)isValidPaymentMethod:(MDFPaymentMethodValidateOptions)options error:(NSError **)error;
- (BOOL)isValidPaymentMethodCheckBasic:(NSError **)error;
- (BOOL)isValidPaymentMethodCheckFull:(NSError **)error;

- (BOOL)isValidLuhnChecksum:(NSError **)error;

@end

#endif