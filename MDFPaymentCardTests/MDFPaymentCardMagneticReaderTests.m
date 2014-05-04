//
//  MDFPaymentCardMagneticReader.m
//  MDFPaymentCard
//
//  Created by Sam de Freyssinet on 04/05/2014.
//  Copyright (c) 2014 Maison de Freyssinet. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MDFPaymentCardMagenticReader.h"
#import "MDFPaymentCard.h"
#import "MDFPaymentCardUS.h"

@interface MDFPaymentCardMagneticReaderTests : XCTestCase

@end

@implementation MDFPaymentCardMagneticReaderTests(Fixtures)

- (NSString *)readBytesVisa
{
    return @";4782444444444326=18021010|";
}

- (NSString *)readBytesDiscover
{
    return @";6011666666666110=19051011004|||";
}

- (NSString *)readBytesAmex
{
    return @";379634343434004=1709101131";
}

@end

@implementation MDFPaymentCardMagneticReaderTests

- (void)testDecoratePaymentCardFailsWithNoPaymentCardWithError
{
    id<MDFPaymentCard> paymentCard = nil;
    NSError *error                 = nil;
    
    XCTAssertFalse([MDFPaymentCardMagenticReader decoratePaymentCard:paymentCard readBytes:nil error:&error], @"Decoration should fail with no card");
    
    XCTAssertNotNil(error, @"Error should not be nil on failure");
    XCTAssertEqualObjects([error domain], MDFPaymentCardMagneticReaderErrorDomain, @"Error domain should be MDFPaymentCardMagenticReaderErrorDomain");
    XCTAssertTrue([error code] & MDFPaymentCardMagenticReaderNoPaymentCard, @"Error code should contain no payment card bitmask");
}

- (void)testDecoratePaymentCardFailWithNoBytesWithError
{
    MDFPaymentCardUS *paymentCard = [[MDFPaymentCardUS alloc] init];
    NSString *bytes               = nil;
    NSError  *error               = nil;
    
    XCTAssertFalse([MDFPaymentCardMagenticReader decoratePaymentCard:paymentCard readBytes:bytes error:&error], @"Decoration should fail with no data");
    
    XCTAssertNotNil(error, @"Error should not be nil on failure");
    XCTAssertEqualObjects([error domain], MDFPaymentCardMagneticReaderErrorDomain, @"Error domain should be MDFPaymentCardMagenticReaderErrorDomain");
    XCTAssertTrue([error code] & MDFPaymentCardMagenticReaderNoBytes, @"Error code should contain no bytes bitmask");
}

- (void)testReadVisaCard
{
    MDFPaymentCardUS *paymentCard = [[MDFPaymentCardUS alloc] init];
    NSString *bytesRead           = [self readBytesVisa];
    NSError *error                = nil;
    
    XCTAssertTrue([MDFPaymentCardMagenticReader decoratePaymentCard:paymentCard readBytes:bytesRead error:&error], @"Decoration should be successful");
    
    XCTAssertEqualObjects([paymentCard creditCardNumber], @"4782444444444326", @"Credit card number not read correctly");
    XCTAssertTrue([paymentCard expirationDateYear] == 2018, @"Card should expire in 2018");
    XCTAssertTrue([paymentCard expirationDateMonth] == 2, @"Card shoud expire in February");
}

- (void)testReadDiscoverCard
{
    MDFPaymentCardUS *paymentCard = [[MDFPaymentCardUS alloc] init];
    NSString *bytesRead           = [self readBytesDiscover];
    NSError *error                = nil;
    
    XCTAssertTrue([MDFPaymentCardMagenticReader decoratePaymentCard:paymentCard readBytes:bytesRead error:&error], @"Decoration should be successful");
    
    XCTAssertEqualObjects([paymentCard creditCardNumber], @"6011666666666110", @"Credit card number not read correctly");
    XCTAssertTrue([paymentCard expirationDateYear] == 2019, @"Card should expire in 2019");
    XCTAssertTrue([paymentCard expirationDateMonth] == 5, @"Card shoud expire in May");
}

- (void)testReadAmexCard
{
    MDFPaymentCardUS *paymentCard = [[MDFPaymentCardUS alloc] init];
    NSString *bytesRead           = [self readBytesAmex];
    NSError *error                = nil;
    
    XCTAssertTrue([MDFPaymentCardMagenticReader decoratePaymentCard:paymentCard readBytes:bytesRead error:&error], @"Decoration should be successful");
    
    XCTAssertEqualObjects([paymentCard creditCardNumber], @"379634343434004", @"Credit card number not read correctly");
    XCTAssertTrue([paymentCard expirationDateYear] == 2017, @"Card should expire in 2017");
    XCTAssertTrue([paymentCard expirationDateMonth] == 9, @"Card shoud expire in September");
}

@end
