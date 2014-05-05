//
//  MDFPaymentMethodValidatorUS.m
//  MDFPaymentCard
//
//  Created by Sam de Freyssinet on 04/05/2014.
//  Copyright (c) 2014 Maison de Freyssinet. All rights reserved.
//

#import "MDFPaymentMethodValidatorUS.h"
#import "MDFPaymentCardLuhnChecksum.h"

NSString * const MDFPaymentMethodValidatorUSErrorDomain = @"net.reyssi.def:MDFPaymentMethodValidatorUSErrorDomain";
NSUInteger const MDFPaymentMethodValidatorUSErrorCode   = 1 << 18;

@implementation MDFPaymentMethodValidatorUS(Validations)

- (void)configureValid:(BOOL *)valid errCode:(NSUInteger *)errCode forResult:(BOOL)result checkCode:(NSUInteger)checkCode
{
    if (valid && *valid)
    {
        *valid = result;
    }
    
    if (errCode && ! result)
    {
        *errCode |= checkCode;
    }
}

- (BOOL)isTargetEmpty:(id)target property:(SEL)selector
{
    if ( ! target)
    {
        return YES;
    }
    
    NSMethodSignature *methodSignature = [target methodSignatureForSelector:selector];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
    [invocation setTarget:target];
    [invocation setSelector:selector];
    [invocation invoke];
    
    id propertyValue;
    [invocation getReturnValue:&propertyValue];
    
    return ([(NSString *)propertyValue length] < 1);
}

- (void)luhnChecksumValid:(BOOL *)valid errCode:(NSUInteger *)errCode
{
    BOOL result = [MDFPaymentCardLuhnChecksum isPaymentCardChecksumValid:[self.paymentMethod paymentCard]];
    
    [self configureValid:valid
                 errCode:errCode
               forResult:result
               checkCode:MDFPaymentMethodValidateOptionsCardLuhnChecksum];
}

- (void)cardHolderNameValid:(BOOL *)valid errCode:(NSUInteger *)errCode
{
    BOOL result = ! ([self isTargetEmpty:[self.paymentMethod paymentCard] property:@selector(cardHolderName)]);
    
    [self configureValid:valid
                 errCode:errCode
               forResult:result
               checkCode:MDFPaymentMethodValidateOptionsCardHolderName];
}

- (void)creditCardNumberValid:(BOOL *)valid errCode:(NSUInteger *)errCode
{
    BOOL result = [[[self.paymentMethod paymentCard] creditCardNumber] length] > 14;

    [self configureValid:valid
                 errCode:errCode
               forResult:result
               checkCode:MDFPaymentMethodValidateOptionsCardNumber];
}

- (void)creditCardVerificationNumberValid:(BOOL *)valid errCode:(NSUInteger *)errCode
{
    NSUInteger ccvLength = [[[self.paymentMethod paymentCard] creditCardVerification] length];
    BOOL result = ((ccvLength > 2) && (ccvLength < 5));
    
    [self configureValid:valid
                 errCode:errCode
               forResult:result
               checkCode:MDFPaymentMethodValidateOptionsCardCCV];
}

- (void)creditCardExpirationDateValid:(BOOL *)valid errCode:(NSUInteger *)errCode
{
    NSDate *expiryDate = [self expriyDateForPaymentCard:[self.paymentMethod paymentCard]];
    BOOL result = ([expiryDate compare:[NSDate date]] == NSOrderedDescending);
    
    [self configureValid:valid
                 errCode:errCode
               forResult:result
               checkCode:MDFPaymentMethodValidateOptionsExpirationDate];
}

- (void)billingPostalCodeValid:(BOOL *)valid errCode:(NSUInteger *)errCode
{
    static NSString *zipCodeRegex = @"^\\d{5}$";
    
    id<MDFPaymentCardBillingAddress> billingAddress = [self.paymentMethod paymentCardBillingAddress];
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:zipCodeRegex
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:nil];

    NSUInteger matches = [regex numberOfMatchesInString:[billingAddress postalCode]
                                                options:0
                                                  range:NSMakeRange(0, [[billingAddress postalCode] length])];
    
    BOOL result = (matches == 1);
    
    [self configureValid:valid
                 errCode:errCode
               forResult:result
               checkCode:MDFPaymentMethodValidateOptionsBillingPostalCode];
}

- (void)streetAddressValid:(BOOL *)valid errCode:(NSUInteger *)errCode
{
    BOOL result = ! ([self isTargetEmpty:[self.paymentMethod paymentCardBillingAddress] property:@selector(streetAddress)]);
    
    [self configureValid:valid
                 errCode:errCode
               forResult:result
               checkCode:MDFPaymentMethodValidateOptionsBillingStreetAddress];
}

- (void)cityNameValid:(BOOL *)valid errCode:(NSUInteger *)errCode
{
    BOOL result = ! ([self isTargetEmpty:[self.paymentMethod paymentCardBillingAddress] property:@selector(city)]);
    
    [self configureValid:valid
                 errCode:errCode
               forResult:result
               checkCode:MDFPaymentMethodValidateOptionsBillingCityName];
}

- (void)stateNameValid:(BOOL *)valid errCode:(NSUInteger *)errCode
{
    static NSString *stateNameRegex = @"^[A-Z]{2}$";
    
    id<MDFPaymentCardBillingAddress> billingAddress = [self.paymentMethod paymentCardBillingAddress];
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:stateNameRegex
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:nil];
    
    NSUInteger matches = [regex numberOfMatchesInString:[billingAddress stateName]
                                                options:0
                                                  range:NSMakeRange(0, [[billingAddress stateName] length])];
    
    BOOL result = (matches == 1);
    
    [self configureValid:valid
                 errCode:errCode
               forResult:result
               checkCode:MDFPaymentMethodValidateOptionsBillingStateName];
}

- (void)unitAddressValid:(BOOL *)valid errCode:(NSUInteger *)errCode
{
    BOOL result = ! ([self isTargetEmpty:[self.paymentMethod paymentCardBillingAddress] property:@selector(stateName)]);

    [self configureValid:valid
                 errCode:errCode
               forResult:result
               checkCode:MDFPaymentMethodValidateOptionsBillingUnitAddress];
}

- (void)countryNameValid:(BOOL *)valid errCode:(NSUInteger *)errCode
{
    BOOL result = ! ([self isTargetEmpty:[self.paymentMethod paymentCardBillingAddress] property:@selector(countryName)]);
    
    [self configureValid:valid
                 errCode:errCode
               forResult:result
               checkCode:MDFPaymentMethodValidateOptionsBillingCountryName];
}

- (void)billingNameValid:(BOOL *)valid errCode:(NSUInteger *)errCode
{
    BOOL result = ! ([self isTargetEmpty:[self.paymentMethod paymentCardBillingAddress] property:@selector(billingName)]);

    [self configureValid:valid
                 errCode:errCode
               forResult:result
               checkCode:MDFPaymentMethodValidateOptionsBillingName];
}

- (NSDate *)expriyDateForPaymentCard:(id<MDFPaymentCard>)paymentCard
{
    NSUInteger year  = [paymentCard expirationDateYear];
    NSUInteger month = [paymentCard expirationDateMonth];
    
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setYear:year];
    [dateComponents setMonth:month];
    [dateComponents setDay:1];
    [dateComponents setHour:0];
    [dateComponents setMinute:0];
    [dateComponents setSecond:0];
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    return [gregorian dateFromComponents:dateComponents];
}

- (BOOL)isPaymentMethodValid:(MDFPaymentMethodValidateOptions)options error:(NSError **)error
{
    BOOL result        = YES;
    NSUInteger errCode = MDFPaymentMethodValidatorUSErrorCode;
    
    if (options & MDFPaymentMethodValidateOptionsCardHolderName)
        [self cardHolderNameValid:&result errCode:&errCode];
    
    if (options & MDFPaymentMethodValidateOptionsCardNumber)
        [self creditCardNumberValid:&result errCode:&errCode];

    if (options & MDFPaymentMethodValidateOptionsCardCCV)
        [self creditCardVerificationNumberValid:&result errCode:&errCode];

    if (options & MDFPaymentMethodValidateOptionsExpirationDate)
        [self creditCardExpirationDateValid:&result errCode:&errCode];

    if (options & MDFPaymentMethodValidateOptionsBillingPostalCode)
        [self billingPostalCodeValid:&result errCode:&errCode];

    if (options & MDFPaymentMethodValidateOptionsBillingStreetAddress)
        [self streetAddressValid:&result errCode:&errCode];

    if (options & MDFPaymentMethodValidateOptionsBillingCityName)
        [self cityNameValid:&result errCode:&errCode];

    if (options & MDFPaymentMethodValidateOptionsBillingStateName)
        [self stateNameValid:&result errCode:&errCode];

    if (options & MDFPaymentMethodValidateOptionsBillingUnitAddress)
        [self unitAddressValid:&result errCode:&errCode];

    if (options & MDFPaymentMethodValidateOptionsBillingCountryName)
        [self countryNameValid:&result errCode:&errCode];

    if (options & MDFPaymentMethodValidateOptionsBillingName)
        [self billingNameValid:&result errCode:&errCode];

    if (options & MDFPaymentMethodValidateOptionsCardLuhnChecksum)
        [self luhnChecksumValid:&result errCode:&errCode];
    
    if (error && ! result)
    {
        *error = [NSError errorWithDomain:MDFPaymentMethodValidatorUSErrorDomain
                                     code:errCode
                                 userInfo:nil];
    }
    
    return result;
}

@end

@implementation MDFPaymentMethodValidatorUS

- (id)initWithPaymentMethod:(id<MDFPaymentMethod>)paymentMethod
{
    self = [super init];
    
    if (self)
    {
        self.paymentMethod = paymentMethod;
    }
    
    return self;
}

- (BOOL)isValidPaymentMethod:(MDFPaymentMethodValidateOptions)options error:(NSError **)error
{
    return [self isPaymentMethodValid:options error:error];
}

- (BOOL)isValidPaymentMethodCheckBasic:(NSError **)error
{
    return NO;
}

- (BOOL)isValidPaymentMethodCheckFull:(NSError **)error
{
    return NO;
}

- (BOOL)isValidLuhnChecksum:(NSError **)error
{
    BOOL result = YES;
    NSUInteger code = MDFPaymentMethodValidatorUSErrorCode;
    [self luhnChecksumValid:&result errCode:&code];
    
    if (error && ! result)
    {
        *error = [NSError errorWithDomain:MDFPaymentMethodValidatorUSErrorDomain
                                     code:code
                                 userInfo:nil];
    }
    
    return result;
}

@end
