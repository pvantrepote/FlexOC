//
//  TestExceptionAdvisor.h
//  FlexOC
//
//  Created by Pascal Vantrepote on 12-05-17.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TestExceptionAdvisor : NSObject<IPointcutAdvisor, IMessageAfterAdvice, IMessageBeforeAdvice>

@end
