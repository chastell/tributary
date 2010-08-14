tributary
=========

A tiny, heavily [toto](http://cloudhead.io/toto)-inspired and (no less heavily) [Sinatra](http://www.sinatrarb.com/)-powered blogging engine.

Overview
--------

tributary aggregates a set of `Item`s, representing individual website contents (blog posts, photolog entries, standalone pages, etc.) stored in YAML-enhanced Markdown files, and allows accessing them with a simple 1:1 URL-to-filename mapping. All `Item`s with a publication date are combined into a `Stream`, which can be interated over (to, e.g., display the seven most recent `Item`s, or all photos) or navigated from inside (to get the `Item` that’s previous/subsequent to the current one).



© MMX Piotr Szotkowski <chastell@chastell.net>, licensed under AGPL 3 (see LICENCE)
