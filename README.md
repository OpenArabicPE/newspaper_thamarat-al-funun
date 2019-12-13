---
title: "newspapers_thamarat-al-funun: read me"
author: Till Grallert
date: 2019-03-01
---

This repository contains bibliographic metadata for the newspaper *Thamarāt al-Funūn* published by ʿAbd al-Qādir al-Qabbānī in Beirut between 1875 and 1908.

# *Thamarāt al-Funūn*

During the generation of metadata, I found a number of irregularities, which were supposedly due to printers' errors:

- #717 is missing. After #716 followed #718 using the established weekly publication schedule. #717 was thus never published

# current state

- TEI file of an **index** based on an unpublished thesis by Hudā Ṣiyāḥ (Lebanese University).
    + 2018-01-07: added publication dates for 1264 issues
- Completed generation of **metadata** until:
    + vol.11, no.513 as TEI and MODS (2017-11-05)
    + vol.13, no.645 as TEI (2018-01-04)
    + 2018-01-07: added some 600-odd issues from previously generated metadata. The missing issues are recorded with comments following this pattern: `<!-- gap of N issues between #N and #M -->`. There are still some 400-500 issues missing.
    + 2018-07-04: filled the gaps of Nos. 696--718 and 866--1109
- Completed generation of **individual TEI files**
    + vol.11, no.513 (2017-11-05)
    + 2018-01-07: for all currently 1264 bibliographic entries
    + 2018-07-04: for all currently 1530 issues

## to do

- generate metadata
    + 1150
    + 1213
    + 1232
    + 1266
    + 1362-1461
    + 1544
    + 1577-1586
    + 1606-1655
    + 1658
- generate individual TEI files

# some technical details

This repository contains the following files:

1. a [TEI XML](metadata/thamarat-al-funun.TEIP5.xml) file containing one `<biblStruct>` for each issue of *Thamarāt al-Funūn*. This file is produced through automatic iteration making use of [this code developed for OpenArabicPE](https://github.com/OpenArabicPE/generate_metadata-through-iteration/tree/thamarat-al-funun) and manual validation against the digital facsimiles.
2. individual TEI files for every issue of *Thamarāt al-Funūn*. These are generated from the output of step 1 using the XSLT stylesheet [`generate_tei-from-biblstruct.xsl`](https://github.com/OpenArabicPE/generate_metadata-through-iteration/blob/thamarat-al-funun/xslt/generate_tei-from-biblstruct.xsl) from the same repository. TEI files contain links to the locally available facsimiles.
2. a [TEI edition of the index](index/thamarat-al-funun_index.TEIP5.xml), where every entry is modelled as a `<bibl>`. Since the original index by Hudā Ṣiyāḥ does not contain publication dates, these have been added automatically through alignment with the information provided/produced in step 1.
3. all bibliographic data is then [automatically converted](https://www.github.com/OpenArabicPE/convert_tei-to-mods) from TEI XML to MODS XML for integration into reference management software etc (such as Zotero).
4. The TEI files for individual issues were [converted to TSS XML](https://github.com/OpenArabicPE/convert_tei-to-sente/) for use with the now discontinued reference manager Sente.

# the index
## quality

- the author did not compile an index of headings or rather it is a combination of headings and her own summary of an article's content.
    + as a consequence, one cannot use the entries in the index to build a bibliographic database
- the index is far from complete!
    + *ḥādithat [al-Jāmiʿ] al-Azhar*:
        * one [entry in the index](index/thamarat-al-funun_index.TEIP5.xml#pb_71.d1e48793)
        * headlines in at least five issues:  {thamarat-oib-23-1082;thamarat-oib-23-1084;thamarat-oib-23-1086;thamarat-oib-23-1089;thamarat-oib-23-1090}
    + *ḥādithat Harsuk*
        * headlines in at least eight issues: {thamarat-oib-1-21;thamarat-oib-1-22;thamarat-oib-1-23;thamarat-oib-1-24;thamarat-oib-1-25;thamarat-oib-1-26;thamarat-oib-1-27;thamarat-oib-1-28}