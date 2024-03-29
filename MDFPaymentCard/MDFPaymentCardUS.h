//
//  MDFPaymentCardUS.h
//  MDFPaymentCard
//
//  Created by Sam de Freyssinet on 03/05/2014.
//  Copyright (c) 2014 Maison de Freyssinet. All rights reserved.
//

#ifndef __MDFPaymentCardUS__
#define __MDFPaymentCardUS__

#import <Foundation/Foundation.h>
#import "MDFPaymentCard.h"

FOUNDATION_EXPORT NSString *const kMDFPaymentCardUSDescriptionTemplate;

@interface MDFPaymentCardUS : NSObject <MDFPaymentCard>

@property NSString *creditCardNumber;
@property NSString *creditCardVerification;
@property NSUInteger expirationDateMonth;
@property NSUInteger expirationDateYear;
@property NSString *cardHolderName;

+ (MDFPaymentCardUS *)paymentCardWithNumber:(NSString *)cardNumber ccv:(NSString *)ccv expirationMonth:(NSUInteger)expirationMonth expirationYear:(NSUInteger)expirationYear cardHolderName:(NSString *)cardHolderName;

- (BOOL)isEqualToPaymentCard:(id<MDFPaymentCard>)paymentCard;

- (NSUInteger)majorIndustryIdentifier;

@end

#endif