//
//  MDFPaymentCardUSTests.m
//  MDFPaymentCard
//
//  Created by Sam de Freyssinet on 03/05/2014.
//  Copyright (c) 2014 Maison de Freyssinet. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MDFPaymentCard.h"
#import "MDFPaymentCardUS.h"

@interface MDFPaymentCardUSTests : XCTestCase

@end

@implementation MDFPaymentCardUSTests(Fixtures)

- (NSString *)creditCardNumber
{
    return @"4444444444444444";
}

- (NSString *)ccv
{
    return @"123";
}

- (NSString *)expirationDate
{
    return @"05/2014";
}

- (NSString *)cardHolderName
{
    return @"Jane Doe";
}

- (NSString *)airlineMIICardNumber1
{
    return @"1444444444444444";
}

- (NSString *)airlineMIICardNumber2
{
    return @"2444444444444444";
}

- (NSString *)travelAndEntertainmentCardNumber
{
    return @"3444444444444444";
}

- (NSString *)bankingAndFinancialMIICardNumber1
{
    return @"4444444444444444";
}

- (NSString *)bankingAndFinancialMIICardNumber2
{
    return @"5444444444444444";
}

- (NSString *)merchandizingAndBankingMIICardNumber
{
    return @"6444444444444444";
}

- (NSString *)petroleumMIICardNumber
{
    return @"7444444444444444";
}

- (NSString *)telecommunicationsMIICardNumber
{
    return @"8444444444444444";
}

- (NSString *)nationalMIICardNumber
{
    return @"9444444444444444";
}

- (NSString *)unknownMIICardNumber
{
    return @"";
}

- (NSString *)expectedDescription
{
    return [NSString stringWithFormat:@"-- MDFPaymentCardUS --\n\tCard #: %@\n\tCCV: %@\n\tExp: %@\n\tCard Holder: %@", [self creditCardNumber], [self ccv], [self expirationDate], [self cardHolderName]];
}

- (id<MDFPaymentCard>)paymentCardWithNumber:(NSString *)number
{
    return [MDFPaymentCardUS paymentCardWithNumber:number
                                               ccv:nil
                                    expirationDate:nil
                                    cardHolderName:nil];
}

@end

@implementation MDFPaymentCardUSTests

- (void)testFactory
{
    id<MDFPaymentCard> paymentCard = [MDFPaymentCardUS paymentCardWithNumber:[self creditCardNumber]
                                                                         ccv:[self ccv]
                                                              expirationDate:[self expirationDate]
                                                              cardHolderName:[self cardHolderName]];
    
    XCTAssertNotNil(paymentCard, @"Payment card should not be nil");
    XCTAssertEqualObjects([paymentCard creditCardNumber], [self creditCardNumber], @"Payment card number: %@ does not match credit card number: %@", [paymentCard creditCardNumber], [self creditCardNumber]);
    XCTAssertEqualObjects([paymentCard creditCardVerification], [self ccv], @"Payment card ccv: %@ does not match credit card ccv: %@", [paymentCard creditCardVerification], [self ccv]);
    XCTAssertEqualObjects([paymentCard expirationDate], [self expirationDate], @"Payment card exp date: %@ does not match credit card exp date: %@", [paymentCard expirationDate], [self expirationDate]);
    XCTAssertEqualObjects([paymentCard cardHolderName], [self cardHolderName], @"Payment card holder name: %@ does not match credit card holder name: %@", [paymentCard cardHolderName], [self cardHolderName]);
}

- (void)testAirlineMII
{
    id<MDFPaymentCard> paymentCard1 = [self paymentCardWithNumber:[self airlineMIICardNumber1]];
    
    XCTAssertTrue([paymentCard1 majorIndustryIdentifier] == MDFPaymentCardMIIAirline, @"Airline MII card should return MDFPaymentCardMIIAirline");

    id<MDFPaymentCard> paymentCard2 = [self paymentCardWithNumber:[self airlineMIICardNumber2]];

    XCTAssertTrue([paymentCard2 majorIndustryIdentifier] == MDFPaymentCardMIIAirline, @"Airline MII card should return MDFPaymentCardMIIAirline");
}

- (void)testTravelAndEntertainmentMII
{
    id<MDFPaymentCard> travelAndEntertainmentCard = [self paymentCardWithNumber:[self travelAndEntertainmentCardNumber]];
    
    XCTAssertTrue([travelAndEntertainmentCard majorIndustryIdentifier] == MDFPaymentCardMIITravelEntertainment, @"Travel and Entertainment MII card should return MDFPaymentCardMIITravelEntertainment");
}

- (void)testBankingAndFinancialMII
{
    id<MDFPaymentCard> bankingAndFinancialCard1 = [self paymentCardWithNumber:[self bankingAndFinancialMIICardNumber1]];
    
    XCTAssertTrue([bankingAndFinancialCard1 majorIndustryIdentifier] == MDFPaymentCardMIIBankingFincancial, @"Banking and financial MII card should return MDFPaymentCardMIIBankingFincancial");

    id<MDFPaymentCard> bankingAndFinancialCard2 = [self paymentCardWithNumber:[self bankingAndFinancialMIICardNumber2]];
    
    XCTAssertTrue([bankingAndFinancialCard2 majorIndustryIdentifier] == MDFPaymentCardMIIBankingFincancial, @"Banking and financial MII card should return MDFPaymentCardMIIBankingFincancial");
}

- (void)testMerchendizingAndBankingMII
{
    id<MDFPaymentCard> merchandizingAndBanking = [self paymentCardWithNumber:[self merchandizingAndBankingMIICardNumber]];
    
    XCTAssertTrue([merchandizingAndBanking majorIndustryIdentifier] == MDFPaymentCardMIIMerchendizingBanking, @"Merchandizing and banking MII card should return MDFPaymentCardMIIMerchendizingBanking");
}

- (void)testPetroleumMII
{
    id<MDFPaymentCard> petroleum = [self paymentCardWithNumber:[self petroleumMIICardNumber]];
    
    XCTAssertTrue([petroleum majorIndustryIdentifier] == MDFPaymentCardMIIPetroleum, @"Petroleum MII card should return MDFPaymentCardMIIPetroleum");
}

- (void)testTelecommunicationsMII
{
    id<MDFPaymentCard> telecommunications = [self paymentCardWithNumber:[self telecommunicationsMIICardNumber]];
    
    XCTAssertTrue([telecommunications majorIndustryIdentifier] == MDFPaymentCardMIITelecommunications, @"Telecommunications MII card should return MDFPaymentCardMIITelecommunications");
}

- (void)testNationalAssignmentMII
{
    id<MDFPaymentCard> national = [self paymentCardWithNumber:[self nationalMIICardNumber]];
    
    XCTAssertTrue([national majorIndustryIdentifier] == MDFPaymentCardMIINationalAssignment, @"National Assignment MII card should return MDFPaymentCardMIINationalAssignment");
}

- (void)testUnknownMII
{
    id<MDFPaymentCard> unknown = [self paymentCardWithNumber:[self unknownMIICardNumber]];

    XCTAssertTrue([unknown majorIndustryIdentifier] == MDFPaymentCardMIIUnknown, @"Unknown card number");
}

- (void)testDescription
{
    id<MDFPaymentCard> paymentCard = [MDFPaymentCardUS paymentCardWithNumber:[self creditCardNumber]
                                                                         ccv:[self ccv]
                                                              expirationDate:[self expirationDate]
                                                              cardHolderName:[self cardHolderName]];
    
    XCTAssertEqualObjects([paymentCard description], [self expectedDescription], @"Description did not match expected description");
}

- (void)testIsEqualToPaymentCard
{
    id<MDFPaymentCard> paymentCard1 = [MDFPaymentCardUS paymentCardWithNumber:[self creditCardNumber]
                                                                         ccv:[self ccv]
                                                              expirationDate:[self expirationDate]
                                                              cardHolderName:[self cardHolderName]];

    id<MDFPaymentCard> paymentCard2 = [MDFPaymentCardUS paymentCardWithNumber:[self creditCardNumber]
                                                                          ccv:[self ccv]
                                                               expirationDate:[self expirationDate]
                                                               cardHolderName:[self cardHolderName]];

    XCTAssertTrue([paymentCard1 isEqualToPaymentCard:paymentCard2], @"Identical payment cards should be equal");
    
    id<MDFPaymentCard> paymentCard3 = [MDFPaymentCardUS paymentCardWithNumber:[self merchandizingAndBankingMIICardNumber]
                                                                          ccv:[self ccv]
                                                               expirationDate:[self expirationDate]
                                                               cardHolderName:[self cardHolderName]];

    XCTAssertFalse([paymentCard1 isEqualToPaymentCard:paymentCard3], @"Differing payment cards should not be equal");
}

@end
