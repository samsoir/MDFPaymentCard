//
//  MDFPaymentCardLuhnChecksumTests.m
//  MDFPaymentCard
//
//  Created by Sam de Freyssinet on 04/05/2014.
//  Copyright (c) 2014 Maison de Freyssinet. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MDFPaymentCardLuhnChecksum.h"
#import "MDFPaymentCardUS.h"

@interface MDFPaymentCardLuhnChecksumTests : XCTestCase

@end

@implementation MDFPaymentCardLuhnChecksumTests(Fixtures)

- (NSString *)invalidCardNumber
{
    return @"4417123456789115";
}

- (NSString *)validCardNumber
{
    return @"4417123456789113";
}

- (MDFPaymentCardUS *)validPaymentCardUS
{
    MDFPaymentCardUS *paymentCardUS = [[MDFPaymentCardUS alloc] init];
    
    paymentCardUS.creditCardNumber = [self validCardNumber];
    
    return paymentCardUS;
}

- (MDFPaymentCardUS *)invalidPaymentCardUS
{
    MDFPaymentCardUS *paymentCardUS = [[MDFPaymentCardUS alloc] init];
    
    paymentCardUS.creditCardNumber = [self invalidCardNumber];
    
    return paymentCardUS;
}

@end

@implementation MDFPaymentCardLuhnChecksumTests

- (void)testValidPaymentNumber
{
    MDFPaymentCardUS *subject = [self validPaymentCardUS];
    
    XCTAssertTrue([MDFPaymentCardLuhnChecksum isPaymentCardChecksumValid:subject], @"Valid card number %@ should be valid", [self validCardNumber]);
}

- (void)testInvalidPaymentNumber
{
    MDFPaymentCardUS *subject = [self invalidPaymentCardUS];
    
    XCTAssertFalse([MDFPaymentCardLuhnChecksum isPaymentCardChecksumValid:subject], @"Invalid card number %@ should be invalid", [self invalidCardNumber]);
}

@end
