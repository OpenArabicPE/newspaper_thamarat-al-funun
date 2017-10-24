---
title: "newspapers_thamarat-al-funun: read me"
author: Till Grallert
date: 2017-10-24 08:49:10 +0300
---

This repository contains bibliographic metadata for the newspaper *Thamarāt al-Funūn* published by ʿAbd al-Qādir al-Qabbānī in Beirut between 1875 and 1908. 

# current state

- 2017-10-24: index based on an unpublished thesis by Hudā Ṣiyāḥ (Lebanese University).

# some technical details

This repository will contain a [TEI XML]() file containing one `<biblStruct>` for each issue. This file is produced through automatic iteration making use of [this code](https://www.github.com/OpenArabicPE/generate_metadata-through-iteration) and manual validation against the digital facsimiles.

The TEI is then [automatically converted](https://www.github.com/OpenArabicPE/convert_tei-to-mods) to [MODS XML]() for integration into reference management software etc (such as Zotero).