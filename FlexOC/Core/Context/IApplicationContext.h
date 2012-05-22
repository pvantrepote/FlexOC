//
//  IApplicationContext.h
//  FlexOC
//
//  Created by Pascal Vantrepote on 12-04-09.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifdef FLEXOC_STATIC_LIB
#import <FlexOC/Core/Objects/Factory/IObjectFactory.h>
#else
#import <FlexOC/FlexOC.h>
#endif

@protocol IApplicationContext <IObjectFactory>

@property (nonatomic, assign) BOOL allowCircularDependencies;

-(void) mergeWithContext:(id<IApplicationContext>) context;

@end

@interface IApplicationContext : NSObject

+(id<IApplicationContext>) ApplicationContextFromLocation:(NSString*) location;
+(id<IApplicationContext>) sharedApplicationContext;

@end
