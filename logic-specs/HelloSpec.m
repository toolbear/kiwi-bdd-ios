SPEC_BEGIN(HelloSpec)

describe(@"a passing spec", ^{
  it(@"should pass", ^{
    [[theValue(YES) should] beYes];  
  });
});

SPEC_END