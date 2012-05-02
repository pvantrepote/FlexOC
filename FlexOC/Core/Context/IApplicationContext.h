//
//  IApplicationContext.h
//  FlexOC
//
//  Created by Pascal Vantrepote on 12-04-09.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <FlexOC/Core/Objects/Factory/IObjectFactory.h>

@protocol IApplicationContext <IObjectFactory>

@property (nonatomic, assign) BOOL allowCircularDependencies;

-(void) mergeWithContext:(id<IApplicationContext>) context;

@end

@interface IApplicationContext : NSObject

+(id<IApplicationContext>) ApplicationContextFromFilepath:(NSString*) filepath;
+(id<IApplicationContext>) sharedApplicationContext;

@end
