DejalAppKitExtensionCategories
==============================

DejalAppKitExtensionCategories is a collection of categories to extend Foundation classes with methods specific to OS X.


Donations
---------

I wrote DejalAppKitExtensionCategories for my own use, but I'm making it available for the benefit of the Mac developer community.

If you find it useful, a donation via PayPal (or something from my Amazon.com Wish List) would be very much appreciated. Appropriate links can be found on the Dejal Developer page:

<http://www.dejal.com/developer>


Latest Version
--------------

You can find the latest version of this code via the GitHub repository:

<https://github.com/Dejal/DejalAppKitExtensionCategories>

For news on updates, also check out the Dejal Developer page or the Dejal Blog filtered for Dejal categories posts:

<http://www.dejal.com/blog/dejalcategories>


Environment & Requirements
--------------------------

- OS X 10.10.  Most methods may work in older OS versions.
- Objective-C language.
- ARC.
- The categories depend on the [DejalFoundationCategories](https://github.com/Dejal/DejalFoundationCategories).


Features
--------

- **NSAttributedString+AppKit+Dejal**: Adds convenience initializers to load from a bundle resource, image URL or RTF, and to return a RTF.
- **NSDictionary+AppKit+Dejal**: Extends `NSDictionary` and `NSMutableDictionary` to support `NSColor` values.
- **NSFileManager+AppKit+Dejal**: Adds a method to determine if a path is a directory but not a package, and to move a file to the Trash.
- **NSObject+AppKit+Dejal**: Extends the `NSObject` base class with an old-style modal did-end perform selector, and modifier key detection.
- **NSSString+AppKit+Dejal**: Adds methods that depend on fonts, points and colors.
- **NSUserDefaults+AppKit+Dejal**: Adds support for points, sizes and colors in `NSUserDefaults`.

The methods use a `dejal_` prefix to ensure uniqueness (important with categories).

Some of the methods date back over 10 years, so may be less useful nowadays, or have outdated code style.  But there are still lots of gems that are used in all [Dejal](http://www.dejal.com/) apps.


Usage
-----

Include the desired source files in your project.


License and Warranty
--------------------

This code uses the standard BSD license.  See the included License.txt file.  Please also see the [Dejal Open Source License](http://www.dejal.com/developer/license/) web page for more information.

You can use this code at no cost, with attribution.  A non-attribution license is also available, for a fee.

You're welcome to use it in commercial, closed-source, open source, free or any other kind of software, as long as you credit Dejal appropriately.

The placement and format of the credit is up to you, but I prefer the credit to be in the software's "About" window or view, if any. Alternatively, you could put the credit in the software's documentation, or on the web page for the product. The suggested format for the attribution is:

> Includes DejalAppKitExtensionCategories code from [Dejal](http://www.dejal.com/developer/).

Where possible, please link the text "Dejal" to the Dejal Developer web page, or include the page's URL: <http://www.dejal.com/developer/>.

This code comes with no warranty of any kind.  I hope it'll be useful to you, but I make no guarantees regarding its functionality or otherwise.


Support / Contact / Bugs / Features
-----------------------------------

I can't promise to answer questions about how to use the code.

If you create an app that uses the code, please tell me about it.

If you want to submit a feature request or bug report, please use [GitHub's issue tracker for this project](https://github.com/Dejal/DejalAppKitExtensionCategories/issues).  Or preferably fork the code and implement the feature/fix yourself, then submit a pull request.

Enjoy!

David Sinclair  
Dejal Systems, LLC


Contact: <http://www.dejal.com/contact/?subject=DejalAppKitExtensionCategories>
More open source projects: <http://www.dejal.com/developer>
Open source announcements on Twitter: <http://twitter.com/dejalopen>
General Dejal news on Twitter: <http://twitter.com/dejal>

