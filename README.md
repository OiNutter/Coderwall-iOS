Coderwall-iOS
=============

![iPhone Screenshots](https://github.com/OiNutter/Coderwall-iOS/raw/master/iPhones.png)

The App
-------

Coderwall-iOS is an app for the iPhone and iPad that lets you browse your
[Coderwall](http://coderwall.com) profile. You can browse your list of
badges, accomplishments, stats, and specialities, and even
search for other users.

Available free on the [App
Store](http://itunes.apple.com/us/app/coderwall/id520035280?ls=1&mt=8)

Why is it Open Source?
----------------------

I'm putting the app on the App Store for free as it's making use of
Coderwall, a free service, which itself is taking advantage of GitHub,
a huge promoter of Open Source, and free for public use, so it seemed
somewhat against the spirit of the thing to try and charge for it. In
addition it's my first app and is really just a bit of fun. 

As for why I'm making it available on GitHub, like I said, it was my first app and
was something of a learning experience. I'm putting it here for 2
reasons.

* I hope that it will help other people trying to get into iOS
  development, that they'll be able to learn from the things I had to do
to make things work the way I wanted them to.
* I hope that people with more knowledge and experience when it comes to
  iOS and Objective C will maybe get involved, and offer improvements
and tips so I can learn more for future projects.

### A Note On Copying ###

I realise the risk with putting this code online is that someone else
could just take it and publish their own version, they could even charge
for it. I also realise there's probably not a lot I can do about that
short of making it private, which I don't want to do. All I can hope to
do is say if you want to add new features or improvements, please get
involved and support this app, submit pull requests and bug reports etc
and lets try and have one really good Coderwall app, instead of several
average ones.

Coming Soon
-----------

At the moment the app is read only and doesn't take advantage of some of
the new features Coderwall has been adding, such as Teams and Network.
This is because I'm limited to what is available in their current API.
However I have been talking to the guys at Coderwall and I know they
have plans to add a lot more functionality that myself and other guys
working with the api will be able to take advantage of.

Libraries
---------

The following third party libraries were used in development of the app:

* [DejalActivityView](http://www.dejal.com/developer/#dejalactivityview)
* [EgoTableViewPullRefresh](https://github.com/enormego/EGOTableViewPullRefresh)
* [SBJson](http://stig.github.com/json-framework/)
* [Kiwi](https://github.com/allending/Kiwi)
* [ILTesting](https://github.com/InfiniteLoopDK/ILTesting)
* [KIF](https://github.com/square/KIF/)
* [ios-sim](https://github.com/phonegap/ios-sim)

I've also used [App Icon Template
2.0](http://appicontemplate.com/) by Michael Flarup at
[Pixelresort](http://pixelresort.com)

Development
-----------

* Third party libraries are primarily managed via
  [CocoaPods](https://github.com/CocoaPods/CocoaPods).
* Libraries without podspecs are added as submodules, housed in the
  `Vendor` directory. Make sure to run `git submodule init && git submodule update`
  from the project root directory after cloning the repository.

Testing
-------

* You can run the same tests as the CI environment by running `rake test`--this will run
  build the app and run the unit and integration test suite. Note that you must have
  `ios-sim` on your PATH (`brew install ios-sim`) in order to run the suite.

License
-------

Copyright (c) 2012 Will McKenzie
http://oinutter.co.uk

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

