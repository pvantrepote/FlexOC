//
//  TestExceptionAdvisor.h
//  FlexOC
//
//  Created by Pascal Vantrepote on 12-05-17.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//

#import <FlexOC/AOP/IPointcutAdvisor.h>
#import <FlexOC/AOP/IMessageExceptionAdvice.h>

@interface TestExceptionAdvisor : NSObject<IPointcutAdvisor, IMessageExceptionAdvice>

@property (nonatomic, retain) NSException* exception;

@end
