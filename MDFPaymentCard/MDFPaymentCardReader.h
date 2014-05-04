//
//  MDFPaymentCardReader.h
//  MDFPaymentCard
//
//  Created by Sam de Freyssinet on 04/05/2014.
//  Copyright (c) 2014 Maison de Freyssinet. All rights reserved.
//

#ifndef __MDFPaymentCardReader__
#define __MDFPaymentCardReader__

#import <Foundation/Foundation.h>
#import "MDFPaymentCard.h"

@protocol MDFPaymentCardReader <NSObject>

+ (BOOL)decoratePaymentCard:(id<MDFPaymentCard>)paymentCard readBytes:(NSString *)readBytes error:(NSError **)error;

@end

#endif