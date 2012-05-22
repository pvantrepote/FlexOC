//
//  RegExPointcut.h
//  FlexOC
//
//  Created by Pascal Vantrepote on 12-05-17.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//

#ifdef FLEXOC_STATIC_LIB
#import <FlexOC/AOP/IPointcut.h>
#else
#import <FlexOC/FlexOC.h>
#endif

@interface RegExPointcut : NSObject<IPointcut> 

@property (nonatomic, retain) NSString* pattern;

@end
