//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Chris Rittelmeyer on 6/22/12.
//  Copyright (c) 2012 Floating Tree. All rights reserved.
//

#import "CalculatorBrain.h"
#import "Math.h"

@interface CalculatorBrain()
@property (nonatomic, strong) NSMutableArray *operandStack;
@end

@implementation CalculatorBrain

@synthesize operandStack = _operandStack;

- (NSMutableArray *)operandStack {
    if (_operandStack == nil) _operandStack = [[NSMutableArray alloc] init];
    return _operandStack;
}
- (void)setOperandStack:(NSMutableArray *)operandStack {
    _operandStack = operandStack;
}

- (void)pushOperand:(double)operand {
    [self.operandStack addObject:[NSNumber numberWithDouble:operand]];
}


- (double)popOperand {
    NSNumber *operandObject = [self.operandStack lastObject];
    if (operandObject) [self.operandStack removeLastObject];
    return [operandObject doubleValue];
}

- (double)performOperation:(NSString *)operation {
    double result = 0;
    
    if ([operation isEqualToString:@"+"]) {
        result = [self popOperand] + [self popOperand];
    } else if ([operation isEqualToString:@"*"]) {
        result = [self popOperand] * [self popOperand];
    } else if ([operation isEqualToString:@"-"]) {
        double subtrahend = [self popOperand];
        result = [self popOperand] - subtrahend;
    } else if ([operation isEqualToString:@"/"]) {
        double divisor = [self popOperand];
        if (divisor == 0) {
            result = [self popOperand];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Division by zero is impossible" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
        else result = [self popOperand] / divisor;
    } else if ([operation isEqualToString:@"sin"]) {
        result = sin([self popOperand]);
    } else if ([operation isEqualToString:@"cos"]) {
        result = cos([self popOperand]);
    } else if ([operation isEqualToString:@"tan"]) {
        result = tan([self popOperand]);
    } else if ([operation isEqualToString:@"√"]) {
        result = sqrt([self popOperand]);
    } else if ([operation isEqualToString:@"log"]) {
        result = log([self popOperand]);
    } else if ([operation isEqualToString:@"+ / -"]) {
        result = -([self popOperand]);
    } else if ([operation isEqualToString:@"π"]) {
        result = M_PI;
    } else if ([operation isEqualToString:@"e"]) {
        result = M_E;
        
    }
    
    [self pushOperand:result];
    
    return result;
}

- (void)clearStack {
    [self setOperandStack:nil];
}

@end
