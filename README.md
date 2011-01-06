tributary
=========

A tiny, heavily [toto](http://cloudhead.io/toto)-inspired and (no less heavily) [Sinatra](http://www.sinatrarb.com/)-powered blogging engine.



Overview
--------

tributary aggregates a set of `Item`s, representing individual website contents (blog posts, photolog entries, standalone pages, etc.) stored in YAML-enhanced Markdown files, and allows accessing them with a simple 1:1 URL-to-filename mapping. All `Item`s with a publication date are combined into a `Stream`, which can be interated over (to, e.g., display the seven most recent `Item`s, or all photos) or navigated from inside (to get the `Item` that’s previous/subsequent to the current one).



Items
-----

An `Item` is represented in the filesystem in the form of text file with a Markdown body and a YAML header:

    date: 2010-07-15
    title: welcome to tributary
    
    tributary _welcome_ article

The above example, if stored as `articles/welcome.md`, will be seen in tributary as an `Item` object with `Item#body` returning the kramdown-generated `<p>tributary <em>welcome</em> article</p>\n`, `Item#title` and `Item#date` returning YAML-parsed `welcome to tributary` and `2010-07-15 00:00:00 +0200`, while `Item#type` and `Item#path` will be inherited from the filesystem location and return `:articles` and `welcome`, respectively.



Item types
----------

Every `Item` has a type, inherited from the `Item`’s position in the filesystem and returned by `Item#type`. When a given `Item` is requested over HTTP (via its `Item#path`) the view associated with its type is rendered; this allows rendering different HTML/CSS layouts for different content types (‘static’ pages vs blog posts vs photolog entries, for example).



Views
-----

As mentioned above, every `Item` has an associated type, and this type defines the HTML view displayed when the given `Item` is requested; this allows for different rendering of e.g. static pages vs photolog entries. The views are written in [Haml](http://haml-lang.com/) and are located in `views/*.haml` files, with the file’s basename equal to the `Item`’s type.

Additionally, for every type the URL with that type’s name can be accessed (for example `http://…/pages`, assuming at least in one case `Item#type` returns `:pages`). In this case, the relevant `views/*.index.haml` Haml view is rendered (so `views/pages.index.haml` in the aforementioned example). These views can be used to create custom category-like pages – e.g., a page indexing all of your photographs that renders their thumbnails.



Stream
------

The `Stream` object contains all tributary `Item`s ordered by their publication date (if present) and can be queried to return a given number of the most recent `Item`s or an `Item` previous of (or subsequent to) a given `Item` (the returned `Item`(s) take into account the current `locale` and `lang_limit` settings). Every such query can additionally filter the `Stream` and for example request the subsequent `Item` that is also a photolog entry.



Multilingual support
--------------------

There are two session variables governing the user’s language preferences: `locale` and `lang_limit`. The first sets the user’s preferred language (and, for example, allows for a localised user interface), while the second limits the contents returned from the `Stream`.

Every `Item` can have multiple language versions (stored in `<type>/<path>.*.md` files, where `*` maps to the relevant locale) and/or a language-agnostic version (stored in the `<type>/<path>.md` file). When a given `Item` is requested (via the `http://…/<path>` URL) tributary chooses the language version most suitable for the request, based on either an explicit `locale` cookie sent along with the request or the `Accept-Language` HTTP header. If the preferred language version is not available, tributary falls back to the language-agnostic version or (if there’s no such version) to a language version that’s not explicitely filtered out by the `lang_limit` setting.

The site’s interface can be multilingualised using [R18n](http://r18n.rubyforge.org/) (via [R18n for Sinatra](http://r18n.rubyforge.org/sinatra.html)). The `t` object (available in views) can be sent messages like `t.recent_items`, which are translated to the relevant localised strings based on YAML entries in `i18n/*.yml` files (where `*` maps to the current user’s `locale`). The example `i18n/en.yml` file (in the `spec/site` directory) contains

    recent_items: recent items

while the example `i18n/pl.yml` file contains

    recent_items: najnowsze

– and so the `views/index.haml` view used by the spec site can call `t.recent_items` to get a properly localised string (note that `Tributary::App` already registers `Sinatra::R18n` and exposes `locale` to the session, while also setting the `locale` to either the user’s preference, their browser configuration’s default or English, so there’s nothing more that needs to be done).



Configuration
-------------

Application-level configuration is stored right on the `App` object itself; see the example `config.ru`, which happens to serve the site used by specs:

    Tributary::App.configure do |config|
      config.set :author,   'Ary Tribut'
      config.set :root,     'spec/site'
      config.set :sitename, 'a tributary site'
    end

User-level configuration is also stored on the `App` object and can be operated on by visiting the `/set?option=value` URLs – for example, setting the `locale` to English and `lang_limit` to English and Polish can be done by visiting the `/set?locale=en&lang_limit=en+pl` URL.

The `user_prefs` config option contains a list of settings that can be altered by visiting `/set` (and defaults to `[:lang_limit, :locale]`) – changing this option (by setting it as above in `config.ru`, for example) allows the users to alter other (e.g., nonexistent by default) settings and see the changes reflected on the `App` object.

The settings altered by the user are kept in the given user’s session and so persist between requests and visits.



Plugins
-------

Plugins (put in the `App.plugins` `Array`) are objects which can be sent a `handle` method with an `Item` as a parameter and are expected to return the `Item` (so the calls to subsequent plugins are chainable). See the `Mnml` plugin for an example implementation utilising a `SimpleDelegator` to filter the given `Item`’s `body` and `title` methods.



---

© MMX-MMXI Piotr Szotkowski <chastell@chastell.net>, licensed under AGPL 3 (see LICENCE)
