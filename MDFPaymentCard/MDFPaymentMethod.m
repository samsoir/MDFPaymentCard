//
//  MDFPaymentMethod.m
//  MDFPaymentCard
//
//  Created by Sam de Freyssinet on 04/05/2014.
//  Copyright (c) 2014 Maison de Freyssinet. All rights reserved.
//

#import "MDFPaymentMethod.h"
#import "MDFPaymentCardUS.h"
#import "MDFPaymentCardBillingAddressUS.h"

@implementation MDFPaymentMethod(Factories)

+ (Class)localizedClassName:(NSString *)className forLocale:(NSLocale *)locale
{
    NSString *classLocalizedSuffix = [locale objectForKey:NSLocaleCountryCode];    NSString *localizedClassName   = [NSString stringWithFormat:@"%@%@", className, classLocalizedSuffix];
    
    return NSClassFromString(localizedClassName);
}

@end

@implementation MDFPaymentMethod

+ (id<MDFPaymentCard>)paymentCardForLocale:(NSLocale *)locale
{
    Class className = [MDFPaymentMethod localizedClassName:@"MDFPaymentCard" forLocale:locale];
    
    return [[className alloc] init];
}

+ (id<MDFPaymentCardBillingAddress>)paymentCardAddressForLocale:(NSLocale *)locale
{
    Class className = [MDFPaymentMethod localizedClassName:@"MDFPaymentCardBillingAddress" forLocale:locale];
    
    return [[className alloc] init];
}

+ (id<MDFPaymentMethod>)paymentMethodForLocale:(NSLocale *)locale
{
    id<MDFPaymentCard> paymentCard                  = [MDFPaymentMethod paymentCardForLocale:locale];
    id<MDFPaymentCardBillingAddress> billingAddress = [MDFPaymentMethod paymentCardAddressForLocale:locale];
    
    MDFPaymentMethod *paymentMethod = [[MDFPaymentMethod alloc] initWithPaymentCard:paymentCard billingAddress:billingAddress];
    
    return paymentMethod;
}

- (id)init
{
    return [self initWithPaymentCard:nil billingAddress:nil];
}

- (id<MDFPaymentMethod>)initWithPaymentCard:(id<MDFPaymentCard>)paymentCard billingAddress:(id<MDFPaymentCardBillingAddress>)billingAddress
{
    self = [super init];
    
    if (self)
    {
        self.paymentCard = paymentCard;
        self.paymentCardBillingAddress = billingAddress;
    }
    
    return self;
}

@end
