//
//  IMessageAfterAdvice.h
//  FlexOC
//
//  Created by Pascal Vantrepote on 12-05-05.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//

#ifdef FLEXOC_STATIC_LIB
#import <FlexOC/AOP/IAdvice.h>
#else
#import <FlexOC/IAdvice.h>
#endif

@protocol IMessageAfterAdvice <IAdvice>

-(void) afterInvocation:(NSInvocation*) invocation withTarget:(id) target;

@end
