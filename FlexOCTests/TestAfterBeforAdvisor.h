//
//  TestAfterBeforAdvisor.h
//  FlexOC
//
//  Created by Pascal Vantrepote on 12-05-05.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//

#import <FlexOC/AOP/IPointcutAdvisor.h>
#import <FlexOC/AOP/IMessageBeforeAdvice.h>
#import <FlexOC/AOP/IMessageAfterAdvice.h>

@interface TestAfterBeforAdvisor : NSObject<IPointcutAdvisor, IMessageAfterAdvice, IMessageBeforeAdvice> {
	@private
	BOOL didBefore;
	BOOL didAfter;
}

@property (nonatomic, readonly) BOOL didBefore;
@property (nonatomic, readonly) BOOL didAfter;


@end
