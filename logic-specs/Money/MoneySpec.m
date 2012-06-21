#import "KBDMoney.h"

SPEC_BEGIN(MoneySpec)

describe(@"money created with an amount", ^{
  KBDMoney *oneDollar = [[KBDMoney alloc] initWithAmount:1 currency:nil];

  it(@"has the amount it was created with", ^{
    [[theValue(oneDollar.amount) should] equal:theValue(1)];
  });
  
  it(@"can be multiplied", ^{
    KBDMoney *result = [oneDollar moneyByMultiplying:3];
    [[theValue(result.amount) should] equal:theValue(3)];
  });
});

describe(@"money created with a currency", ^{
  it(@"has the currency it was created with", ^{
    KBDMoney *oneDollar = [[KBDMoney alloc] initWithAmount:1
                                                  currency:@"USD"];
    [[oneDollar.currency should] equal:@"USD"];
  });
  
  it(@"multiplying preserves currency", ^{
    KBDMoney *oneDollar = [[KBDMoney alloc] initWithAmount:1
                                                  currency:@"USD"];
    KBDMoney *result = [oneDollar moneyByMultiplying:0];
    [[result.currency should] equal:@"USD"];
  });
});

SPEC_END