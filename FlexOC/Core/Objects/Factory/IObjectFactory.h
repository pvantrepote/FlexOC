//
//  IObjectFactory.h
//  FlexOC
//
//  Created by Pascal Vantrepote on 12-04-09.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IObjectDefinition;

@protocol IObjectFactory <NSObject>

-(BOOL) configureObject:(id<NSObject>) object withName:(NSString*) objectName;
-(id) getObjectWithName:(NSString*) objectName andDefinition:(id<IObjectDefinition>) objectDefinition;
-(id) getObjectWithName:(NSString*) objectName;

@end
