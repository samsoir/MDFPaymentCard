//
//  MDFPaymentCardMagenticReader.m
//  MDFPaymentCard
//
//  Created by Sam de Freyssinet on 04/05/2014.
//  Copyright (c) 2014 Maison de Freyssinet. All rights reserved.
//

#import "MDFPaymentCardMagenticReader.h"

NSString * const MDFPaymentCardMagneticReaderErrorDomain = @"net.reyssi.def:MDFPaymentCardMagenticReaderErrorDomain";
NSString * const kMDFPaymentCardMagneticReaderPattern    = @"(\\d+)";
NSUInteger const kMDFPaymentCardByteRangeCardNumber      = 0;
NSUInteger const kMDFPaymentCardByteRangeMetaData        = 1;
NSUInteger const kMDFPaymentCardByteMetaDataDateRange    = 4;
NSUInteger const kMDFPaymentCardDateComponents           = NSCalendarUnitYear|NSCalendarUnitMonth;
NSString * const kMDFPaymentCardDateFormatString         = @"yyMM";



@implementation MDFPaymentCardMagenticReader(ErrorHandling)

+ (BOOL)isPaymentCardValid:(id<MDFPaymentCard>)paymentCard errorCode:(NSUInteger *)errorCode
{
    BOOL result = YES;
    
    if ( ! paymentCard)
    {
        *errorCode |= MDFPaymentCardMagenticReaderNoPaymentCard;
        result = NO;
    }
    
    return result;
}

+ (BOOL)isReadBytesValid:(NSString *)readBytes errorCode:(NSUInteger *)errorCode
{
    BOOL result = YES;
    
    if ( ! readBytes)
    {
        *errorCode |= MDFPaymentCardMagenticReaderNoBytes;
        result = NO;
    }
    
    return result;
}

+ (void)createError:(NSError **)error forErrorCode:(NSUInteger)errorCode
{
    if (error && errorCode > 0)
    {
        *error = [NSError errorWithDomain:MDFPaymentCardMagneticReaderErrorDomain
                                     code:errorCode
                                 userInfo:nil];
    }
}

@end

@implementation MDFPaymentCardMagenticReader(Parsing)

+ (NSArray *)parseReadBytes:(NSString *)readBytes errorCode:(NSUInteger *)errorCode
{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:kMDFPaymentCardMagneticReaderPattern
                                                                           options:0
                                                                             error:nil];
    
    NSArray *matches = [regex matchesInString:readBytes
                                      options:0
                                        range:NSMakeRange(0, [readBytes length])];
    
    if ( ! [matches count])
    {
        *errorCode |= MDFPaymentCardMagenticReaderInvalidBytes;
    }
    
    return matches;
}

+ (NSDateComponents *)expiryDateWithMetaData:(NSString *)metaData errorCode:(NSUInteger *)errorCode
{
    NSCalendar *gregorian       = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateFormatter *formatter  = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:kMDFPaymentCardDateFormatString];
    
    return [gregorian components:kMDFPaymentCardDateComponents
                        fromDate:[formatter dateFromString:metaData]];
}

+ (void)decoratePaymentCard:(id<MDFPaymentCard>)paymentCard withReadBytes:(NSString *)readBytes parsedByteArray:(NSArray *)parsedByteArray errorCode:(NSUInteger *)errorCode
{
    [parsedByteArray enumerateObjectsUsingBlock:^(NSTextCheckingResult *result, NSUInteger idx, BOOL *stop) {
        if (idx == kMDFPaymentCardByteRangeCardNumber)
        {
            [paymentCard setCreditCardNumber:[readBytes substringWithRange:[result range]]];
        }
        else if (idx == kMDFPaymentCardByteRangeMetaData)
        {
            NSDateComponents *expiryDate = [MDFPaymentCardMagenticReader expiryDateWithMetaData:[[readBytes substringWithRange:[result range]] substringToIndex:kMDFPaymentCardByteMetaDataDateRange] errorCode:errorCode];
            
            if (expiryDate)
            {
                [paymentCard setExpirationDateMonth:[expiryDate month]];
                [paymentCard setExpirationDateYear:[expiryDate year]];
            }
        }
    }];
}

@end

@implementation MDFPaymentCardMagenticReader

+ (BOOL)decoratePaymentCard:(id<MDFPaymentCard>)paymentCard readBytes:(NSString *)readBytes error:(NSError **)error
{
    NSUInteger errorCode = 0;
    
    if ([MDFPaymentCardMagenticReader isPaymentCardValid:paymentCard errorCode:&errorCode] && [MDFPaymentCardMagenticReader isReadBytesValid:readBytes errorCode:&errorCode])
    {
        NSArray *matches = [MDFPaymentCardMagenticReader parseReadBytes:readBytes errorCode:&errorCode];
        
        [MDFPaymentCardMagenticReader decoratePaymentCard:paymentCard
                                            withReadBytes:readBytes
                                          parsedByteArray:matches
                                                errorCode:&errorCode];
    }
    
    [MDFPaymentCardMagenticReader createError:error forErrorCode:errorCode];
    
    return errorCode == 0;
}

@end
