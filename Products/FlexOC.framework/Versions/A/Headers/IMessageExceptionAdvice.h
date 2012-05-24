//
//  IMessageExceptionAdvice.h
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

@protocol IMessageExceptionAdvice <IAdvice>

-(void) exception:(NSException*) exception duringInvocation:(NSInvocation*) invocation withTarget:(id) target;

@end
