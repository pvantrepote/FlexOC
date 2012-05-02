//
//  IInstanceService.h
//  FlexOC
//
//  Created by Pascal Vantrepote on 12-04-11.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IInstanceService <NSObject, NSCoding>

@property (nonatomic, retain) NSString* stringFromContext;
@property (nonatomic, retain) NSNumber* valueFromContext;

-(NSString*) testProxyCall;

@end
