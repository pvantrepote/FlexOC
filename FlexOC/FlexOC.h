//
//  FlexOC.h
//  FlexOC
//
//  Created by Pascal Vantrepote on 12-05-19.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//

#ifdef FLEXOC_STATIC_LIB

#import <FlexOC/AOP/IMessageMatcher.h>
#import <FlexOC/AOP/IAdvisor.h>
#import <FlexOC/AOP/IPointcut.h>

#import <FlexOC/Core/Caching/ICache.h>
#import <FlexOC/Core/Caching/ICachePolicy.h>
#import <FlexOC/Core/Proxy/ObjectProxy.h>
#import <FlexOC/Core/Objects/Factory/IObjectFactory.h>
#import <FlexOC/Core/Context/IApplicationContext.h>

#else

#import <FlexOC/IMessageMatcher.h>
#import <FlexOC/IAdvisor.h>
#import <FlexOC/IPointcut.h>

#import <FlexOC/ICache.h>
#import <FlexOC/ICachePolicy.h>
#import <FlexOC/ObjectProxy.h>
#import <FlexOC/IObjectFactory.h>
#import <FlexOC/IApplicationContext.h>

#endif