//
//  ApplicationContextResourceProvider.m
//  FlexOC
//
//  Created by Pascal Vantrepote on 12-04-15.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//

#import "ApplicationContextResourceProvider.h"

@implementation ApplicationContextResourceProvider

+(NSString*) resolveFilepath:(NSString*) filepath {
	if ([filepath isAbsolutePath]) 
		return filepath;
	
	NSBundle* mainBundle = [NSBundle mainBundle];
	if (mainBundle) {
		NSString* path = [[mainBundle bundlePath] stringByAppendingPathComponent:filepath];
		if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
			return path;
		}
	}
	
	mainBundle = [NSBundle bundleForClass:[self class]];
	if (mainBundle) {
		NSString* path = [[mainBundle bundlePath] stringByAppendingPathComponent:filepath];
		if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
			return path;
		}
	}

	NSString* path = [[[NSFileManager defaultManager] currentDirectoryPath] stringByAppendingPathComponent:filepath];
	if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
		return path;
	}
	
	return filepath;
}

+(NSURL*) resolveURL:(NSURL*) url {
	if ([url isFileURL]) {
		NSString* path = [self resolveFilepath:[url path]];
		return [NSURL fileURLWithPath:path];
	}
	
	return url;
}

@end
