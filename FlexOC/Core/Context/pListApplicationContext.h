//
//  pListApplicationContext.h
//  FlexOC
//
//  Created by Pascal Vantrepote on 12-04-09.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//

#ifdef FLEXOC_STATIC_LIB
#import <FlexOC/Core/Context/DictionaryApplicationContext.h>
#else
#import <FlexOC/DictionaryApplicationContext.h>
#endif

@interface pListApplicationContext : DictionaryApplicationContext

-(id) initWithPListAtPath:(NSString*) path;
-(id) initWithPListAtURL:(NSURL*) url;

@end
