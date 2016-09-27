//
//  NSObject+AppKit+Dejal.m
//  Dejal Open Source Categories
//
//  Created by David Sinclair on Tue Sep 24 2002.
//  Copyright (c) 2002-2016 Dejal Systems, LLC. All rights reserved.
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

#import "NSObject+AppKit+Dejal.h"


@implementation NSObject (DejalAppKit)

/**
 Similar to -performSelector:withObject:withObject:, but calls a method in the standard pattern of a modal did-end selector.  Does nothing if selector is nil.
 
 @author DJS 2004-06.
*/

- (void)dejal_performSelector:(SEL)selector withWindow:(__unsafe_unretained NSWindow *)window returnCode:(NSInteger)returnCode contextInfo:(void *)contextInfo
{
    if (!selector)
        return;
    
    NSMethodSignature *signature = [self methodSignatureForSelector:selector];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    
    [invocation setSelector:selector];
    [invocation setArgument:&window atIndex:2];
    [invocation setArgument:&returnCode atIndex:3];
    [invocation setArgument:&contextInfo atIndex:4];
    [invocation invokeWithTarget:self];
}


/**
 Returns YES if the Command modifier key was pressed during the most recent event.
 
 @author DJS 2004-04.
*/

- (BOOL)dejal_usedCommandModifier
{
    return ([[NSApp currentEvent] modifierFlags] & NSEventModifierFlagCommand) == NSEventModifierFlagCommand;
}

/**
 Returns YES if the Option (Alternate) modifier key was pressed during the most recent event.
 
 @author DJS 2004-04.
*/

- (BOOL)dejal_usedOptionModifier
{
    return ([[NSApp currentEvent] modifierFlags] & NSEventModifierFlagOption) == NSEventModifierFlagOption;
}

/**
 Returns YES if the Shift modifier key was pressed during the most recent event.
 
 @author DJS 2004-04.
*/

- (BOOL)dejal_usedShiftModifier
{
    return ([[NSApp currentEvent] modifierFlags] & NSEventModifierFlagShift) == NSEventModifierFlagShift;
}

/**
 Returns YES if the Control modifier key was pressed during the most recent event.
 
 @author DJS 2004-04.
*/

- (BOOL)dejal_usedControlModifier
{
    return ([[NSApp currentEvent] modifierFlags] & NSEventModifierFlagControl) == NSEventModifierFlagControl;
}

@end

