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
	
	/// Check if its a bundle
	if ([filepath hasPrefix:@"bundle://"]) {
		filepath = [filepath substringFromIndex:9];
		
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
	}
	else if ([filepath hasPrefix:@"file://"]) {
		/// Its a file

		filepath = [filepath substringFromIndex:7];
		
		/// Its an absolute file, no need to do anything
		if ([filepath isAbsolutePath]) 
			return filepath;
		
		NSString* path = [[[NSFileManager defaultManager] currentDirectoryPath] stringByAppendingPathComponent:filepath];
		if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
			return path;
		}
	}
		
	return nil;
}

+(NSURL*) resolveURL:(NSURL*) url {
	if ([url isFileURL]) {
		NSString* path = [self resolveFilepath:[url path]];
		return [NSURL fileURLWithPath:path];
	}
	
	return url;
}

@end
