---
title: "newspapers_thamarat-al-funun: read me"
author: Till Grallert
date: 2018-01-04 20:41:15 +0100
---

This repository contains bibliographic metadata for the newspaper *Thamarāt al-Funūn* published by ʿAbd al-Qādir al-Qabbānī in Beirut between 1875 and 1908. 

# current state

- 2017-10-24: index based on an unpublished thesis by Hudā Ṣiyāḥ (Lebanese University).
- Completed generation of metadata until:
    + vol.11, no.513 (2017-11-05)

# some technical details

This repository will contain the following files

1. a [TEI XML](metadata/thamarat-al-funun.TEIP5.xml) file containing one `<biblStruct>` for each issue of *Thamarāt al-Funūn*. This file is produced through automatic iteration making use of [this code developed for OpenArabicPE](https://www.github.com/OpenArabicPE/generate_metadata-through-iteration) and manual validation against the digital facsimiles.
2. a [TEI edition of the index](index/thamarat-al-funun_index.TEIP5.xml), where every entry is modelled as a `<bibl>`. Since the original index by Hudā Ṣiyāḥ does not contain publication dates, these will be added automatically through alignment with the information provided/produced in step 1.
3. all bibliographic data is then [automatically converted](https://www.github.com/OpenArabicPE/convert_tei-to-mods) from TEI XML to MODS XML for integration into reference management software etc (such as Zotero).