@interface KBDMoney : NSObject
@property (readonly, strong, nonatomic) NSNumber *amount;

- (id)initWithAmount:(NSNumber*)amount;

- (KBDMoney*)plus:(KBDMoney*)other;
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

- (KBDMoney *)plus:(KBDMoney *)other
{
  int n = [self.amount intValue] + [other.amount intValue];
  return [[KBDMoney alloc] initWithAmount:[NSNumber numberWithInt:n]];
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
  
});

SPEC_END