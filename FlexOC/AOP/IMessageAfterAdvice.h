//
//  IMessageAfterAdvice.h
//  FlexOC
//
//  Created by Pascal Vantrepote on 12-05-05.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//

#import <FlexOC/AOP/IAdvice.h>

@protocol IMessageAfterAdvice <IAdvice>

-(void) afterInvocation:(NSInvocation*) invocation withTarget:(id) target;

@end
