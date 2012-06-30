//
//  CalculatorTests.m
//  CalculatorTests
//
//  Created by Chris Rittelmeyer on 6/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CalculatorTests.h"
#import "CalculatorBrain.h"

@implementation CalculatorTests

static CalculatorBrain *brain;

- (void)setUp
{
    [super setUp];
    
    brain = [[CalculatorBrain alloc] init];
    NSLog(@"Test setUp : fresh brain (yum)");
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testPopOnNewBrain
{
    double d = [brain performOperation:@"+"];
    STAssertEqualsWithAccuracy(d, 0.0, 0.000001, @"pop on empty stack should be zero");
}

- (void)testPopOneOperand
{
    [brain pushOperand:99.99];
    double d = [brain performOperation:@"+"];
    STAssertEqualsWithAccuracy(d, 99.99, 0.000001, @"pop after push should return pushed operand");
}

- (void)testPerformValueAfterOperation
{
    [brain pushOperand:1.2];
    [brain pushOperand:3.4];
    double d = [brain performOperation:@"+"];
    STAssertEqualsWithAccuracy(d, 4.6, 0.000001, @"perform should return the correct value");
}

- (void)testPopValueAfterOperation
{
    [brain pushOperand:1.2];
    [brain pushOperand:3.4];
    [brain performOperation:@"+"];
    double d = [brain performOperation:@"+"];
    STAssertEqualsWithAccuracy(d, 4.6, 0.000001, @"pop after perform should return correct value");
}

//- (void)testPopOnNewBrain
//{
//    double d = [brain popOperand];
//    STAssertEqualsWithAccuracy(d, 0.0, 0.000001, @"pop on empty stack should be zero");
//}
//
//- (void)testPopOneOperand
//{
//    [brain pushOperand:99.99];
//    double d = [brain popOperand];
//    STAssertEqualsWithAccuracy(d, 99.99, 0.000001, @"pop after push should return pushed operand");
//}
//
//- (void)testPerformValueAfterOperation
//{
//    [brain pushOperand:1.2];
//    [brain pushOperand:3.4];
//    double d = [brain performOperation:@"+"];
//    STAssertEqualsWithAccuracy(d, 4.6, 0.000001, @"perform should return the correct value");
//}
//
//- (void)testPopValueAfterOperation
//{
//    [brain pushOperand:1.2];
//    [brain pushOperand:3.4];
//    [brain performOperation:@"+"];
//    double d = [brain popOperand];
//    STAssertEqualsWithAccuracy(d, 4.6, 0.000001, @"pop after perform should return correct value");
//}

@end
