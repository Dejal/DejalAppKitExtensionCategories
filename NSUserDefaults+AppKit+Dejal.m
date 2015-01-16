//
//  NSUserDefaults+AppKit+Dejal.m
//  Dejal Open Source Categories
//
//  Created by David Sinclair on Thu Jul 03 2003.
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

#import "NSUserDefaults+AppKit+Dejal.h"
#import "NSString+AppKit+Dejal.h"
#import "NSDictionary+AppKit+Dejal.h"


@implementation NSUserDefaults (DejalAppKit)

/**
 Returns a point from the defaults with the specified key.
 
 @author DJS 2005-04.
*/

- (NSPoint)dejal_pointForKey:(NSString *)defaultName;
{
    NSDictionary *dict = [self objectForKey:defaultName];
    NSPoint point = NSZeroPoint;
    
    if (dict)
    {
        point.x = [dict dejal_floatForKey:@"X"];
        point.y = [dict dejal_floatForKey:@"Y"];
    }
    
    return point;
}

/**
 Stores the specified point in the defaults with the specified key.
 
 @author DJS 2005-04.
*/

- (void)dejal_setPoint:(NSPoint)point forKey:(NSString *)defaultName;
{
    NSDictionary *dict = @{@"X": @(point.x), @"Y": @(point.y)};
    
    [self setObject:dict forKey:defaultName];
}

/**
 Returns a size from the defaults with the specified key.  If there is no preference with that key, the specified size is returned instead (e.g. NSZeroSize).
 
 @author DJS 2006-01.
*/

- (NSSize)dejal_sizeForKey:(NSString *)defaultName orDefaultSize:(NSSize)defaultSize;
{
    NSDictionary *dict = [self objectForKey:defaultName];
    NSSize size = defaultSize;
    
    if (dict)
    {
        size.width = [dict dejal_floatForKey:@"Width"];
        size.height = [dict dejal_floatForKey:@"Height"];
    }
    
    return size;
}

/**
 Stores the specified size in the defaults with the specified key.
 
 @author DJS 2006-01.
*/

- (void)dejal_setSize:(NSSize)size forKey:(NSString *)defaultName;
{
    NSDictionary *dict = @{@"Width": @(size.width), @"Height": @(size.height)};
    
    [self setObject:dict forKey:defaultName];
}

/**
 Returns a color from the defaults with the specified key.
 
 @author DJS 2003-07.
*/

- (NSColor *)dejal_colorForKey:(NSString *)defaultName;
{
    NSString *value = [self stringForKey:defaultName];
    
    if (value)
        return [value dejal_color];
    else
        return nil;
}

/**
 Stores the specified color in the defaults with the specified key.
 
 @author DJS 2003-07.
*/

- (void)dejal_setColor:(NSColor *)color forKey:(NSString *)defaultName;
{
    [self setObject:[NSString dejal_stringWithColor:color] forKey:defaultName];
}

/**
 Returns a shade of gray from the defaults with the specified key.
 
 @author DJS 2003-07.
*/

- (NSColor *)dejal_grayForKey:(NSString *)defaultName;
{
    return [NSColor colorWithCalibratedWhite:[self floatForKey:defaultName] alpha:1.0];
}

/**
 Stores the specified shade of gray in the defaults with the specified key.
 
 @author DJS 2003-07.
*/

- (void)dejal_setGray:(NSColor *)gray forKey:(NSString *)defaultName;
{
    CGFloat grayFloat;

    [[gray colorUsingColorSpaceName:NSCalibratedWhiteColorSpace] getWhite:&grayFloat alpha:NULL];
    [self setFloat:grayFloat forKey:defaultName];
}

@end

