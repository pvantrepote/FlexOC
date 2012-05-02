//
//  FlexOCTests.m
//  FlexOCTests
//
//  Created by Pascal Vantrepote on 12-04-09.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//

#import "FlexOCTests.h"

#import "InstanceService.h"
#import "InjectionInstanceService.h"
#import "CircularService1.h"
#import "CircularService2.h"
#import "NestedService.h"

#import "ObjectProxy.h"

@implementation FlexOCTests

- (void)setUp {
    [super setUp];
	
	NSBundle* main = [NSBundle bundleForClass:[self class]];
	NSString* path = [main pathForResource:@"Context" ofType:@"plist"];
	context = [[pListApplicationContext alloc] initWithPListAtPath:path];
	
	path = [main pathForResource:@"context" ofType:@"xml"];
}

- (void)tearDown {
    // Tear-down code here.
    [super tearDown];
}

-(void) testArray {
	NSArray* list = [context getObjectWithName:@"list"];
	STAssertNotNil(list, @"List should not be nil");
	STAssertTrue([[list objectAtIndex:0] isEqualToString:@"one"], @"One should be one.");
	STAssertTrue([[list objectAtIndex:1] isEqualToString:@"two"], @"two should be two.");
	STAssertTrue([[list objectAtIndex:2] isEqualToString:@"three"], @"three should be three.");
}

-(void) testDictionary {
	NSDictionary* dict = [context getObjectWithName:@"dictionary"];
	STAssertNotNil(dict, @"Dictionary should not be nil");
	STAssertTrue([[dict objectForKey:@"one"] isEqualToString:@"one"], @"One should be one.");
	STAssertTrue([[dict objectForKey:@"two"] isEqualToString:@"two"], @"two should be two.");
	STAssertTrue([[dict objectForKey:@"three"] isEqualToString:@"three"], @"three should be three.");
}

-(void) testNestedObject {
	NestedService* s1 = [context getObjectWithName:@"nestedService"];
	STAssertNotNil(s1, @"Service should not be nil");
	STAssertNotNil(s1.service, @"Service should not be nil");
	STAssertTrue([s1.service.stringFromContext isEqualToString:@"A value from context"], @"stringFromContext should be equal to A value from context");
}

-(void) testCircularDisable {
	CircularService1* s1 = [context getObjectWithName:@"circularService1"];
	STAssertNotNil(s1, @"Service should not be nil");
	STAssertNotNil(s1.service, @"Service should not be nil");
	STAssertNil(s1.service.service, @"Service should be nil");
}

-(void) testCircularEnabled {
	/// Load a circular context
	NSBundle* main = [NSBundle bundleForClass:[self class]];
	NSString* path = [main pathForResource:@"CircularContext" ofType:@"plist"];
	pListApplicationContext* circularContext = [[pListApplicationContext alloc] initWithPListAtPath:path];
	
	CircularService1* s1 = [circularContext getObjectWithName:@"circularService1"];
	STAssertNotNil(s1, @"Service should not be nil");
	STAssertNotNil(s1.service, @"Service should not be nil");
	STAssertNotNil(s1.service.service, @"Service should not be nil");
}

- (void) testInstance {
    id<IInstanceService> service = [context getObjectWithName:@"instanceService"];
	STAssertNotNil(service, @"Service should not be nil");
	STAssertTrue([service.stringFromContext isEqualToString:@"A value from context"], @"stringFromContext should be equal to A value from context");
	
	id<IInstanceService> otherService = [context getObjectWithName:@"instanceService"];
	STAssertNotNil(otherService, @"Service should not be nil");
	STAssertTrue([otherService.stringFromContext isEqualToString:@"A value from context"], @"stringFromContext should be equal to A value from context");
	
	STAssertFalse(otherService == service, @"Service should not be equal");
}

- (void) testInstanceConstructor {
    id<IInstanceService> service = [context getObjectWithName:@"instanceServiceConstructor"];
	STAssertNotNil(service, @"Service should not be nil");
	STAssertTrue([service.stringFromContext isEqualToString:@"A value from context"], @"stringFromContext should be equal to A value from context");
	STAssertTrue(service.valueFromContext.integerValue == 5, @"valueFromContext should be equal to 5");
	
	id<IInstanceService> otherService = [context getObjectWithName:@"instanceServiceConstructor"];
	STAssertNotNil(otherService, @"Service should not be nil");
	STAssertTrue([otherService.stringFromContext isEqualToString:@"A value from context"], @"stringFromContext should be equal to A value from context");
	STAssertTrue(otherService.valueFromContext.integerValue == 5, @"valueFromContext should be equal to 5");
	
	STAssertFalse(otherService == service, @"Service should not be equal");
}

-(void) testSingleton {
    id<IInstanceService> service = [context getObjectWithName:@"singletonInstanceService"];
	STAssertNotNil(service, @"Service should not be nil");
	STAssertTrue([service.stringFromContext isEqualToString:@"A value from context"], @"stringFromContext should be equal to A value from context");
	
	id<IInstanceService> otherService = [context getObjectWithName:@"singletonInstanceService"];
	STAssertNotNil(otherService, @"Service should not be nil");
	STAssertTrue([otherService.stringFromContext isEqualToString:@"A value from context"], @"stringFromContext should be equal to A value from context");
	
	STAssertTrue(otherService == service, @"Service should be equal");
}

-(void) testInjections {
	InjectionInstanceService* service = [context getObjectWithName:@"instanceInjectionService"];
	STAssertNotNil(service, @"Service should not be nil");
	STAssertNotNil(service.anInstanceService, @"Service should not be nil");
	STAssertTrue([service.anInstanceService.stringFromContext isEqualToString:@"A value from context"], @"stringFromContext should be equal to A value from context");

	InjectionInstanceService* otherService = [context getObjectWithName:@"instanceInjectionService"];
	STAssertNotNil(otherService, @"Service should not be nil");
	STAssertNotNil(otherService.anInstanceService, @"Service should not be nil");
	STAssertTrue([otherService.anInstanceService.stringFromContext isEqualToString:@"A value from context"], @"stringFromContext should be equal to A value from context");
	
	STAssertFalse(otherService == service, @"Service should not be equal");
}

-(void) testSingletonInjections {
	InjectionInstanceService* service = [context getObjectWithName:@"instanceSingletonInjectionService"];
	STAssertNotNil(service, @"Service should not be nil");
	STAssertNotNil(service.anInstanceService, @"Service should not be nil");
	STAssertTrue([service.anInstanceService.stringFromContext isEqualToString:@"A value from context"], @"stringFromContext should be equal to A value from context");
	
	InjectionInstanceService* otherService = [context getObjectWithName:@"instanceSingletonInjectionService"];
	STAssertNotNil(otherService, @"Service should not be nil");
	STAssertNotNil(otherService.anInstanceService, @"Service should not be nil");
	STAssertTrue([otherService.anInstanceService.stringFromContext isEqualToString:@"A value from context"], @"stringFromContext should be equal to A value from context");
	
	STAssertTrue(otherService.anInstanceService == service.anInstanceService, @"Service should be equal");
	STAssertFalse(otherService == service, @"Service should not be equal");
}

@end
