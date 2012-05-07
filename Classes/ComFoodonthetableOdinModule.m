/**
 * Copyright (c) 2012 Shad Reynolds
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy of
 * this software and associated documentation files (the "Software"), to deal in
 * the Software without restriction, including without limitation the rights to
 * use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
 * of the Software, and to permit persons to whom the Software is furnished to do
 * so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

//
// NOTE: I could not figure out how to includ the ODIN files separately,
// so I've dumped the code in here.  Here's the license.
//
// Copyright 2011 ODIN Working Group. All rights reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

#import "ComFoodonthetableOdinModule.h"
#import "TiBase.h"
#import "TiHost.h"
#import "TiUtils.h"

// FOR ODIN
#import <CommonCrypto/CommonDigest.h>

#include <sys/socket.h>
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>

@implementation ComFoodonthetableOdinModule

#pragma mark Internal

// this is generated for your module, please do not change it
-(id)moduleGUID
{
	return @"912b57c3-2bc0-48d3-bad5-e0bd8916eeaf";
}

// this is generated for your module, please do not change it
-(NSString*)moduleId
{
	return @"com.foodonthetable.odin";
}

#pragma mark Lifecycle

-(void)startup
{
	// this method is called when the module is first loaded
	// you *must* call the superclass
	[super startup];
	
	NSLog(@"[INFO] %@ loaded",self);
}

-(void)shutdown:(id)sender
{
	// this method is called when the module is being unloaded
	// typically this is during shutdown. make sure you don't do too
	// much processing here or the app will be quit forceably
	
	// you *must* call the superclass
	[super shutdown:sender];
}

#pragma mark Cleanup 

-(void)dealloc
{
	// release any resources that have been retained by the module
	[super dealloc];
}

#pragma mark Internal Memory Management

-(void)didReceiveMemoryWarning:(NSNotification*)notification
{
	// optionally release any resources that can be dynamically
	// reloaded once memory is available - such as caches
	[super didReceiveMemoryWarning:notification];
}

#pragma mark Listener Notifications

-(void)_listenerAdded:(NSString *)type count:(int)count
{
	if (count == 1 && [type isEqualToString:@"my_event"])
	{
		// the first (of potentially many) listener is being added 
		// for event named 'my_event'
	}
}

-(void)_listenerRemoved:(NSString *)type count:(int)count
{
	if (count == 0 && [type isEqualToString:@"my_event"])
	{
		// the last listener called for event named 'my_event' has
		// been removed, we can optionally clean up any resources
		// since no body is listening at this point for that event
	}
}

#pragma Public APIs


// Get Mac Address
-(id)getMacAddr
{
    int                 mib[6];
    size_t              len;
    char                *buf;
    unsigned char       *ptr;
    struct if_msghdr    *ifm;
    struct sockaddr_dl  *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        //NSLog(@"ODIN-1.1: if_nametoindex error");
        return nil;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        //NSLog(@"ODIN-1.1: sysctl 1 error");
        return nil;
    }
    
    if ((buf = malloc(len)) == NULL) {
        //NSLog(@"ODIN-1.1: malloc error");
        return nil;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        //NSLog(@"ODIN-1.1: sysctl 2 error");
        return nil;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);

    return [NSString stringWithFormat:@"%02X:%02X:%02X:%02X:%02X:%02X",
            *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
}
-(id)getODIN
{
// Step 1: Get MAC address
  
  int                 mib[6];
  size_t              len;
  char                *buf;
  unsigned char       *ptr;
  struct if_msghdr    *ifm;
  struct sockaddr_dl  *sdl;
  
  mib[0] = CTL_NET;
  mib[1] = AF_ROUTE;
  mib[2] = 0;
  mib[3] = AF_LINK;
  mib[4] = NET_RT_IFLIST;
  
  if ((mib[5] = if_nametoindex("en0")) == 0) {
      //NSLog(@"ODIN-1.1: if_nametoindex error");
      return nil;
  }
  
  if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
      //NSLog(@"ODIN-1.1: sysctl 1 error");
      return nil;
  }
  
  if ((buf = malloc(len)) == NULL) {
      //NSLog(@"ODIN-1.1: malloc error");
      return nil;
  }
  
  if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
      //NSLog(@"ODIN-1.1: sysctl 2 error");
      return nil;
  }
  
  ifm = (struct if_msghdr *)buf;
  sdl = (struct sockaddr_dl *)(ifm + 1);
  ptr = (unsigned char *)LLADDR(sdl);
  
  //NSLog(@"MAC Address: %02X:%02X:%02X:%02X:%02X:%02X", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5));
  
// Step 2: Take the SHA-1 of the MAC address
  
  CFDataRef data = CFDataCreate(NULL, (uint8_t*)ptr, 6);
  
  unsigned char messageDigest[CC_SHA1_DIGEST_LENGTH];
      
      CC_SHA1(CFDataGetBytePtr((CFDataRef)data), 
                      CFDataGetLength((CFDataRef)data), 
                      messageDigest);
      
      CFMutableStringRef string = CFStringCreateMutable(NULL, 40);
      for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
              CFStringAppendFormat(string,
                                                       NULL, 
                                                       (CFStringRef)@"%02X",
                                                       messageDigest[i]);
      }

  CFStringLowercase(string, CFLocaleGetSystem());
  
  //NSLog(@"ODIN-1: %@", string);
  
  free(buf);
  
  NSString *odinstring = [[[NSString alloc] initWithString:(NSString*)string] autorelease];
  CFRelease(data);
  CFRelease(string);

  return [odinstring lowercaseString];
}

@end
