//
//  FlexOCXmlTest.m
//  FlexOC
//
//  Created by Pascal Vantrepote on 12-04-16.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//

#import "FlexOCXmlTest.h"

#import "InstanceService.h"
#import "InjectionInstanceService.h"
#import "CircularService1.h"
#import "CircularService2.h"
#import "NestedService.h"
#import "InstanceContainer.h"
#import <FlexOC/Core/Proxy/LazyObjectProxy.h>
#import <FlexOC/Core/Objects/Factory/IObjectNameAware.h>
#import <FlexOC/Core/Context/IApplicationContextAware.h>

@implementation FlexOCXmlTest

- (void)setUp {
    [super setUp];
		
	NSBundle* main = [NSBundle bundleForClass:[self class]];
	NSString* path = [main pathForResource:@"context" ofType:@"xml"];
	context = [[XmlApplicationContext alloc] initWithXmlAtFilepath:path];
}

-(void) testContainer {
	InstanceContainer* instance = [context getObjectWithName:@"instanceContainer"];
	STAssertNotNil(instance, @"Instance should not be nil");
	STAssertNotNil(instance.dictionary, @"Dictionary should not be nil");
	STAssertTrue([[instance.dictionary objectForKey:@"one"] isEqualToString:@"one"], @"One should be one.");
	STAssertTrue([[instance.dictionary objectForKey:@"two"] isEqualToString:@"two"], @"two should be two.");
	STAssertTrue([[instance.dictionary objectForKey:@"three"] isEqualToString:@"three"], @"three should be three.");
	STAssertNotNil(instance.list, @"List should not be nil");
	STAssertTrue([[instance.list objectAtIndex:0] isEqualToString:@"one"], @"One should be one.");
	STAssertTrue([[instance.list objectAtIndex:1] isEqualToString:@"two"], @"two should be two.");
	STAssertTrue([[instance.list objectAtIndex:2] isEqualToString:@"three"], @"three should be three.");
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
	NSString* path = [main pathForResource:@"Circularcontext" ofType:@"xml"];
	XmlApplicationContext* circularContext = [[XmlApplicationContext alloc] initWithXmlAtFilepath:path];
	
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

- (void) testLazyInstanceSerialization {
    id<IInstanceService> service = [context getObjectWithName:@"lazyInstanceService"];
	STAssertNotNil(service, @"Service should not be nil");
	STAssertTrue([service isKindOfClass:[LazyObjectProxy class]], @"Service should be type of LazyObjectProxy.");
	STAssertTrue([service.stringFromContext isEqualToString:@"A value from context"], @"stringFromContext should be equal to A value from context");
	
	NSData* data = [NSKeyedArchiver archivedDataWithRootObject:service];
	STAssertNotNil(data, @"Data shouldn't be nil");
	
	id<IInstanceService> otherService = [NSKeyedUnarchiver unarchiveObjectWithData:data];
	STAssertNotNil(otherService, @"Service should not be nil");
	STAssertTrue([otherService.stringFromContext isEqualToString:@"A value from context"], @"stringFromContext should be equal to A value from context");
	
	STAssertFalse(otherService == service, @"Service should not be equal");
}


- (void) testLazyInstance {
    id<IInstanceService> service = [context getObjectWithName:@"lazyInstanceService"];
	STAssertNotNil(service, @"Service should not be nil");
	STAssertTrue([service isKindOfClass:[LazyObjectProxy class]], @"Service should be type of LazyObjectProxy.");
	STAssertTrue([service.stringFromContext isEqualToString:@"A value from context"], @"stringFromContext should be equal to A value from context");
	
	id<IInstanceService> otherService = [context getObjectWithName:@"lazyInstanceService"];
	STAssertNotNil(otherService, @"Service should not be nil");
	STAssertTrue([otherService isKindOfClass:[LazyObjectProxy class]], @"Service should be type of LazyObjectProxy.");
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

-(void) testObjectNameAware {
	id<IInstanceService, IObjectNameAware> service = [context getObjectWithName:@"instanceServiceNameAware"];
	STAssertNotNil(service, @"Service should not be nil");
	STAssertTrue([service.stringFromContext isEqualToString:@"A value from context"], @"stringFromContext should be equal to A value from context");
	STAssertTrue([service.name isEqualToString:@"instanceServiceNameAware"], @"name should be equal to instanceServiceNameAware");
}

-(void) testApplicationContextAware {
	id<IInstanceService, IApplicationContextAware> service = [context getObjectWithName:@"instanceServiceContextAware"];
	STAssertNotNil(service, @"Service should not be nil");
	STAssertTrue([service.stringFromContext isEqualToString:@"A value from context"], @"stringFromContext should be equal to A value from context");
	STAssertTrue([service.context isEqual:context], @"contexts should be equal");
}

@end
