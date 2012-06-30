//
//  CalculatorBrain.h
//  Calculator
//
//  Created by Chris Rittelmeyer on 6/22/12.
//  Copyright (c) 2012 Floating Tree. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject

- (void)pushOperand:(double)operand;
- (double)performOperation:(NSString *)operation;
- (void)clearStack;

@end
