//
//  TruePointcut.h
//  FlexOC
//
//  Created by Pascal Vantrepote on 12-05-05.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//

#ifdef FLEXOC_STATIC_LIB
#import <FlexOC/AOP/IPointcut.h>
#else
#import <FlexOC/IPointcut.h>
#endif

@interface TruePointcut : NSObject<IPointcut>

@end
