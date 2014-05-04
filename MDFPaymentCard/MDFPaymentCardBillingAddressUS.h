//
//  MSFPaymentCardBillingAddressUS.h
//  MDFPaymentCard
//
//  Created by Sam de Freyssinet on 04/05/2014.
//  Copyright (c) 2014 Maison de Freyssinet. All rights reserved.
//

#ifndef __MDFPaymentCardBillingAddressUS__
#define __MDFPaymentCardBillingAddressUS__

#import <Foundation/Foundation.h>
#import "MDFPaymentCardBillingAddress.h"

@interface MDFPaymentCardBillingAddressUS : NSObject <MDFPaymentCardBillingAddress>

@property NSString *billingName;
@property NSString *companyName;
@property NSString *streetAddress;
@property NSString *unitAddress;
@property NSString *city;
@property NSString *stateName;
@property NSString *postalCode;
@property NSString *countryName;

+ (MDFPaymentCardBillingAddressUS *)billingAddressWithBillingName:(NSString *)billingName streetAddress:(NSString *)streetAddress postalCode:(NSString *)postalCode;

- (id)initWithLocale:(NSLocale *)localeOrNil;

@end

#endif