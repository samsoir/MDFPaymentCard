//
//  MDFPaymentCardLuhnChecksum.m
//  MDFPaymentCard
//
//  Created by Sam de Freyssinet on 04/05/2014.
//  Copyright (c) 2014 Maison de Freyssinet. All rights reserved.
//

#import "MDFPaymentCardLuhnChecksum.h"

@implementation MDFPaymentCardLuhnChecksum(Luhn)

+ (void)luhnCardNumberBaseNumber:(NSString **)baseNumber forCardNumber:(NSString *)cardNumber
{
    NSMutableString *buffer = [[NSMutableString alloc] initWithCapacity:24];
    
    NSUInteger byteLength = [cardNumber length];
    
    for (int i = 0; i < byteLength; i++)
    {
        NSRange range = NSMakeRange(i, 1);
        
        if ((range.location % 2) == 0)
        {
            NSInteger value = [[cardNumber substringWithRange:range] integerValue];
            [buffer appendString:[NSString stringWithFormat:@"%i", (value*2)]];
        }
        else
        {
            [buffer appendString:[cardNumber substringWithRange:range]];
        }
    }
        
    if (baseNumber)
    {
        *baseNumber = (NSString *)buffer;
    }
}

+ (NSUInteger)luhnCardChecksumFromBaseNumber:(NSString *)baseNumber
{
    NSUInteger sum = 0;
    NSUInteger byteLength = [baseNumber length];
    
    for (int i = 0; i < byteLength; i++)
    {
        NSRange range = NSMakeRange(i, 1);
        sum += [[baseNumber substringWithRange:range] integerValue];
    }
    
    return sum;
}

+ (BOOL)isLuhnCardChecksumValid:(NSUInteger)checksum
{
    return (checksum % 10) == 0;
}

@end

@implementation MDFPaymentCardLuhnChecksum

+ (BOOL)isPaymentCardChecksumValid:(id<MDFPaymentCard>)paymentCard
{
    NSString *baseNumber = nil;
    [MDFPaymentCardLuhnChecksum luhnCardNumberBaseNumber:&baseNumber forCardNumber:paymentCard.creditCardNumber];
    
    NSUInteger checksum = [MDFPaymentCardLuhnChecksum luhnCardChecksumFromBaseNumber:baseNumber];
    
    return [MDFPaymentCardLuhnChecksum isLuhnCardChecksumValid:checksum];
}

@end
