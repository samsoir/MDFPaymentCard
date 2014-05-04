//
//  MDFPaymentCardBillingAddressUSTests.m
//  MDFPaymentCard
//
//  Created by Sam de Freyssinet on 04/05/2014.
//  Copyright (c) 2014 Maison de Freyssinet. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MDFPaymentCardBillingAddressUS.h"

@interface MDFPaymentCardBillingAddressUSTests : XCTestCase

@end

@implementation MDFPaymentCardBillingAddressUSTests(Fixtures)

- (NSString *)billingName
{
    return @"John Doe";
}

- (NSString *)streetAddress
{
    return @"4000 N Kenmore Ave";
}

- (NSString *)postalCode
{
    return @"60654";
}

- (NSLocale *)unitedStatesLocale
{
    return [NSLocale localeWithLocaleIdentifier:@"en_US"];
}

- (NSLocale *)britishLocale
{
    return [NSLocale localeWithLocaleIdentifier:@"en_GB"];
}

@end

@implementation MDFPaymentCardBillingAddressUSTests

- (void)testInitWithLocale
{
    MDFPaymentCardBillingAddressUS *subject = [[MDFPaymentCardBillingAddressUS alloc] initWithLocale:[self britishLocale]];
    
    NSString *countryCode = [[self britishLocale] objectForKey:NSLocaleCountryCode];
    
    XCTAssertNotNil(subject, @"Init should produce valid subject");
    XCTAssertEqualObjects([subject countryName], [[self britishLocale] displayNameForKey:NSLocaleCountryCode value:countryCode], @"Country name should match locale");
}

- (void)testPaymentCardFactory
{
    MDFPaymentCardBillingAddressUS *subject = [MDFPaymentCardBillingAddressUS billingAddressWithBillingName:[self billingName] streetAddress:[self streetAddress] postalCode:[self postalCode]];
    
    XCTAssertNotNil(subject, @"Factory should produce a valid object");
    XCTAssertEqualObjects([subject billingName], [self billingName], @"Billing names should match");
    XCTAssertEqualObjects([subject streetAddress], [self streetAddress], @"Street address names should match");
    XCTAssertEqualObjects([subject postalCode], [self postalCode], @"Postal code should match");
    
    NSString *countryCode = [[self unitedStatesLocale] objectForKey:NSLocaleCountryCode];
    
    XCTAssertEqualObjects([subject countryName], [[self unitedStatesLocale] displayNameForKey:NSLocaleCountryCode value:countryCode], @"Country name should match locale");
}

@end
