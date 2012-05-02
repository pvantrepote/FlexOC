//
//  InjectionInstanceService.h
//  FlexOC
//
//  Created by Pascal Vantrepote on 12-04-11.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "IInstanceService.h"

@interface InjectionInstanceService : NSObject

@property (nonatomic, retain) id<IInstanceService> anInstanceService;

@end
