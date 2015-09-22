//
//  NSAttributedString+AppKit+Dejal.h
//  Dejal Open Source Categories
//
//  Created by David Sinclair on Fri Jul 18 2003.
//  Copyright (c) 2003-2015 Dejal Systems, LLC. All rights reserved.
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

#import "NSAttributedString+AppKit+Dejal.h"


@implementation NSAttributedString (DejalAppKit)

/**
 Convenience method to create and return a new attributed string containing an image from a main bundle resource.
 
 @author DJS 2014-10.
 */

+ (instancetype)dejal_attributedStringWithBundleResource:(NSString *)resourceName extension:(NSString *)extension;
{
    NSURL *url = [[NSBundle mainBundle] URLForResource:resourceName withExtension:extension];
    
    return [self dejal_attributedStringWithImageFromURL:url];
}

/**
 Convenience method to create and return a new attributed string containing an image from the specified file URL.  Returns nil if the URL is nil or there is no image in that location.
 
 @author DJS 2006-06.
 @version DJS 2014-10: changed to use a URL instead of path.
*/

+ (instancetype)dejal_attributedStringWithImageFromURL:(NSURL *)fileURL;
{
    if (!fileURL)
    {
        return nil;
    }
    
    NSFileWrapper *fileWrapper = [[NSFileWrapper alloc] initWithURL:fileURL options:0 error:nil];
    
    if (!fileWrapper)
    {
        return nil;
    }
    
    NSTextAttachment *attachment = [[NSTextAttachment alloc] initWithFileWrapper:fileWrapper];
    
    if (!attachment)
    {
        return nil;
    }
    
    return [self attributedStringWithAttachment:attachment];
}

/**
 Convenience method to create and return an autoreleased attributed string from the specified RTF data and document attributes (which can be nil).

 @author DJS 2003-07.
*/

+ (instancetype)dejal_attributedStringWithRTF:(NSData *)data
{
    return [[self alloc] initWithRTF:data documentAttributes:nil];
}

/**
 Convenience method to create and return an autoreleased attributed string from the specified RTFD data and document attributes (which can be nil).

 @author DJS 2003-07.
*/

+ (instancetype)dejal_attributedStringWithRTFD:(NSData *)data
{
    return [[self alloc] initWithRTFD:data documentAttributes:nil];
}

/**
 Returns a RTF edition of the attributed string.
 
 @author DJS 2004-12.
 @version DJS 2015-09: Changed to use an empty dictionary instead of nil, to avoid a nullability warning.
*/

- (NSData *)dejal_RTFValue
{
    return [self RTFFromRange:[self dejal_allRange] documentAttributes:@{}];
}

/**
 Returns a RTFD edition of the attributed string.
 
 @author DJS 2004-12.
 @version DJS 2015-09: Changed to use an empty dictionary instead of nil, to avoid a nullability warning.
*/

- (NSData *)dejal_RTFDValue
{
    return [self RTFDFromRange:[self dejal_allRange] documentAttributes:@{}];
}

/**
 Returns an archived RTFD, as expected by the 'data' binding for a NSTextView.
 
 @author DJS 2007-11.
*/

- (NSData *)dejal_textViewBindingsValue;
{
    return [NSArchiver archivedDataWithRootObject:[self dejal_RTFDValue]];
}

@end

