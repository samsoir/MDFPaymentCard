//
//  MDFPaymentCardBillingAddressUS.m
//  MDFPaymentCard
//
//  Created by Sam de Freyssinet on 04/05/2014.
//  Copyright (c) 2014 Maison de Freyssinet. All rights reserved.
//

#import "MDFPaymentCardBillingAddressUS.h"

@implementation MDFPaymentCardBillingAddressUS(CountryName)

- (void)configureCountryNameWithLocale:(NSLocale *)locale
{
    NSString *countryCode = [locale objectForKey:NSLocaleCountryCode];
    [self setCountryName:[locale displayNameForKey:NSLocaleCountryCode value:countryCode]];
}

@end

@implementation MDFPaymentCardBillingAddressUS

+ (MDFPaymentCardBillingAddressUS *)billingAddressWithBillingName:(NSString *)billingName streetAddress:(NSString *)streetAddress postalCode:(NSString *)postalCode
{
    MDFPaymentCardBillingAddressUS *billingAddress = [[MDFPaymentCardBillingAddressUS alloc] init];
    
    [billingAddress setBillingName:billingName];
    [billingAddress setStreetAddress:streetAddress];
    [billingAddress setPostalCode:postalCode];
    
    return billingAddress;
}

- (id)init
{
    return [self initWithLocale:nil];
}

- (id)initWithLocale:(NSLocale *)localeOrNil
{
    self = [super init];
    
    if (self)
    {
        if ( ! localeOrNil)
        {
            localeOrNil = [NSLocale currentLocale];
        }
        
        [self configureCountryNameWithLocale:localeOrNil];
    }
    
    return self;
}

@end
