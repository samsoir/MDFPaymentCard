//
//  MDFPaymentCardBillingAddress.h
//  MDFPaymentCard
//
//  Created by Sam de Freyssinet on 04/05/2014.
//  Copyright (c) 2014 Maison de Freyssinet. All rights reserved.
//

#ifndef __MDFPaymentCardBillingAddress__
#define __MDFPaymentCardBillingAddress__

#import <Foundation/Foundation.h>

@protocol MDFPaymentCardBillingAddress <NSObject>

- (NSString *)billingName;
- (void)setBillingName:(NSString *)billingName;

- (NSString *)city;
- (void)setCity:(NSString *)city;

- (NSString *)countryName;
- (void)setCountryName:(NSString *)countryName;

@optional

- (NSString *)streetAddress;
- (void)setStreetAddress:(NSString *)streetAddress;

- (NSString *)postalCode;
- (void)setPostalCode:(NSString *)postalCode;

- (NSString *)stateName;
- (void)setStateName:(NSString *)stateName;

- (NSString *)companyName;
- (void)setCompanyName:(NSString *)companyName;

- (NSString *)unitAddress;
- (void)setUnitAddress:(NSString *)unitAddress;

@end

#endif