//
//  RegExPointcut.h
//  FlexOC
//
//  Created by Pascal Vantrepote on 12-05-17.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//

#import <FlexOC/AOP/IPointcut.h>

@interface RegExPointcut : NSObject<IPointcut> 

@property (nonatomic, retain) NSString* pattern;

@end
