//
//  MDFPaymentMethodTests.m
//  MDFPaymentCard
//
//  Created by Sam de Freyssinet on 04/05/2014.
//  Copyright (c) 2014 Maison de Freyssinet. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MDFPaymentMethod.h"
#import "MDFPaymentCardUS.h"
#import "MDFPaymentCardBillingAddressUS.h"

@interface MDFPaymentMethodTests : XCTestCase

@end

@implementation MDFPaymentMethodTests(Fixtures)

- (NSLocale *)locale
{
    return [NSLocale localeWithLocaleIdentifier:@"en_US"];
}

- (MDFPaymentCardUS *)usPaymentCard
{
    return [[MDFPaymentCardUS alloc] init];
}

- (MDFPaymentCardBillingAddressUS *)usCardBillingAddress
{
    return [[MDFPaymentCardBillingAddressUS alloc] init];
}

@end

@implementation MDFPaymentMethodTests

- (void)testPaymentCardForLocale
{
    XCTAssertTrue([[MDFPaymentMethod paymentCardForLocale:[self locale]] isKindOfClass:[[self usPaymentCard] class]], @"US Locale should produce US payment card");
}

- (void)testPaymentCardBillingAddressForLocale
{
    XCTAssertTrue([[MDFPaymentMethod paymentCardAddressForLocale:[self locale]] isKindOfClass:[[self usCardBillingAddress] class]], @"US Locale should produce US payment card billing address");
}

- (void)testPaymentMethodFactory
{
    id<MDFPaymentMethod> subject = [MDFPaymentMethod paymentMethodForLocale:[self locale]];
    
    XCTAssertNotNil(subject, @"The subject should not be nil");
    XCTAssertTrue([subject.paymentCard isKindOfClass:[[self usPaymentCard] class]] , @"Payment Card should be of type US Card");
    XCTAssertTrue([subject.paymentCardBillingAddress isKindOfClass:[[self usCardBillingAddress] class]] , @"Payment Card Billing Address should be of type US Card Billing Address");
}

@end
