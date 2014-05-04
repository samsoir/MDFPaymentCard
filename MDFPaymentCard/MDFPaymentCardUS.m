//
//  MDFPaymentCardUS.m
//  MDFPaymentCard
//
//  Created by Sam de Freyssinet on 03/05/2014.
//  Copyright (c) 2014 Maison de Freyssinet. All rights reserved.
//

#import "MDFPaymentCardUS.h"

@implementation MDFPaymentCardUS(MajorIndustryIdentifier)

- (NSUInteger)majorIndustryIdentifierForByte:(NSUInteger)byte
{
    NSUInteger miiValue = MDFPaymentCardMIIUnknown;

    switch (byte) {
        case 1:
        case 2:
            miiValue = MDFPaymentCardMIIAirline;
            break;
        case 3:
            miiValue = MDFPaymentCardMIITravelEntertainment;
            break;
        case 4:
        case 5:
            miiValue = MDFPaymentCardMIIBankingFincancial;
            break;
        case 6:
            miiValue = MDFPaymentCardMIIMerchendizingBanking;
            break;
        case 7:
            miiValue = MDFPaymentCardMIIPetroleum;
            break;
        case 8:
            miiValue = MDFPaymentCardMIITelecommunications;
            break;
        case 9:
            miiValue = MDFPaymentCardMIINationalAssignment;
            break;
    }

    return miiValue;
}

@end

@implementation MDFPaymentCardUS

+ (MDFPaymentCardUS *)paymentCardWithNumber:(NSString *)cardNumber ccv:(NSString *)ccv expirationDate:(NSString *)expirationDate cardHolderName:(NSString *)cardHolderName
{
    MDFPaymentCardUS *paymentCard = [[MDFPaymentCardUS alloc] init];
    
    paymentCard.creditCardNumber       = cardNumber;
    paymentCard.creditCardVerification = ccv;
    paymentCard.expirationDate         = expirationDate;
    paymentCard.cardHolderName         = cardHolderName;
    
    return paymentCard;
}

- (NSUInteger)majorIndustryIdentifier
{
    if ( ! self.creditCardNumber || ! [self.creditCardNumber length])
    {
        return MDFPaymentCardMIIUnknown;
    }
    
    return [self majorIndustryIdentifierForByte:[[self.creditCardNumber substringToIndex:1] integerValue]];
}

@end
