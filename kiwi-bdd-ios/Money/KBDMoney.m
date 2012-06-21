//
//  KBDMoney.m
//  kiwi-bdd-ios
//
//  Created by Tim Taylor on 6/21/12.
//  Copyright (c) 2012 BearProg. All rights reserved.
//

#import "KBDMoney.h"

@implementation KBDMoney

@synthesize amount = _amount;
@synthesize currency = _currency;

- (id)initWithAmount:(NSInteger)amount
{
  if (self = [super init]) {
    _amount = amount;
  }
  return self;
}

- (id)initWithAmount:(NSInteger)amount currency:(NSString *)currency
{
  if (self = [super init]) {
    _amount = amount;
    _currency = currency;
  }
  return self;
}

- (KBDMoney *)moneyByMultiplying:(NSInteger)scale
{
  return [[KBDMoney alloc] initWithAmount:self.amount * scale
                                 currency:self.currency];
}

@end
