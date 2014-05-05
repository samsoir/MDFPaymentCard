//
//  MDFPaymentMethodValidatorUSTests.m
//  MDFPaymentCard
//
//  Created by Sam de Freyssinet on 04/05/2014.
//  Copyright (c) 2014 Maison de Freyssinet. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MDFPaymentMethodValidatorUS.h"
#import "MDFPaymentCardUS.h"
#import "MDFPaymentCardBillingAddressUS.h"

@interface MDFPaymentMethodValidatorUSTests : XCTestCase

@end

@implementation MDFPaymentMethodValidatorUSTests(Fixtures)

- (NSString *)invalidCardNumber
{
    return @"4417123456789";
}

- (NSString *)validCardNumber
{
    return @"4417123456789113";
}

- (MDFPaymentCardUS *)validPaymentCardUS
{
    MDFPaymentCardUS *paymentCardUS = [[MDFPaymentCardUS alloc] init];
    
    paymentCardUS.creditCardNumber       = [self validCardNumber];
    paymentCardUS.creditCardVerification = @"123";
    paymentCardUS.cardHolderName         = @"John Doe";
    paymentCardUS.expirationDateMonth    = 5;
    paymentCardUS.expirationDateYear     = 2017;
    
    return paymentCardUS;
}

- (MDFPaymentCardBillingAddressUS *)validBillingAddressUS
{
    MDFPaymentCardBillingAddressUS *validAddress = [MDFPaymentCardBillingAddressUS billingAddressWithBillingName:@"John Doe" streetAddress:@"4000 N Kenmore Avenue" postalCode:@"60650"];
    
    [validAddress setStateName:@"IL"];
    [validAddress setCompanyName:@"Acme Inc"];
    [validAddress setBillingName:@"John Doe"];
    [validAddress setUnitAddress:@"Suite 1000"];
    [validAddress setCity:@"Chicago"];
    
    return validAddress;
}

- (MDFPaymentCardUS *)invalidPaymentCardUS
{
    MDFPaymentCardUS *paymentCardUS = [[MDFPaymentCardUS alloc] init];
    
    paymentCardUS.creditCardNumber = [self invalidCardNumber];
    
    return paymentCardUS;
}

- (MDFPaymentMethod *)validPaymentMethodUS
{
    MDFPaymentMethod *paymentMethod = [MDFPaymentMethod paymentMethodForLocale:nil];
    [paymentMethod setPaymentCard:[self validPaymentCardUS]];
    [paymentMethod setPaymentCardBillingAddress:[self validBillingAddressUS]];
    
    return paymentMethod;
}

- (MDFPaymentMethod *)invalidPaymentMethodUS
{
    MDFPaymentMethod *paymentMethod = [MDFPaymentMethod paymentMethodForLocale:nil];
    [paymentMethod setPaymentCard:[self invalidPaymentCardUS]];
    [paymentMethod setPaymentCardBillingAddress:[self validBillingAddressUS]];
    
    return paymentMethod;
}


@end

@implementation MDFPaymentMethodValidatorUSTests

- (void)testInitWithPaymentMethod
{
    MDFPaymentMethod *validPaymentMethod = [self validPaymentMethodUS];
    
    MDFPaymentMethodValidatorUS *subject = [[MDFPaymentMethodValidatorUS alloc] initWithPaymentMethod:validPaymentMethod];
    
    XCTAssertNotNil(subject, @"MDFPaymentValidator should not be nil");
    XCTAssertEqual(subject.paymentMethod, validPaymentMethod, @"Payment method should be assigned to the validator");
}

- (void)testIsValidLuhnChecksumValid
{
    MDFPaymentMethod *validPaymentMethod = [self validPaymentMethodUS];
    
    MDFPaymentMethodValidatorUS *subject = [[MDFPaymentMethodValidatorUS alloc] initWithPaymentMethod:validPaymentMethod];

    NSError *error = nil;
    
    XCTAssertTrue([subject isValidLuhnChecksum:&error], @"isValidLuhnChecksum should be true");
    XCTAssertNil(error, @"Error should not be set with valid luhn checksum");
}

- (void)testIsValidLuhnChecksumInvalid
{
    MDFPaymentMethod *invalidPaymentMethod = [self invalidPaymentMethodUS];
    
    MDFPaymentMethodValidatorUS *subject = [[MDFPaymentMethodValidatorUS alloc] initWithPaymentMethod:invalidPaymentMethod];
    
    NSError *error = nil;
    
    XCTAssertFalse([subject isValidLuhnChecksum:&error], @"isValidLuhnChecksum should be true");
    XCTAssertNotNil(error, @"Error should be set with invalid luhn checksum");
    XCTAssertEqualObjects([error domain], MDFPaymentMethodValidatorUSErrorDomain, @"Error domain should be set to: %@", MDFPaymentMethodValidatorUSErrorDomain);
    XCTAssertTrue([error code] == (MDFPaymentMethodValidatorUSErrorCode|MDFPaymentMethodValidateOptionsCardLuhnChecksum), @"Error code checksum should be: %i", MDFPaymentMethodValidatorUSErrorCode|MDFPaymentMethodValidateOptionsCardLuhnChecksum);
}

- (void)testIsValidPaymentMethodOptionsValid
{
    MDFPaymentMethod *validPaymentMethod = [self validPaymentMethodUS];
    MDFPaymentMethodValidatorUS *subject = [[MDFPaymentMethodValidatorUS alloc] initWithPaymentMethod:validPaymentMethod];
    
    NSUInteger options = (MDFPaymentMethodValidateOptionsCardHolderName|
                          MDFPaymentMethodValidateOptionsCardNumber|
                          MDFPaymentMethodValidateOptionsCardCCV|
                          MDFPaymentMethodValidateOptionsExpirationDate|
                          MDFPaymentMethodValidateOptionsBillingPostalCode|
                          MDFPaymentMethodValidateOptionsBillingStreetAddress|
                          MDFPaymentMethodValidateOptionsBillingCityName|
                          MDFPaymentMethodValidateOptionsBillingStateName|
                          MDFPaymentMethodValidateOptionsBillingUnitAddress|
                          MDFPaymentMethodValidateOptionsBillingCountryName|
                          MDFPaymentMethodValidateOptionsBillingName|
                          MDFPaymentMethodValidateOptionsCardLuhnChecksum);
    
    NSError *error = nil;
    
    XCTAssertTrue([subject isValidPaymentMethod:options error:&error], @"isValidPaymentMethod should be true");
    XCTAssertNil(error, @"Error should not be set with valid luhn checksum");
}

- (void)testIsValidPaymentMethodOptionsInvalid
{
    MDFPaymentMethod *invalidPaymentMethod = [self invalidPaymentMethodUS];
    MDFPaymentMethodValidatorUS *subject = [[MDFPaymentMethodValidatorUS alloc] initWithPaymentMethod:invalidPaymentMethod];
    
    NSUInteger options = (MDFPaymentMethodValidateOptionsCardHolderName|
                          MDFPaymentMethodValidateOptionsCardNumber|
                          MDFPaymentMethodValidateOptionsCardCCV|
                          MDFPaymentMethodValidateOptionsExpirationDate|
                          MDFPaymentMethodValidateOptionsCardLuhnChecksum);
    
    NSUInteger expectedError = options|MDFPaymentMethodValidatorUSErrorCode;
    
    NSError *error = nil;
    
    XCTAssertFalse([subject isValidPaymentMethod:options error:&error], @"isValidPaymentMethod should be true");
    XCTAssertNotNil(error, @"Error should not be set with valid luhn checksum");
    XCTAssertEqualObjects([error domain], MDFPaymentMethodValidatorUSErrorDomain, @"Error domain must be MDFPaymentMethodValidatorUSErrorDomain");
    XCTAssertTrue([error code] == expectedError, @"Error code should be: %i", expectedError);
}

@end
