//
//  IExceptionAdvice.h
//  FlexOC
//
//  Created by Pascal Vantrepote on 12-05-05.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//

#import <FlexOC/AOP/IAdvice.h>

@protocol IExceptionAdvice <IAdvice>

-(void) exception:(NSException*) exception duringInvocation:(NSInvocation*) invocation withTarget:(id) target;

@end
