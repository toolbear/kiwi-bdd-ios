//
//  KBDMoney.h
//  kiwi-bdd-ios
//
//  Created by Tim Taylor on 6/21/12.
//  Copyright (c) 2012 BearProg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KBDMoney : NSObject

@property (readonly) NSInteger amount;
@property (readonly, strong, nonatomic) NSString *currency;

- (id)initWithAmount:(NSInteger)amount currency:(NSString*)currency;

- (KBDMoney*)moneyByMultiplying:(NSInteger)scale;

@end
