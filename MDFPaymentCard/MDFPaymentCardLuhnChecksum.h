//
//  MDFPaymentCardLuhnChecksum.h
//  MDFPaymentCard
//
//  Created by Sam de Freyssinet on 04/05/2014.
//  Copyright (c) 2014 Maison de Freyssinet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MDFPaymentCard.h"

@interface MDFPaymentCardLuhnChecksum : NSObject

+ (BOOL)isPaymentCardChecksumValid:(id<MDFPaymentCard>)paymentCard;

@end
