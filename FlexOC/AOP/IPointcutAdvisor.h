//
//  IPointcutAdvisor.h
//  FlexOC
//
//  Created by Pascal Vantrepote on 12-05-02.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//

#ifdef FLEXOC_STATIC_LIB
#import <FlexOC/AOP/IAdvisor.h>
#else
#import <FlexOC/FlexOC.h>
#endif

@protocol IPointcut;

@protocol IPointcutAdvisor <IAdvisor>

@property (nonatomic, retain) id<IPointcut> pointcut;

@end
