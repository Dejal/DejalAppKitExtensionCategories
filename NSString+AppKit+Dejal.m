//
//  NSString+AppKit+Dejal.m
//  Dejal Open Source Categories
//
//  Created by David Sinclair on Sat Aug 17 2002.
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

#import "NSString+AppKit+Dejal.h"
#import "NSDictionary+AppKit+Dejal.h"


@implementation NSString (DejalAppKit)

/**
 Convenience method to calculate the width of the receiver in the specified font.
 
 @param font The font to use.  Pass nil to use the system font.
 @returns The width of the receiver in that font.
 
 @author DJS 2014-02.
 */

- (CGFloat)dejal_widthWithFont:(NSFont *)font;
{
    if (!font)
        font = [NSFont systemFontOfSize:0.0];
    
    return [self sizeWithAttributes:@{@"NSFontAttributeName" : font}].width;
}

/**
 Returns the specified string either intact, or truncated with the indicator string added if the original string is too long to fit in the desired width.  The indicator string would typically be an ellipsis (...); passing nil will default to that.  The string is trimmed on the left or right as requested.
 
 @author DJS 2004-01.
 @version DJS 2004-06: changed to add the trimLeft parameter.
*/

- (NSString *)dejal_truncatedStringWithIndicator:(NSString *)indicator forFont:(NSFont *)font withWidth:(NSUInteger)desiredWidth trimLeft:(BOOL)trimLeft
{
    if (!indicator)
        indicator = @"...";
    
    NSString *returnedString;
    NSDictionary *attributes = @{@"NSFontAttributeName": font};
    NSUInteger indicatorWidth = [indicator sizeWithAttributes:attributes].width;
    
    // Assume our string will fit:
    if ([self sizeWithAttributes:attributes].width <= desiredWidth)
    {
        returnedString = [NSString stringWithString:self];
    }
    else
    {
        // Do a binary search until we fit as tightly as possible:
        BOOL exactFit = NO;
        NSUInteger numChars = [self length] / 2;
        NSUInteger i = numChars;
        NSString *choppedString;
        
        // Assign this string first to deal with pathological case:
        if (trimLeft)
            choppedString = [self dejal_right:i];
        else
            choppedString = [self dejal_left:i];
        
        while ((numChars > 1) && !exactFit)
        { 
            NSUInteger thisWidth = [choppedString sizeWithAttributes:attributes].width + indicatorWidth;
            numChars /= 2;
            
            if (thisWidth < desiredWidth)
                i += numChars;
            else if (thisWidth > desiredWidth)
                i -= numChars;
            else
                exactFit = YES;
            
            if (trimLeft)
                choppedString = [self dejal_right:i];
            else
                choppedString = [self dejal_left:i];
        }
        
        if (trimLeft)
            returnedString = [indicator stringByAppendingString:choppedString];
        else
            returnedString = [choppedString stringByAppendingString:indicator];
    }
    
    return returnedString;
}

/**
 Returns the specified string either intact, or truncated with the indicator string added if the original string is too long to fit in the desired width.  The indicator string would typically be an ellipsis (...); passing nil will default to that.
 
 @author DJS 2004-01.
*/

- (NSString *)dejal_truncatedStringWithIndicator:(NSString *)indicator forFont:(NSFont *)font withWidth:(NSUInteger)desiredWidth
{
    return [self dejal_truncatedStringWithIndicator:indicator forFont:font withWidth:desiredWidth trimLeft:NO];
}

/**
 Given a string containing HTML entities like "&amp;" and "&copy;", returns the decoded equivalent, i.e. with "&amp;" converted to "&", etc.  If there are no HTML entities in the string, the receiver is returned.
 
 @author DJS 2006-07.
*/

- (NSString *)dejal_stringByReplacingHTMLEntities;
{
    if ([self containsString:@"&"])
    {
        NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
        NSAttributedString *attrib = [[NSAttributedString alloc] initWithHTML:data documentAttributes:nil];
        
        return [attrib string];
    }
    else
        return self;
}

+ (NSString *)dejal_stringWithPoint:(NSPoint)point
{
    return [self stringWithFormat:@"%f, %f", point.x, point.y];
}

- (NSPoint)dejal_pointValue
{
    NSArray *components = [self componentsSeparatedByString:@", "];
    NSPoint point = NSZeroPoint;
    
    point.x = [components[0] floatValue];
    point.y = [components[1] floatValue];
    
    return point;
}

/**
 Given a color, returns it encoded as a string, so it can be added to the defaults, etc.

 @author DJS 2003-07.
*/

+ (NSString *)dejal_stringWithColor:(NSColor *)color
{
    CGFloat r, g, b, a;

    [[color colorUsingColorSpace:NSColorSpace.sRGBColorSpace] getRed:&r green:&g blue:&b alpha:&a];

    if (a == 1.0)
        return [self stringWithFormat:@"%g %g %g", r, g, b];
    else
        return [self stringWithFormat:@"%g %g %g %g", r, g, b, a];
}

/**
 Returns a NSColor from the encoded value of the receiver, which must have been encoded by -stringWithColor: above.
 
 @author DJS 2003-07.
 @version DJS 2011-06: changed to avoid using sscanf().
*/

- (NSColor *)dejal_color
{
    NSArray *values = [self componentsSeparatedByString:@" "];
    
    if ([values count] < 3)
        return [NSColor grayColor];
    else if ([values count] == 3)
        return [NSColor colorWithCalibratedRed:[values[0] floatValue] green:[values[1] floatValue] blue:[values[2] floatValue] alpha:1.0];
    else
        return [NSColor colorWithCalibratedRed:[values[0] floatValue] green:[values[1] floatValue] blue:[values[2] floatValue] alpha:[values[3] floatValue]];
}

@end

