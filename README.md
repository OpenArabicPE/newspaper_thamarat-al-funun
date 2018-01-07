---
title: "newspapers_thamarat-al-funun: read me"
author: Till Grallert
date: 2018-01-04 20:41:15 +0100
---

This repository contains bibliographic metadata for the newspaper *Thamarāt al-Funūn* published by ʿAbd al-Qādir al-Qabbānī in Beirut between 1875 and 1908. 

# current state

- TEI file of an **index** based on an unpublished thesis by Hudā Ṣiyāḥ (Lebanese University).
    + 2018-01-07: added publication dates for 1264 issues
- Completed generation of **metadata** until:
    + vol.11, no.513 as TEI and MODS (2017-11-05)
    + vol.13, no.645 as TEI (2018-01-04)
    + 2018-01-07: added some 600-odd issues from previously generated metadata. The missing issues are recorded with comments following this pattern: `<!-- gap of N issues between #N and #M -->`. There are still some 400-500 issues missing.
- Completed generation of **individual TEI files**
    + vol.11, no.513 (2017-11-05)
    + 2018-01-07: for all currently 1264 bibliographic entries

# some technical details

This repository contains the following files:

1. a [TEI XML](metadata/thamarat-al-funun.TEIP5.xml) file containing one `<biblStruct>` for each issue of *Thamarāt al-Funūn*. This file is produced through automatic iteration making use of [this code developed for OpenArabicPE](https://github.com/OpenArabicPE/generate_metadata-through-iteration/tree/thamarat-al-funun) and manual validation against the digital facsimiles.
2. individual TEI files for every issue of *Thamarāt al-Funūn*. These are generated from the output of step 1 using the XSLT stylesheet [`generate_tei-from-biblstruct.xsl`](https://github.com/OpenArabicPE/generate_metadata-through-iteration/blob/thamarat-al-funun/xslt/generate_tei-from-biblstruct.xsl) from the same repository.
2. a [TEI edition of the index](index/thamarat-al-funun_index.TEIP5.xml), where every entry is modelled as a `<bibl>`. Since the original index by Hudā Ṣiyāḥ does not contain publication dates, these have been added automatically through alignment with the information provided/produced in step 1.
3. all bibliographic data is then [automatically converted](https://www.github.com/OpenArabicPE/convert_tei-to-mods) from TEI XML to MODS XML for integration into reference management software etc (such as Zotero).