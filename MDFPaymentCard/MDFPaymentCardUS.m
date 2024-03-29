//
//  MDFPaymentCardUS.m
//  MDFPaymentCard
//
//  Created by Sam de Freyssinet on 03/05/2014.
//  Copyright (c) 2014 Maison de Freyssinet. All rights reserved.
//

#import "MDFPaymentCardUS.h"

NSString *const kMDFPaymentCardUSDescriptionTemplate = @"-- MDFPaymentCardUS --\n\tCard #: %@\n\tCCV: %@\n\tExp: %u/%u\n\tCard Holder: %@";

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

+ (MDFPaymentCardUS *)paymentCardWithNumber:(NSString *)cardNumber ccv:(NSString *)ccv expirationMonth:(NSUInteger)expirationMonth expirationYear:(NSUInteger)expirationYear cardHolderName:(NSString *)cardHolderName
{
    MDFPaymentCardUS *paymentCard = [[MDFPaymentCardUS alloc] init];
    
    paymentCard.creditCardNumber       = cardNumber;
    paymentCard.creditCardVerification = ccv;
    paymentCard.expirationDateMonth    = expirationMonth;
    paymentCard.expirationDateYear     = expirationYear;
    paymentCard.cardHolderName         = cardHolderName;
    
    return paymentCard;
}

- (BOOL)isEqualToPaymentCard:(id<MDFPaymentCard>)paymentCard
{
    BOOL equality = [self.creditCardNumber isEqualToString:[paymentCard creditCardNumber]];

    if (equality)
    {
        equality = [self.creditCardVerification isEqualToString:[paymentCard creditCardVerification]];
    }
    
    if (equality)
    {
        equality = (self.expirationDateMonth == [paymentCard expirationDateMonth]) && (self.expirationDateYear == [paymentCard expirationDateYear]);
    }
    
    if (equality)
    {
        equality = [self.cardHolderName isEqualToString:[paymentCard cardHolderName]];
    }
    
    return equality;
}

- (NSUInteger)majorIndustryIdentifier
{
    if ( ! self.creditCardNumber || ! [self.creditCardNumber length])
    {
        return MDFPaymentCardMIIUnknown;
    }
    
    return [self majorIndustryIdentifierForByte:[[self.creditCardNumber substringToIndex:1] integerValue]];
}

- (NSString *)description
{
    return [NSString stringWithFormat:kMDFPaymentCardUSDescriptionTemplate, self.creditCardNumber, self.creditCardVerification, self.expirationDateMonth, self.expirationDateYear, self.cardHolderName];
}

@end
