//
//  MDFPaymentCardMagenticReader.h
//  MDFPaymentCard
//
//  Created by Sam de Freyssinet on 04/05/2014.
//  Copyright (c) 2014 Maison de Freyssinet. All rights reserved.
//

#ifndef __MDFPaymentCardMagenticReader__
#define __MDFPaymentCardMagenticReader__

FOUNDATION_EXPORT NSString * const MDFPaymentCardMagneticReaderErrorDomain;
FOUNDATION_EXPORT NSString * const kMDFPaymentCardMagneticReaderPattern;
FOUNDATION_EXPORT NSUInteger const kMDFPaymentCardByteRangeCardNumber;
FOUNDATION_EXPORT NSUInteger const kMDFPaymentCardByteRangeMetaData;
FOUNDATION_EXPORT NSUInteger const kMDFPaymentCardByteMetaDataDateRange;
FOUNDATION_EXPORT NSUInteger const kMDFPaymentCardDateComponents;
FOUNDATION_EXPORT NSString * const kMDFPaymentCardDateFormatString;

typedef NS_ENUM(NSUInteger, MDFPaymentCardMagenticReaderErrorCode)
{
    MDFPaymentCardMagenticReaderNoPaymentCard = 1 << 0,
    MDFPaymentCardMagenticReaderNoBytes       = 1 << 1,
    MDFPaymentCardMagenticReaderInvalidBytes  = 1 << 2,
};

#import <Foundation/Foundation.h>
#import "MDFPaymentCardReader.h"

@interface MDFPaymentCardMagenticReader : NSObject <MDFPaymentCardReader>

+ (BOOL)decoratePaymentCard:(id<MDFPaymentCard>)paymentCard readBytes:(NSString *)readBytes error:(NSError **)error;

@end

#endif