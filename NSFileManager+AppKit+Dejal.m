//
//  NSFileManager+AppKit+Dejal.m
//  Dejal Open Source Categories
//
//  Created by David Sinclair on Tue Mar 23 2004.
//  Copyright (c) 2004-2015 Dejal Systems, LLC. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without modification,
//  are permitted provided that the following conditions are met:
//
//  - Redistributions of source code must retain the above copyright notice,
//    this list of conditions and the following disclaimer.
//
//  - Redistributions in binary form must reproduce the above copyright notice,
//    this list of conditions and the following disclaimer in the documentation
//    and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
//  AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
//  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
//  ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
//  FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
//  DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
//  SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
//  CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
//  OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
//  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//

#import "NSFileManager+AppKit+Dejal.h"


@implementation NSFileManager (DejalAppKit)

/**
 Convenience method to return YES if the specified path is a directory and optionally also not a file package (bundle), otherwise NO.
 
 @author DJS 2007-02.
 @version DJS 2011-08: changed to immediately return NO if there isn't anything at the path.
*/

- (BOOL)dejal_isDirectoryAtPath:(NSString *)path butNotPackage:(BOOL)notPackage;
{
    BOOL isDirectory = NO;
    
    if (![self fileExistsAtPath:path isDirectory:&isDirectory])
        return NO;
    
    if (notPackage)
        return (isDirectory && ![[NSWorkspace sharedWorkspace] isFilePackageAtPath:path]);
    else
        return isDirectory;
}

/**
 If a file or folder exists at the path, it is moved to the Trash.  As with -removeFileAtPath:handler:, use caution with this method.  Returns YES if the file didn't exist, or was successsfully trashed, or NO if it couldn't be trashed.
 
 @author DJS 2007-07.
 @version DJS 2019-11: Removed due to using deprecated API.  Could be replaced if needed. 
*/

//- (BOOL)dejal_trashFileIfExistsAtPath:(NSString *)path;
//{
//    if ([self fileExistsAtPath:path])
//        return [[NSWorkspace sharedWorkspace] performFileOperation:NSWorkspaceRecycleOperation source:[path stringByDeletingLastPathComponent] destination:@"" files:@[[path lastPathComponent]] tag:nil];
//    else
//        return YES;
//}

@end

