//
//  MDFPaymentMethod.h
//  MDFPaymentCard
//
//  Created by Sam de Freyssinet on 04/05/2014.
//  Copyright (c) 2014 Maison de Freyssinet. All rights reserved.
//

#ifndef __MDFPaymentMethod__
#define __MDFPaymentMethod__

#import <Foundation/Foundation.h>
#import "MDFPaymentCard.h"
#import "MDFPaymentCardBillingAddress.h"

@protocol MDFPaymentMethod <NSObject>

- (id<MDFPaymentCard>)paymentCard;
- (void)setPaymentCard:(id<MDFPaymentCard>)paymentCard;

- (id<MDFPaymentCardBillingAddress>)paymentCardBillingAddress;
- (void)setPaymentCardBillingAddress:(id<MDFPaymentCardBillingAddress>)paymentCardBillingAddress;

@end

@interface MDFPaymentMethod : NSObject <MDFPaymentMethod>

@property id<MDFPaymentCard> paymentCard;
@property id<MDFPaymentCardBillingAddress> paymentCardBillingAddress;

+ (id<MDFPaymentCard>)paymentCardForLocale:(NSLocale *)locale;
+ (id<MDFPaymentCardBillingAddress>)paymentCardAddressForLocale:(NSLocale *)locale;
+ (id<MDFPaymentMethod>)paymentMethodForLocale:(NSLocale *)locale;

- (id<MDFPaymentMethod>)initWithPaymentCard:(id<MDFPaymentCard>)paymentCard billingAddress:(id<MDFPaymentCardBillingAddress>)billingAddress;

@end

#endif