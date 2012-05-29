//
//  XmlApplicationContext.h
//  FlexOC
//
//  Created by Pascal Vantrepote on 12-04-12.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

#ifdef FLEXOC_STATIC_LIB
#import <FlexOC/Core/Context/ApplicationContext.h>
#else
#import <FlexOC/ApplicationContext.h>
#endif

@interface XmlApplicationContext : ApplicationContext 

-(id) initWithXmlAtFilepath:(NSString*) filepath;
-(id) initWithXmlAtURL:(NSURL*) url;

@end
