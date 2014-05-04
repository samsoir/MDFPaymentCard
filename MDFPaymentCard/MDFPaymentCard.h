//
//  MDFPaymentCard.h
//  MDFPaymentCard
//
//  Created by Sam de Freyssinet on 03/05/2014.
//  Copyright (c) 2014 Maison de Freyssinet. All rights reserved.
//

#ifndef __MDFPaymentCard__
#define __MDFPaymentCard__

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, MDFPaymentCardMII) {
    MDFPaymentCardMIIUnknown              = 0,
    MDFPaymentCardMIIAirline              = 2,
    MDFPaymentCardMIITravelEntertainment  = 3,
    MDFPaymentCardMIIBankingFincancial    = 5,
    MDFPaymentCardMIIMerchendizingBanking = 6,
    MDFPaymentCardMIIPetroleum            = 7,
    MDFPaymentCardMIITelecommunications   = 8,
    MDFPaymentCardMIINationalAssignment   = 9
};

@protocol MDFPaymentCard <NSObject>

- (NSString *)creditCardNumber;
- (void)setCreditCardNumber:(NSString *)creditCardNumber;

- (NSString *)creditCardVerification;
- (void)setCreditCardVerification:(NSString *)creditCardVerification;

- (NSUInteger)expirationDateMonth;
- (void)setExpirationDateMonth:(NSUInteger)expirationDateMonth;
- (NSUInteger)expirationDateYear;
- (void)setExpirationDateYear:(NSUInteger)expirationDateYear;

- (NSString *)cardHolderName;
- (void)setCardHolderName:(NSString *)cardHolderName;

- (BOOL)isEqualToPaymentCard:(id<MDFPaymentCard>)paymentCard;

- (NSUInteger)majorIndustryIdentifier;

@optional

- (NSString *)startDate;
- (void)setStartDate:(NSString *)startDate;

@end

#endif