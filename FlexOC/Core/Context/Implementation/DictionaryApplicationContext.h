//
//  DictionaryApplicationContext.h
//  FlexOC
//
//  Created by Pascal Vantrepote on 12-04-09.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//

#ifdef FLEXOC_STATIC_LIB
#import <FlexOC/Core/Context/Implementation/ApplicationContext.h>
#else
#import <FlexOC/FlexOC.h>
#endif

@interface DictionaryApplicationContext : ApplicationContext {
}

-(id) initWithDictionary:(NSDictionary*) configuration;

@end
