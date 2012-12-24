/*
 * Copyright (c) 2012 Adobe Systems Incorporated. All rights reserved.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and associated documentation files (the "Software"),
 * to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 *
 */

#pragma once

// Application name used in native code. This name is *not* used in resources.

#ifdef OS_WIN
// Name of group (if any) that application prefs/settings/etc. are stored under
// This must be an empty string (for no group), or a string that ends with "\\"
#define GROUP_NAME L""
#define APP_NAME L"Brackets"
#define WINDOW_TITLE APP_NAME
#endif
#ifdef OS_MACOSX
// Name of group (if any) that application prefs/settings/etc. are stored under
// This must be an empty string (for no group), or a string that ends with "/"
#define GROUP_NAME @""
#define APP_NAME @"Brackets"
#define WINDOW_TITLE APP_NAME
#endif

// Product version string that gets added to the end of the user agent
// TODO: Ideally, this would include a version number in addition to the
// product name (something like "Brackets/0.18.0"). But, we don't currently
// have a good cross-platform way to get appshell version numbers into
// the build process. Once we do, we should change this.
// Filed as bug #2442
#ifndef PRODUCT_VERSION_STRING
#define PRODUCT_VERSION_STRING "Brackets"
#endif

#define REMOTE_DEBUGGING_PORT 9234

// Un-comment this line to show the toolbar UI at the top of the appshell window
// #define SHOW_TOOLBAR_UI

