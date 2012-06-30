//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Chris Rittelmeyer on 6/22/12.
//  Copyright (c) 2012 Floating Tree, Inc. All rights reserved.
//

#import "CalculatorViewController.h"
#import "CalculatorBrain.h"
#import "Math.h"

@interface CalculatorViewController()
@property (nonatomic) BOOL userIsInTheMiddleOfEnteringANumber;
@property (nonatomic, strong) CalculatorBrain *brain;
@end

@implementation CalculatorViewController

@synthesize display = _display;
@synthesize history = _history;
@synthesize userIsInTheMiddleOfEnteringANumber = _userIsInTheMiddleOfEnteringANumber;
@synthesize brain = _brain;

- (CalculatorBrain *)brain {
    if (!_brain) _brain = [[CalculatorBrain alloc] init];
    return _brain;
}

- (IBAction)digitPressed:(UIButton *)sender {
    self.history.text = [self.history.text stringByReplacingOccurrencesOfString:@"=" withString:@""];
    
    NSString *digit = sender.currentTitle;
    
    if (self.userIsInTheMiddleOfEnteringANumber) {
        self.display.text = [self.display.text stringByAppendingString:digit];
    } else {
        self.display.text = digit;
        self.userIsInTheMiddleOfEnteringANumber = YES;
    }
}
- (IBAction)enterPressed {
    [self.brain pushOperand:[self.display.text doubleValue]];
    self.userIsInTheMiddleOfEnteringANumber = NO;

    if ([self.history.text rangeOfString:@"="].location != NSNotFound) {
        self.history.text = [self.history.text substringToIndex:self.history.text.length - 1];
    }
    self.history.text = [self.history.text stringByAppendingFormat:@"%@ ", self.display.text];

}
- (IBAction)operationPressed:(UIButton *)sender {
    if ([sender.currentTitle isEqualToString:@"+ / -"]) {
        double negatedValue = -([self.display.text doubleValue]);
        self.display.text = [NSString stringWithFormat:@"%g", negatedValue];
    } else {
        if (self.userIsInTheMiddleOfEnteringANumber) [self enterPressed];
        double result = [self.brain performOperation:sender.currentTitle];
        NSString *resultString = [NSString stringWithFormat:@"%g", result];
        self.display.text = resultString;
        
        self.history.text = [self.history.text stringByAppendingFormat:@"%@ ", sender.currentTitle];
        self.history.text = [self.history.text stringByAppendingString:@"="];
    }
}
- (IBAction)decimalPressed {
    if ([self.display.text rangeOfString:@"."].location == NSNotFound) {
        self.userIsInTheMiddleOfEnteringANumber = YES;
        self.display.text = [self.display.text stringByAppendingString:@"."];
    }
}
- (IBAction)clearPressed {
    self.display.text = @"0";
    self.history.text = @"";
    self.userIsInTheMiddleOfEnteringANumber = NO;
    [self.brain clearStack];
}
- (IBAction)backspacePressed {
    if (self.userIsInTheMiddleOfEnteringANumber) {
        self.display.text = [self.display.text substringToIndex:self.display.text.length-1];
    }
    if ([self.display.text isEqualToString:@""]) {
        self.display.text = @"0";
        self.userIsInTheMiddleOfEnteringANumber = NO;
    }
}

@end