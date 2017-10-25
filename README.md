---
title: "newspapers_thamarat-al-funun: read me"
author: Till Grallert
date: 2017-10-25 21:55:27 +0300
---

This repository contains bibliographic metadata for the newspaper *Thamarāt al-Funūn* published by ʿAbd al-Qādir al-Qabbānī in Beirut between 1875 and 1908. 

# current state

- 2017-10-24: index based on an unpublished thesis by Hudā Ṣiyāḥ (Lebanese University).

# some technical details

This repository will contain the following files

1. a [TEI XML]() file containing one `<biblStruct>` for each issue of *Thamarāt al-Funūn*. This file is produced through automatic iteration making use of [this code developed for OpenArabicPE](https://www.github.com/OpenArabicPE/generate_metadata-through-iteration) and manual validation against the digital facsimiles.
2. a TEI edition of the index, where every entry is modelled as a `<bibl>`. Since the original index by Hudā Ṣiyāḥ does not contain publication dates, these will be added automatically through alignment with the information provided/produced in step 1.
3. all bibliographic data is then [automatically converted](https://www.github.com/OpenArabicPE/convert_tei-to-mods) from TEI XML to [MODS XML]() for integration into reference management software etc (such as Zotero).