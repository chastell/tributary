tributary
=========

A tiny, heavily [toto](http://cloudhead.io/toto)-inspired and (no less heavily) [Sinatra](http://www.sinatrarb.com/)-powered blogging engine.

Overview
--------

tributary aggregates a set of `Item`s, representing individual website contents (blog posts, photolog entries, standalone pages, etc.) stored in YAML-enhanced Markdown files, and allows accessing them with a simple 1:1 URL-to-filename mapping. All `Item`s with a publication date are combined into a `Stream`, which can be interated over (to, e.g., display the seven most recent `Item`s, or all photos) or navigated from inside (to get the `Item` that’s previous/subsequent to the current one).

Items
-----

An `Item` is represented in the filesystem in the form of text file with Markdown body and a YAML header:

    date: 2010-07-15
    title: welcome to tributary
    
    tributary _welcome_ article

The above example, if stored as `articles/welcome.md`, will be seen in tributary as an `Item` object with `Item#body` returning the kramdown-generated `<p>tributary <em>welcome</em> article</p>\n`, `Item#title` and `Item#date` returning YAML-parsed `welcome to tributary` and `2010-07-15 00:00:00 +0200`, while `Item#type` and `Item#path` will be inherited from the filesystem location and return `:articles` and `welcome`.

Item types
----------

Every `Item` has a type, inherited from the `Item`’s position in the filesystem and returned by `Item#type`. When a given `Item` is requested over HTTP (via its `Item#path`) the template associated with its type is rendered; this allows rendering different HTML/CSS layouts for different content types (‘static’ pages vs blog posts vs photolog entries, for example).

Stream
------

The `Stream` object contains all tributary `Item`s ordered by their publication date (if present) and can be queried to return a given number of the most recent `Item`s or an `Item` previous of (or subsequent to) a given `Item` (the returned `Item`(s) take into account the current `locale` and `lang_limit` settings). Every such query can additionally filter the `Stream` and for example request the subsequent `Item` that is also a photolog entry.

Multilingual support
--------------------

Every `Item` can have multiple language versions (stored in `<type>/<path>.*.md` files, where `*` maps to the relevant locale) and/or a language-agnostic version (stored in the `<type>/<path>.md` file). When a given `Item` is requested (via the `http://…/<path>` URL) tributary chooses the language version most suitable for the request, based on either an explicit `locale` cookie sent along with the request or the `Accept-Language` HTTP header. If the preferred language version is not available, tributary falls back to the language-agnostic version or (if there’s no such version) to a language version that’s not explicitely filtered out by the `lang_limit` setting.

Plugins
-------

Plugins (put in the `App.plugins` `Array`) are objects which can be sent a `handle` method with an `Item` as a parameter and are expected to return the `Item` (so the calls to subsequent plugins are chainable). See the `Mnml` plugin for an example implementation utilising a `SimpleDelegator` to filter the given `Item`’s `body` and `title` methods.

---

© MMX Piotr Szotkowski <chastell@chastell.net>, licensed under AGPL 3 (see LICENCE)
