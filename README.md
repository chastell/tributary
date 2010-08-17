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



© MMX Piotr Szotkowski <chastell@chastell.net>, licensed under AGPL 3 (see LICENCE)
