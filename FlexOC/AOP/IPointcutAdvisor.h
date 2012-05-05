//
//  IPointcutAdvisor.h
//  FlexOC
//
//  Created by Pascal Vantrepote on 12-05-02.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <FlexOC/AOP/IAdvisor.h>
@protocol IPointcut;

@protocol IPointcutAdvisor <IAdvisor>

@property (nonatomic, retain) id<IPointcut> pointcut;

@end
