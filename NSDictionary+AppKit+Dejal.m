//
//  NSDictionary+AppKit+Dejal.m
//  Dejal Open Source Categories
//
//  Created by David Sinclair on Sat Aug 10 2002.
//  Copyright (c) 2002-2015 Dejal Systems, LLC. All rights reserved.
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

#import "NSDictionary+AppKit+Dejal.h"
#import "NSString+AppKit+Dejal.h"


@implementation NSDictionary (DejalAppKit)

/**
 Given a color, returns it encoded as a dictionary, so it can be added to the defaults, etc.
 
 @author DJS 2004-05.
*/

+ (instancetype)dejal_dictionaryWithColor:(NSColor *)color
{
    CGFloat red, green, blue, alpha;
    
    [[color colorUsingColorSpace:NSColorSpace.sRGBColorSpace] getRed:&red green:&green blue:&blue alpha:&alpha];
    
    return [self dictionaryWithObjectsAndKeys:
        @(red), @"Red",
        @(green), @"Green",
        @(blue), @"Blue",
        @(alpha), @"Alpha",
        nil];
}

/**
 Returns a NSColor from the encoded value of the receiver, which must have been encoded by +dictionaryWithColor: above, or manually constructed (e.g. in a plist file) to have the keys "Red", "Green", "Blue" and "Alpha" -- any of which may be omitted if desired.
 
 @author DJS 2004-05.
*/

- (NSColor *)dejal_color
{
    CGFloat red = [self[@"Red"] floatValue];
    CGFloat green = [self[@"Green"] floatValue];
    CGFloat blue = [self[@"Blue"] floatValue];
    CGFloat alpha = 1.0;
    id temp = self[@"Alpha"];
    
    if (temp)
        alpha = [temp floatValue];
    
    return [NSColor colorWithCalibratedRed:red green:green blue:blue alpha:alpha];
}

/**
 Returns a color from the defaults with the specified key.
 
 @author DJS 2003-07 for NSUserDefaults category.
 @version DJS 2007-04: changed to copy to NSDictionary category.
*/

- (NSColor *)dejal_colorForKey:(id)key;
{
    NSString *value = self[key];
    
    if (value)
        return [value dejal_color];
    else
        return nil;
}

@end


// ----------------------------------------------------------------------------------------
#pragma mark -
// ----------------------------------------------------------------------------------------


@implementation NSMutableDictionary (DejalAppKit)

/**
 Stores the specified color in the defaults with the specified key.
 
 @author DJS 2003-07 for NSUserDefaults category.
 @version DJS 2007-04: changed to copy to NSDictionary category.
*/

- (void)dejal_setColor:(NSColor *)color forKey:(id)key;
{
    self[key] = [NSString dejal_stringWithColor:color];
}

@end

