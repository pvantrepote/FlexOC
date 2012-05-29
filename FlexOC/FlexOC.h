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
#import <FlexOC/Core/Proxy/IObjectProxy.h>
#import <FlexOC/Core/Context/IApplicationContext.h>
#import <FlexOC/Core/Context/IApplicationContextAware.h>
#import <FlexOC/Core/Objects/Definition/IObjectDefinition.h>
#import <FlexOC/Core/Objects/Definition/IObjectFactoryDefinition.h>
#import <FlexOC/Core/Objects/Definition/IObjectInitDefinition.h>
#import <FlexOC/Core/Objects/Definition/IObjectValueDefinition.h>
#import <FlexOC/Core/Context/Annotations/IAnnotations.h>
#import <FlexOC/Core/Objects/Factory/IObjectFactory.h>

#import <FlexOC/Core/Proxy/ObjectProxy.h>
#import <FlexOC/Core/Proxy/LazyObjectProxy.h>
#import <FlexOC/AOP/Support/AOPProxy.h>
#import <FlexOC/Core/Context/ApplicationContext.h>
#import <FlexOC/Core/Context/XmlApplicationContext.h>
#import <FlexOC/Core/Context/pListApplicationContext.h>

#import <FlexOC/Application/iOS/FlexOCApplication.h>

#else

#import <FlexOC/IMessageMatcher.h>
#import <FlexOC/IAdvisor.h>
#import <FlexOC/IPointcut.h>
#import <FlexOC/IObjectProxy.h>
#import <FlexOC/IObjectFactory.h>
#import <FlexOC/IApplicationContext.h>
#import <FlexOC/IApplicationContextAware.h>
#import <FlexOC/ICache.h>
#import <FlexOC/ICachePolicy.h>
#import <FlexOC/IObjectDefinition.h>
#import <FlexOC/IObjectFactoryDefinition.h>
#import <FlexOC/IObjectInitDefinition.h>
#import <FlexOC/IObjectValueDefinition.h>
#import <FlexOC/IAnnotations.h>

#import <FlexOC/ObjectProxy.h>
#import <FlexOC/LazyObjectProxy.h>
#import <FlexOC/AOPProxy.h>
#import <FlexOC/ApplicationContext.h>
#import <FlexOC/XmlApplicationContext.h>
#import <FlexOC/DictionaryApplicationContext.h>
#import <FlexOC/pListApplicationContext.h>

#import <FlexOC/FlexOCApplication.h>

#endif