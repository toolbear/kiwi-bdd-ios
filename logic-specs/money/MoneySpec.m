@interface KBDCurrencyConverter : NSObject

- (NSNumber*)convertAmount:(NSNumber*)amount
                     from:(NSString*)from
                       to:(NSString*)to;

@end

@implementation KBDCurrencyConverter

- (NSNumber*)convertAmount:(NSNumber*)amount
                      from:(NSString*)from
                        to:(NSString*)to
{
  return nil;
}

@end

@interface KBDMoney : NSObject
@property (readonly, strong, nonatomic) NSNumber *amount;
@property (readonly, strong, nonatomic) NSString *currency;

- (id)initWithAmount:(NSNumber*)amount;
- (id)initWithAmount:(NSNumber*)amount currency:(NSString*)currency;

- (KBDMoney*)plus:(KBDMoney*)other;
- (KBDMoney*)convertTo:(NSString*)currency
             converter:(KBDCurrencyConverter*)converter;
@end

@implementation KBDMoney
@synthesize amount;

- (id)initWithAmount:(NSNumber *)a
{
  if (self = [super init]) {
    amount = a;
  }
  return self;
}

- (id)initWithAmount:(NSNumber *)a currency:(NSString *)c
{
  if (self = [super init]) {
    amount = a;
  }
  return self;
}

- (KBDMoney *)plus:(KBDMoney *)other
{
  int n = [self.amount intValue] + [other.amount intValue];
  return [[KBDMoney alloc] initWithAmount:[NSNumber numberWithInt:n]];
}

- (KBDMoney*)convertTo:(NSString*)currency
             converter:(KBDCurrencyConverter*)converter
{
  NSNumber *convertedAmount = [converter convertAmount:nil from:nil to:nil];
  return [[KBDMoney alloc] initWithAmount:convertedAmount
                                currency:nil];
}

@end

SPEC_BEGIN(MoneySpec)

describe(@"money", ^{
  __block KBDMoney *money;

  beforeEach(^{
    money = nil;
  });
  
  context(@"when nil", ^{
    it(@"should be 0 dollars", ^{
      [money.amount shouldBeNil];
    });
  });
  
  context(@"when one dollar", ^{
    KBDMoney *oneDollar = [[KBDMoney alloc] initWithAmount:[NSNumber numberWithInt:1]];
    
    beforeEach(^{
      money = oneDollar;
    });
    
    it(@"can hold a numeric amount", ^{
      [[theValue([money.amount intValue]) should] equal:theValue(1)];
    });
    
    it(@"can be added", ^{
      [[theValue([[money plus:oneDollar].amount intValue]) should] equal:theValue(2)];
    });
  });
  
  describe(@"currency conversions", ^{
    KBDMoney *threeUSD = [[KBDMoney alloc] initWithAmount:[NSNumber numberWithInt:3]
                                                 currency:@"USD"];
    __block KBDCurrencyConverter *converter;
    
    beforeEach(^{
      converter = [KBDCurrencyConverter nullMock];
    });
    
    it(@"uses converter for amount conversions", ^{
      NSNumber *six = [NSNumber numberWithInt:6];
      [converter stub:@selector(convertAmount:from:to:) andReturn:six];
            
      KBDMoney *asCDN = [threeUSD convertTo:@"CDN" converter:converter];
      
      [[theValue([asCDN.amount intValue]) should] equal:theValue(6)];
    });

    it(@"has converted to currency", ^{
      KBDMoney *asCDN = [threeUSD convertTo:@"CDN" converter:converter];
      [[asCDN.currency should] equal:@"CDN"];
    });

    it(@"converts our amount", ^{
      [[converter should] receive:@selector(convertAmount:from:to:)
                    withArguments:[NSNumber numberWithInt:3], @"USD", @"CDN"];
      
      [threeUSD convertTo:@"CDN" converter:converter];
    });
  });
});

SPEC_END