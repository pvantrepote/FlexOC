//
//  AuditAdvisor.h
//  UIInjection
//
//  Created by Pascal Vantrepote on 12-05-28.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <FlexOC/AOP/IPointcutAdvisor.h>
#import <FlexOC/AOP/IMessageBeforeAdvice.h>
#import <FlexOC/AOP/IMessageAfterAdvice.h>

@interface AuditAdvisor : NSObject<IPointcutAdvisor, IMessageAfterAdvice, IMessageBeforeAdvice>

@end
