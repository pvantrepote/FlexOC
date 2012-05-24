//
//  IObjectDefinition.h
//  FlexOC
//
//  Created by Pascal Vantrepote on 12-05-19.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IObjectFactoryDefinition;
@protocol IObjectInitDefinition;

@protocol IObjectDefinition <NSObject>

@property (nonatomic, retain) NSString* name;
@property (nonatomic, retain) NSString* type;

@property (nonatomic, assign) BOOL isSingleton;
@property (nonatomic, assign) BOOL isLazy;

@property (nonatomic, retain) id<IObjectFactoryDefinition> factory;
@property (nonatomic, retain) id<IObjectInitDefinition> initializer;

@property (nonatomic, retain) NSMutableDictionary* properties;

@end