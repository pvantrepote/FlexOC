//
//  XmlApplicationContext.h
//  FlexOC
//
//  Created by Pascal Vantrepote on 12-04-12.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <FlexOC/Core/Context/Implementation/DictionaryApplicationContext.h>
#import <FlexOC/Core/Context/IApplicationContext.h>
@class XmlApplicationContextParser;

@interface XmlApplicationContext : DictionaryApplicationContext 

-(id) initWithXmlAtFilepath:(NSString*) filepath;
-(id) initWithXmlAtURL:(NSURL*) url;

@end
