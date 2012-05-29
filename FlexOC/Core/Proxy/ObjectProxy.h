//
//  ObjectProxy.h
//  FlexOC
//
//  Created by Pascal Vantrepote on 12-05-01.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifdef FLEXOC_STATIC_LIB
#import <FlexOC/Core/Proxy/IObjectProxy.h>
#else
#import <FlexOC/IObjectProxy.h>
#endif

@interface ObjectProxy : NSObject<IObjectProxy>

@property (nonatomic, retain) NSObject* target;

@end
