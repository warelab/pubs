-- MySQL dump 10.13  Distrib 5.5.29, for osx10.8 (i386)
--
-- Host: localhost    Database: warelab_pubs
-- ------------------------------------------------------
-- Server version	5.5.29

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `agency`
--

DROP TABLE IF EXISTS `agency`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `agency` (
  `agency_id` int(11) NOT NULL AUTO_INCREMENT,
  `agency_name` char(255) NOT NULL DEFAULT '',
  `url_template` char(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`agency_id`),
  UNIQUE KEY `agency_name` (`agency_name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `agency`
--

LOCK TABLES `agency` WRITE;
/*!40000 ALTER TABLE `agency` DISABLE KEYS */;
INSERT INTO `agency` VALUES (1,'unknown','');
/*!40000 ALTER TABLE `agency` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `funding`
--

DROP TABLE IF EXISTS `funding`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `funding` (
  `funding_id` int(11) NOT NULL AUTO_INCREMENT,
  `agency_id` int(11) NOT NULL DEFAULT '1',
  `award_number` char(255) NOT NULL DEFAULT '',
  `title` text,
  `abstract` text,
  PRIMARY KEY (`funding_id`),
  KEY `agency_id` (`agency_id`),
  CONSTRAINT `funding_ibfk_1` FOREIGN KEY (`agency_id`) REFERENCES `agency` (`agency_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `funding`
--

LOCK TABLES `funding` WRITE;
/*!40000 ALTER TABLE `funding` DISABLE KEYS */;
INSERT INTO `funding` VALUES (1,1,'','unknown','');
/*!40000 ALTER TABLE `funding` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pub`
--

DROP TABLE IF EXISTS `pub`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pub` (
  `pub_id` int(11) NOT NULL AUTO_INCREMENT,
  `funding_id` int(11) NOT NULL DEFAULT '1',
  `year` int(11) NOT NULL DEFAULT '0',
  `authors` text NOT NULL,
  `title` char(255) NOT NULL DEFAULT '',
  `journal` char(255) NOT NULL DEFAULT '',
  `pubmed` char(30) NOT NULL DEFAULT '',
  `url` char(255) NOT NULL DEFAULT '',
  `data` char(255) NOT NULL DEFAULT '',
  `cover` char(255) NOT NULL DEFAULT '',
  `pdf` char(255) NOT NULL DEFAULT '',
  `info_115` char(255) NOT NULL DEFAULT '',
  `hide_from_view` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`pub_id`),
  KEY `funding_id` (`funding_id`),
  CONSTRAINT `pub_ibfk_1` FOREIGN KEY (`funding_id`) REFERENCES `funding` (`funding_id`)
) ENGINE=InnoDB AUTO_INCREMENT=84 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pub`
--

LOCK TABLES `pub` WRITE;
/*!40000 ALTER TABLE `pub` DISABLE KEYS */;
INSERT INTO `pub` VALUES (1,1,1989,'Kellaris KV, Ware DK, Smith S, Kyte J','Assessment of the number of free cysteines and isolation and identification of cystine-containing peptides from acetylcholine receptor','Biochemistry. 1989 Apr 18;28(8):3469-82','2742850','','','','','',0),(2,1,1992,'Ahmed CM, Ware DH, Lee SC, Patten CD, Ferrer-Montiel AV, Schinder AF, McPherson JD, Wagner-McPherson CB, Wasmuth JJ, Evans GA, et al.','Primary structure, chromosomal localization, and functional expression of a voltage-gated sodium channel from human brain.','Proc Natl Acad Sci U S A. 1992 Sep 1;89(17):8220-4','1325650','','','','','',0),(3,1,1995,'Wanner LA, Li G, Ware D, Somssich IE, Davis KR','The phenylalanine ammonia-lyase gene family in Arabidopsis thaliana','Plant Mol Biol. 1995 Jan;27(2):327-38','7888622','','','','','',0),(4,1,1998,'Li H, Wu G, Ware D, Davis KR, Yang Z.','Arabidopsis Rho-related GTPases: differential gene expression in pollen and polar localization in fission yeast.','Plant Physiol. 118(2):407-17','9765526','','','','','',0),(5,1,1999,'Scholl R, Ware D, Davis K','Handling and preservation of clones in a DNA stock center','Wilson, Z. ed. A Practical Approach: Arabidopsis. Oxford Univ. Press. pp 29-50. (Book chapter)','','','','','','',0),(6,1,2000,'Scholl, RL, May ST, Ware DH','Seed and molecular resources for Arabidopsis','Plant Physiol. Dec;124(4):1477-80','11115863','','','','','',0),(7,1,2002,'Ware D, Jaiswal P, Ni J, Yap I, Pan X, Clark K, Teytelman L, Schmidt S, Zhao W, Chang K, Cartinhour S, Stein L, McCouch S','Gramene a tool for Grass Genomics','Plant Physiol. 2002 Dec;130(4):1606-13','12481044','','','','','',0),(8,1,2002,'McCouch SR, Teytelman L, Xu Y, Lobos KB, Clare K, Walton M, Fu B, Maghirang R, Li Z, Xing Y, Zhang Q, Kono I, Yano M, Fjellstrom R, DeClerck G, Schneider D, Cartinhour S, Ware D, Stein L','Development and mapping of 2240 new SSR markers for rice (Oryza sativa L.)','DNA Res. 2002 Dec 31;9(6):199-207','12597276','','','','','',0),(9,1,2002,'McCouch SR, Teytelman L, Xu Y, Lobos KB, Clare K, Walton M, Fu B, Maghirang R, Li Z, Xing Y, Zhang Q, Kono I, Yano M, Fjellstrom R, DeClerck G, Schneider D, Cartinhour S, Ware D, Stein L','Development and mapping of 2240 new SSR markers for rice (Oryza sativa L.) (supplement)','DNA Res. 2002 Dec 31;9(6):257-79','12597280','','','','','',0),(10,1,2002,'Jaiswal P, Ware D, Ni J, Chang K, Zhao W, Schmidt S, Pan X, Clark K, Teytelman L, Cartinhour S, Stein L, McCouch S','Gramene: development and integration of trait and gene ontologies for rice','Comparative and Functional Genomics 3: 132-136','18628886','','','','','',0),(11,1,2002,'Ware D, Jaiswal P, Ni J, Pan X, Chang K, Clark K, Teytelman L, Schmidt S, Zhao W, Cartinhour S, McCouch S, Stein L','Gramene: a resource for comparative grass genomics','Nucleic Acids Res., Jan 1;30(1):103-5.','11752266','','','','','',0),(12,1,2003,'Scholl R, Sachs MM, Ware D','Maintaining Collections of Mutants for Plant Functional Genomics','Humana Press, Methods Mol Biol., 2003; 236:311-26','14501073','','','','','',0),(13,1,2003,'The Rice Chromosome 10 Sequencing Consortium','Rice chromosome 10 reveals a high degree of heterchromatin and collinearity with cereals','Science June 300 (5629) 1566-15','','','','','','',0),(14,1,2003,'Ware D, Stein L','Comparison of genes among cereals','Curr Opin Plant Biol 6: 121-127','12667867','','','','','',0),(15,1,2004,'Maher C, Timmermans M, Stein L, Ware D','Identifying microRNAs in plant genomes','Proc. IEEE, CBS: 718-723','','/documents/CSB2004.pdf','','','','',0),(16,1,2005,'Jaiswal P, Avraham S, Ilic K, Kellogg EA, McCouch S, Pujar A, Reiser L, Rhee SY, Sachs MM, Schaeffer M, Stein L, Stevens P, Vincent L, Ware D, Zapata F','Plant Ontology (PO): A Controlled Vocabulary of Plant Structures and Growth Stages','Comp Funct Genomics. 2005;6(7-8):388-97','18629207','PMC2447502','','','','',0),(17,1,2005,'Sorghum Genomics Planning Workshop Participants. (2005) A U.S. National Science Foundation-Sponsored Workshop Report','Toward Sequencing the Sorghum Genome','Plant Physiol. Aug; 138: 1898-1902','16172096','','','','','',0),(18,1,2006,'Pujar A, Jaiswal P, Kellogg EA, Ilic K, Vincent L, Avraham S, Stevens P, Zapata F, Reiser L, Rhee SY, Sachs MM, Schaeffer M, Stein L, Ware D, McCouch S','Whole-plant growth stage ontology for angiosperms and its application in plant biology','Plant Physiol. 2006 Oct;142(2):414-28. Epub 2006 Aug 11.','16905665','','','','','',0),(19,1,2006,'Hass-Jacobus BL, Futrell-Griggs M, Abernathy B, Westerman R, Goicoechea JL, Stein J, Klein P, Hurwitz B, Zhou B, Rakhshan F, Sanyal A, Gill N, Lin JY, Walling JG, Luo MZ, Ammiraju JS, Kudrna D, Kim HR, Ware D, Wing RA, San Miguel P, Jackson SA','Integration of hybridization-based markers (overgos) into physical maps for comparative and evolutionary explorations in the genus Oryza and in Sorghum','BMC Genomics. 2006 Aug 8;7:199.','16895597','','','','','',0),(20,1,2006,'Maher C, Stein L, Ware D.','Evolution of Arabidopsis microRNA families through duplication events','Genome Res. 2006 Apr;16(4):510-9. Epub 2006 Mar 6','16520461','','','','','',0),(21,1,2006,'Jaiswal P, Ni J, Yap I, Ware D, Spooner W, Youens-Clark K, Ren L, Liang C, Zhao W, Ratnapu K, Faga B, Canaran P, Fogleman M, Hebbard C, Avraham S, Schmidt S, Casstevens TM, Buckler ES, Stein L, McCouch S.','Gramene: a bird\'s eye view of cereal genomes','Nucleic Acids Res. 2006 Jan 1;34(Database issue):D717-23','16381966','','','','','',0),(22,1,2006,'Zhao, W., P. Canaran, R. Jurkuta, T. Fulton, J. Glaubitz, E. Buckler, J. Doebley, B. Gaut, M. Goodman, J. Holland, S. Kresovich, M. McMullen, L. Stein, and D. Ware','Panzea: a database and resource for molecular and functional diversity in the maize genome','Nucleic Acids Res 34: D752-757','16381974','','','','','',0),(23,1,2006,'Canaran P, Stein L, Ware D.','Look-Align: an interactive web-based multiple sequence alignment viewer with polymorphism analysis support','Bioinformatics. 2006 Feb 10; [Epub ahead of print]','16473875','','','','','',0),(24,1,2007,'Ware D.','Gramene','Methods Mol Biol. 2007;406:315-29','','','','','','',0),(25,1,2007,'Wing R, Kim H, Goicoechea J, Yu Y, Kudrna D, Zuccolo A, Ammiraju J, Luo M, Nelson W, Ma J, San Miguel P, Hurwitz B, Ware D, Brar D, Mackill D, Soderlund C, Stein L, Jackson S','The Oryza Map Alignment Project (OMAP): A New Resource for Comparative Genome Studies within the Oryza','Rice Functional Genomics: Challenges, Progress and Prospects, N.M. Upadhyaya, Editor. 2007, Springer','18287700','','','','','',0),(26,1,2007,'Wing R, Kim H, Goicoechea JL, Yu Y, Kudrna D, Zuccolo A, Ammiraju JS, Luo M, Nelson W, Soderlund C, San Miguel P, Gill N, Walling JG, Jackson S, Hurwitz B, Ware D, Stein L, Brar D, Mackill D','The Oryza map alignment project (OMAP): A new resource for comparative genomics studies within Oryza','Rice Genetics V: Proceedings of the Fifth International Rice Genetics Symposium, D.a.H. Brar, B., Editor. 2007, IRRI: Manila','','','','','','',0),(27,1,2007,'Canaran P, Buckler ES, Glaubitz JC, Stein L, Sun Q, Zhao W, Ware D','Patterns of Selection and Tissue-Specific Expression among Maize Domestication and Crop Improvement Loci','Plant Physiol. 2007 Jul;144(3):1642-53. Epub 2007 May 11','17496114','http://www.plantphysiol.org/cgi/content/abstract/144/3/1642','','','','',0),(28,1,2007,'Ilic K, Kellogg EA, Jaiswal P, Zapata F, Stevens PF, Vincent LP, Avraham S, Reiser L, Pujar A, Sachs MM, Whitman NT, McCouch SR, Schaeffer ML, Ware DH, Stein LD, Rhee SY','The plant structure ontology, a unified vocabulary of anatomy and morphology of a flowering plant','Plant Physiol. 2007 Feb;143(2):587-99. Epub 2006 Dec 1','17142475','','','','','',0),(29,1,2008,'Liang C, Jaiswal P, Hebbard C, Avraham S, Buckler ES, Casstevens T, Hurwitz B, McCouch S, Ni J, Pujar A, Ravenscroft D, Ren L, Spooner W, Tecle I, Thomason J, Tung CW, Wei X, Yap I, Youens-Clark K, Ware D, Stein L','Gramene: a growing plant comparative genomics resource','Nucleic Acid Research (Database issue D947-953)','17984077','http://nar.oxfordjournals.org/cgi/content/abstract/36/suppl_1/D947?maxtoshow=&HITS=10&hits=10&RESULTFORMAT=&fulltext=gramene&searchid=1&FIRSTINDEX=0&resourcetype=HWCIT','','','','',0),(30,1,2008,'Canaran P, Buckler ES, Glaubitz JC, Stein L, Sun Q, Zhao W, Ware D','Panzea: An Update on New Content and Features','Nucleic Acids Res. 2008 Jan;36(Database issue):D1041-3. Epub 2007 Nov 19','18029361','http://nar.oxfordjournals.org/cgi/content/full/36/suppl_1/D1041','','','','',0),(31,1,2008,'Lu C, Jeong DH, Kulkarni K, Pillay M, Nobuta K, German R, Thatcher SR, Maher D, Zhang L, Ware D, Liu B, Cao X, Meyers BC, Green PJ','Genome-wide analysis for discovery of new rice miRNAs reveals natural antisense miRNAs (nat-miRNAs)','Proc Natl Acad Sci U S A. 2008;105(12):4951-6','18353984','','','','','',0),(32,1,2008,'Kim, H., B. Hurwitz, Y. Yu, K. Collura, N. Gill, P. Sanmiguel, J.C. Mullikin, C. Maher, W. Nelson, M. Wissotski, M. Braidotti, D. Kudrna, J.L. Goigochia, L. Stein, D. Ware, S.A. Jackson, C. Soderlund, and R.A. Wing','Construction, alignment and analysis of 12 framework physical maps that represent the 10 genome types of the genus Oryza','Genome Biol. 2008;9(2):R45. Epub 2008 Feb 28','18304353','PMC2374706','','','','',0),(33,1,2008,'Kim H, Hurwitz B, Yu Y, Collura K, Gill N, SanMiguel P, Mullikin JC, Maher C, Nelson W, Wissotski M, Braidotti M, Kudrna D, Goicoechea JL, Stein L, Ware D, Jackson SA, Soderlund C, Wing RA','The Plant Ontology Database: a community resource for plant structure and developmental stages controlled vocabulary and annotations','Nucleic Acids Research 2008 36(Database issue):D449-D454','PMC2238838','http://nar.oxfordjournals.org/cgi/content/full/36/suppl_1/D449?maxtoshow=&HITS=10&hits=10&RESULTFORMAT=&fulltext=plant+ontology&searchid=1&FIRSTINDEX=0&resourcetype=HWCIT','','','','',0),(34,1,2008,'Kurtz S, Narechania A, Stein JC, Ware D','A new method to compute K-mer frequencies and its application to annotate large repetitive plant genomes','BMC Genomics 9: 517','PMC2613927','','','','','',0),(35,1,2008,'Wicker T, Narechania A, Sabot F, Stein J, Vu GT, Graner A, Ware D, Stein N','Low-pass shotgun sequencing of the barley genome facilitates rapid identification of genes, conserved non-coding sequences and novel repeats','BMC Genomics 9:518','18976483','','','','','',0),(36,1,2008,'Lawrence CJ, Ware D','Handbook of Maize:  History and Practice of Genetics and Genomics','In Bennetzen, J.L. and Jake, S.C. (eds.), Springer Science + Business Media LLC, pp. 659-672','','','','','','',0),(37,1,2009,'Cranston K, Hurwitz B, Ware D, Stein L, Wing R','Species trees from highly incongruent gene trees in rice','Systematic Biology 2009 58(5):489-500; doi:10.1093/sysbio/syp054','','http://sysbio.oxfordjournals.org/cgi/content/short/58/5/489','','','','',0),(38,1,2009,'Zhou S, Wei F, Nguyen J, Bechner M, Potamousis K, Goldstein S, Pape L, Mehan MR, Churas C, Pasternak S, Forrest DK, Wise R, Ware D, Wing RA, Waterman MS, Livny M, Schwartz DC','A single molecule scaffold for the maize genome','PLoS Genet. 2009 Nov;5(11):e1000711','19936062','http://www.plosgenetics.org/article/info%3Adoi%2F10.1371%2Fjournal.pgen.1000711','','','','',0),(39,1,2009,'Wei F, Zhang J, Zhou S, He R, Schaeffer M, Collura K, Kudrna D, Faga BP, Wissotski M, Golser W, Rock SM, Graves TA, Fulton RS, Coe E, Schnable PS, Schwartz DC, Ware D, Clifton SW, Wilson RK, Wing RA','The physical and genetic framework of the maize b73 genome','PLoS Genet. 2009 Nov;5(11):e1000715. Epub 2009 Nov 20','19936061','http://www.plosgenetics.org/article/info%3Adoi%2F10.1371%2Fjournal.pgen.1000715','','','','',0),(40,1,2009,'Zhang L, Chia JM, Kumari S, Stein JC, Liu Z, Narechania A, Maher CA, Guill K, McMullen MD, Ware D','A genome-wide characterization of microRNA genes in maize','PLoS Genet. 2009 Nov;5(11):e1000716. Epub 2009 Nov 20','19936050','http://www.plosgenetics.org/article/info%3Adoi%2F10.1371%2Fjournal.pgen.1000716','','','','',0),(41,1,2009,'Wei F, Stein JC, Liang C, Zhang J, Fulton RS, Baucom RS, De Paoli E, Zhou S, Yang L, Han Y, Pasternak S, Narechania A, Zhang L, Yeh CT, Ying K, Nagel DH, Collura K, Kudrna D, Currie J, Lin J, Kim H, Angelova A, Scara G, Wissotski M, Golser W, Courtney L, Kruchowski S, Graves TA, Rock SM, Adams S, Fulton LA, Fronick C, Courtney W, Kramer M, Spiegel L, Nascimento L, Kalyanaraman A, Chaparro C, Deragon JM, Miguel PS, Jiang N, Wessler SR, Green PJ, Yu Y, Schwartz DC, Meyers BC, Bennetzen JL, Martienssen RA, McCombie WR, Aluru S, Clifton SW, Schnable PS, Ware D, Wilson RK, Wing RA','Detailed analysis of a contiguous 22-Mb region of the maize genome','PLoS Genet. 2009 Nov;5(11):e1000728','19936048','http://www.plosgenetics.org/article/info%3Adoi%2F10.1371%2Fjournal.pgen.1000728','','','','',0),(42,1,2009,'Gore MA, Chia JM, Elshire RJ, Sun Q, Ersoz ES, Hurwitz BL, Peiffer JA, McMullen MD, Grills GS, Ross-Ibarra J, Ware DH, Buckler ES','A First-Generation Haplotype Map of Maize','Science. 2009 Nov 20;326(5956):1115-7','19965431','http://www.sciencemag.org/cgi/content/abstract/sci;326/5956/1115','','','','',0),(43,1,2009,'Schnable PS, Ware D, Fulton RS, Stein JC, Wei F, Pasternak S, Liang C, Zhang J, Fulton L, Graves TA, Minx P, Reily AD, Courtney L, Kruchowski SS, Tomlinson C, Strong C, Delehaunty K, Fronick C, Courtney B, Rock SM, Belter E, Du F, Kim K, Abbott RM, Cotton M, Levy A, Marchetto P, Ochoa K, Jackson SM, Gillam B, Chen W, Yan L, Higginbotham J, Cardenas M, Waligorski J, Applebaum E, Phelps L, Falcone J, Kanchi K, Thane T, Scimone A, Thane N, Henke J, Wang T, Ruppert J, Shah N, Rotter K, Hodges J, Ingenthron E, Cordes M, Kohlberg S, Sgro J, Delgado B, Mead K, Chinwalla A, Leonard S, Crouse K, Collura K, Kudrna D, Currie J, He R, Angelova A, Rajasekar S, Mueller T, Lomeli R, Scara G, Ko A, Delaney K, Wissotski M, Lopez G, Campos D, Braidotti M, Ashley E, Golser W, Kim H, Lee S, Lin J, Dujmic Z, Kim W, Talag J, Zuccolo A, Fan C, Sebastian A, Kramer M, Spiegel L, Nascimento L, Zutavern T, Miller B, Ambroise C, Muller S, Spooner W, Narechania A, Ren L, Wei S, Kumari S, Faga B, Levy MJ, McMahan L, Van Buren P, Vaughn MW, Ying K, Yeh CT, Emrich SJ, Jia Y, Kalyanaraman A, Hsia AP, Barbazuk WB, Baucom RS, Brutnell TP, Carpita NC, Chaparro C, Chia JM, Deragon JM, Estill JC, Fu Y, Jeddeloh JA, Han Y, Lee H, Li P, Lisch DR, Liu S, Liu Z, Nagel DH, McCann MC, SanMiguel P, Myers AM, Nettleton D, Nguyen J, Penning BW, Ponnala L, Schneider KL, Schwartz DC, Sharma A, Soderlund C, Springer NM, Sun Q, Wang H, Waterman M, Westerman R, Wolfgruber TK, Yang L, Yu Y, Zhang L, Zhou S, Zhu Q, Bennetzen JL, Dawe RK, Jiang J, Jiang N, Presting GG, Wessler SR, Aluru S, Martienssen RA, Clifton SW, McCombie WR, Wing RA, Wilson RK','The B73 maize genome: complexity, diversity, and dynamics','Science. 2009;326(5956):1112-5 doi: 10.1126/science.1178534','19965430','http://www.sciencemag.org/cgi/content/abstract/sci;326/5956/1112','','assets/img/covers/maize.png','','',0),(44,1,2009,'McMullen MD, Kresovich S, Villeda HS, Bradbury P, Li H, Sun Q, Flint-Garcia S, Thornsberry J, Acharya C, Bottoms C, Brown P, Browne C, Eller M, Guill K, Harjes C, Kroon D, Lepak N, Mitchell SE, Peterson B, Pressoir G, Romero S, Oropeza Rosas M, Salvo S, Yates H, Hanson M, Jones E, Smith S, Glaubitz JC, Goodman M, Ware D, Holland JB, Buckler ES','Genetic properties of the maize nested association mapping population','Science. 2009 Aug 7;325(5941):688-9','19661427','','','','','',0),(45,1,2009,'Buckler ES, Holland JB, Bradbury PJ, Acharya CB, Brown PJ, Browne C, Ersoz E, Flint-Garcia S, Garcia A, Glaubitz JC, Goodman MM, Harjes C, Guill K, Kroon DE, Larsson S, Lepak NK, Li H, Mitchell SE, Pressoir G, Peiffer JA, Rosas MO, Rocheford TR, Romay MC, Romero S, Salvo S, Sanchez Villeda H, da Silva HS, Sun Q, Tian F, Upadyayula N, Ware D, Yates H, Yu J, Zhang Z, Kresovich S, McMullen MD','The genetic architecture of maize flowering time','Science. 2009 Aug 7;325(5941):714-8','19661422','','','','','',0),(46,1,2009,'Youens-Clark K, Faga B, Yap I, Stein L, Ware D','CMap 1.01: A comparative mapping application for the Internet','Bioinformatics, doi:10.1093/bioinformatics/btp458','19648141','http://bioinformatics.oxfordjournals.org/cgi/content/abstract/btp458?ijkey=RH2dYR27nTL4Bw9&keytype=ref','','','','',0),(47,1,2009,'Gore M, Wright M, Ersoz E, Bouffard P, Szekeres E, Jarvie T, Hurwitz B, Narechania A, Harkins T, Grills G, Ware D, Buckler E','Large-Scale Discovery of Gene-Enriched SNPs','The Plant Genome doi:10.3835/plantgenome2009.01.0002, vol. 2, no. 2 121-133','','http://plantgenome.scijournals.org/content/2/2/121','','','','',0),(48,1,2009,'Ni J, Pujar A, Youens-Clark K, Yap I, Jaiswal P, Tecle I, Tung CW, Ren L, Spooner W, Wei X, Avraham S, Ware D, Stein L, McCouch S','Gramene QTL database: development, content and applications','Database: The Journal of Biological Databases and Curation Vol. 2009:bap005; doi:10.1093/database/bap005','20157478','http://database.oxfordjournals.org/cgi/content/full/bap005?ijkey=f2bds3udr4Uod87&keytype=ref','','','','',0),(49,1,2009,'Brooks L, Strable J, Zhang X, Ohtsu K, Zhou R, Sarkar A, Hargreaves S, Elshire R, Eudy D, Pawlowska T, Ware D, Janick-Buckner D, Buckner B, Timmermans M, Schnable P, Nettleton D, Scanlon M','Microdissection of Shoot Meristem Functional Domains','PLoS Genetics 5(5): e1000476. doi:10.1371/journal.pgen.1000476','','http://www.plosgenetics.org/article/info%3Adoi%2F10.1371%2Fjournal.pgen.1000476','','','','',0),(50,1,2009,'Paterson AH, Bowers JE, Bruggmann R, Dubchak I, Grimwood J, Gundlach H, Haberer G, Hellsten U, Mitros T, Poliakov A, Schmutz J, Spannagl M, Tang H, Wang X, Wicker T, Bharti AK, Chapman J, Feltus FA, Gowik U, Grigoriev IV, Lyons E, Maher CA, Martis M, Narechania A, Otillar RP, Penning BW, Salamov AA, Wang Y, Zhang L, Carpita NC, Freeling M, Gingle AR, Hash CT, Keller B, Klein P, Kresovich S, McCann MC, Ming R, Peterson DG, Mehboob-ur-Rahman, Ware D, Westhoff P, Mayer KF, Messing J, Rokhsar DS','The Sorghum bicolor genome and the diversification of grasses','Nature. 2009 Jan 29;457(7229):551-6','19189423','http://www.nature.com/nature/journal/v457/n7229/abs/nature07723.html','','','','',0),(51,1,2009,'Liang C, Mao L, Ware D, Stein L','Evidence-based gene predictions in plant genomes','Genome Res. 2009 Oct;19(10):1912-23','19541913','','','','','',0),(52,1,2010,'International Arabidopsis Informatics Consortium','An international bioinformatics infrastructure to underpin the Arabidopsis community','Plant Cell. 2010;22(8):2530-6','20807877','','','','','',0),(53,1,2010,'Swanson-Wagner RA, Eichten SR, Kumari S, Tiffin P, Stein JC, Ware D, Springer NM','Pervasive gene content variation and copy number variation in maize and its undomesticated progenitor','Genome Res. 2010 Dec;20(12):1689-99','21036921','','','','','',0),(54,1,2010,'Youens-Clark K, Buckler E, Casstevens T, Chen C, Declerck G, Derwent P, Dharmawardhana P, Jaiswal P, Kersey P, Karthikeyan AS, Lu J, McCouch SR, Ren L, Spooner W, Stein JC, Thomason J, Wei S, Ware D','Gramene database in 2010: updates and extensions','Nucleic Acids Res. 2010 Nov 13','21076153','','','','','',0),(55,1,2010,'Eveland A, Satoh-Nagasawa N, Goldshmidt A, Meyer S, Beatty M, Sakai H, Ware D, Jackson D','Digital gene expression signatures for maize development','Plant Physiol. 2010;154(3):1024-39','PMC2971585','','','','','',0),(56,1,2010,'Cranston KA, Hurwitz B, Sanderson MJ, Ware D, Wing R, Stein L','Phylogenomic analysis from deep BAC-end sequence libraries of rice','Systematic Botany (In press)','','','','','','',0),(57,1,2010,'Nelson RT, Avraham S, Shoemaker RC, May GD, Ware D, Gessler DD','Applications and methods utilizing the Simple Semantic Web Architecture and Protocol (SSWAP) for bioinformatics resource discovery and disparate data and service integration.','BioData Min. 2010 Jun 4;3(1):3','20525377','','','','','',0),(58,1,2010,'Hurwitz B, Kudrna D, Yu Y, Sebastian A, Zuccolo A, Jackson SA, Ware D, Wing R, Stein L','Rice structural variation: a comparative analysis of structural variation between rice and three of its closest relatives in the genus Oryza','The Plant Journal doi: 10.1111/j.1365-313X.2010.04293.x','20626650','http://onlinelibrary.wiley.com/doi/10.1111/j.1365-313X.2010.04293.x/abstract','','','','',0),(59,1,2010,'Myles S, Chia JM, Hurwitz B, Simon C, Zhong GY, Buckler E, Ware D','Rapid genomic characterization of the genus vitis','PLoS One. 2010 Jan 13;5(1):e8219','20084295','http://www.plosone.org/article/info%3Adoi%2F10.1371%2Fjournal.pone.0008219','ftp://ftp.gramene.org/pub/vitis_plosone_2009_snps/','','','',0),(60,1,2011,'Dugas DV, Monaco MK, Olson A, Klein RR, Kumari S, Ware D, Klein PE','Functional annotation of the transcriptome of Sorghum bicolor in response to osmotic stress and abscisic acid','BMC Genomics. 2011 Oct 18;12:514','22008187','','','','','',0),(61,1,2011,'Gaudinier A, Zhang L, Reece-Hoyes JS, Taylor-Teeples M, Pu L, Liu Z, Breton G, Pruneda-Paz JL, Kim D, Kay SA, Walhout AJ, Ware D, Brady SM','A Transcription Factor Resource and Enhanced Y1H assays to elucidate Arabidopsis Gene Regulatory Networks','Nat Methods. 2011 Oct 30;8(12):1053-5. doi: 10.1038/nmeth.1750','22037706','','','','','',0),(62,1,2011,'Guberman JM, Ai J, Arnaiz O, Baran J, Blake A, Baldock R, Chelala C, Croft D, Cros A, Cutts RJ, Di Genova A, Forbes S, Fujisawa T, Gadaleta E, Goodstein DM, Gundem G, Haggarty B, Haider S, Hall M, Harris T, Haw R, Hu S, Hubbard S, Hsu J, Iyer V, Jones P, Katayama T, Kinsella R, Kong L, Lawson D, Liang Y, Lopez-Bigas N, Luo J, Lush M, Mason J, Moreews F, Ndegwa N, Oakley D, Perez-Llamas C, Primig M, Rivkin E, Rosanoff S, Shepherd R, Simon R, Skarnes B, Smedley D, Sperling L, Spooner W, Stevenson P, Stone K, Teague J, Wang J, Wang J, Whitty B, Wong DT, Wong-Erasmus M, Yao L, Youens-Clark K, Yung C, Zhang J, Kasprzyk A','BioMart Central Portal: An Open Database Network for Biological Community','Database doi: 10.1093/database/bar041','21930507','http://database.oxfordjournals.org/content/2011/bar041.full','','','','',0),(63,1,2011,'William S, Youens-Clark K, Staines D, Ware D','GrameneMart: The BioMart Data Portal for the Gramene Project','Database, Vol. 2011, Article ID bar056, doi:10.1093/database/bar056','','','','','','',0),(64,1,2011,'Goff S, Vaughn M, Lyons, E, et al., Ware D','The iPlant Collaborative: Cyberinfrastructure for Plant Biology','Frontiers 2011','','','','','','',0),(65,1,2011,'Arabidopsis Interactome Mapping Consortium','Evidence for Network Evolution in an Arabidopsis Interactome Map','Science. 2011 Jul 29;333(6042):601-7','21798944','','','','','',0),(66,1,2011,'Chia JM, Ware D','Sequencing for the cream of the crop','Nat Biotechnol. 2011 Feb;29(2):138-9','21301440','','','','','',0),(67,1,2011,'Brady SM, Zhang L, Megraw M, Martinez NJ, Jiang E, Yi CS, Liu W, Zeng A, Taylor-Teeples M, Kim D, Ahnert S, Ohler U, Ware D, Walhout AJ, Benfey PN','A stele-enriched gene regulatory network in the Arabidopsis root','Mol Syst Biol. 2011 Jan 18; 7:459','21245844','','','','','',0),(68,1,2011,'Myles S, Boyko AR, Owens CL, Brown PJ, Grassi F, Aradhya MK, Prins B, Reynolds A, Chia JM, Ware D, Bustamante CD, Buckler ES','Genetic structure and domestication history of the grape','Proc Natl Acad Sci U S A. 2011 Jan 18','21245334','','','','','',0),(69,1,2011,'Kump KL, Bradbury PJ, Wisser RJ, Buckler ES, Belcher AR, Oropeza-Rosas MA, Zwonitzer JC, Kresovich S, McMullen MD, Ware D, Balint-Kurti PJ, Holland JB','Genome-wide association study of quantitative resistance to southern leaf blight in the maize nested association mapping population','Nat Genet. 2011 Jan 9','21217757','','','','','',0),(70,1,2012,'Tomato Genome Sequencing Consortium. ','The tomato genome sequence provides insights into fleshy fruit evolution','Nature 485, 635-641 (31 May 2012)','','http://www.nature.com/nature/journal/v485/n7400/full/nature11119.html','','assets/img/covers/tomato.png','','',0),(71,1,2012,'Hufford M, Xu X, van Heerwaarden J , Pyhajarvi T, Chia JM , Cartwright R, Elshire R, Glaubitz JC, Guill K, Kaeppler S, Lai J , Morrell P, Shannon L, Song C , Springer N, Swanson-Wagner R, Tiffin P, Wang J, Zhang G, Doebley J, McMullen  MD, Ware D, Buckler ES , Yang S, Ross-Ibarra J','Comparative population genomics of maize domestication and improvement','Nat Genet. 2012 Jun 3. doi: 10.1038/ng.2309','','','','','','',0),(72,1,2012,'Chia JM*, Song C *, Bradbury PJ, Costich D, de Leon N, Doebley J, Elshire RJ, Gaut B, Geller L, Glaubitz JC, Gore M, Guill KE, Holland J, Hufford MB,  Lai J, Li M, Liu X, Lu Y, McCombie WR, Nelson R, Poland J, Prasanna BM, Pyhajarvi T, Rong T, Sekhon RS, Sun Q, Tenaillon MI , Tian F, Wang J, Xu X, Zhang Z, Kaeppler SM, Ross-Ibarra J, McMullen MD, Buckler ES, Zhang G, Xu Y, Ware D ','Maize HapMap2 identifies extant variation from a genome in flux','Nat Genet. 2012 Jun 3. doi: 10.1038/ng.2313.','','','','assets/img/covers/hapmapv2.png','','',0),(73,1,2012,'Hung HY, Shannon LM, Tian F, Bradbury PJ, Chen C, Flint-Garcia SA, McMullen MD, Ware D, Buckler ES, Doebley JF, Holland JB','ZmCCT and the genetic basis of day-length adaptation underlying the postdomestication spread of maize','PNAS June 18, 2012 doi: 10.1073/pnas.1203189109','22711828','','','','22711828.pdf','',0),(74,1,2012,'Liu Z, Kumari S, Zhang L, Zheng Y, Ware D','Characterization of miRNAs in Response to Short-Term Waterlogging in Three Inbred Lines of Zea mays','PLoS One. 2012;7(6):e39786. Epub 2012 Jun 29','22768123','','','','','',0),(75,1,2012,'The International Arabidopsis Informatics Consortium','Taking the Next Step: Building an Arabidopsis Information Portal','Plant Cell. 2012 Jun 29','22751211','','','','22751211.pdf','',0),(76,1,2012,'Spooner W, Youens-Clark K, Staines D, Ware D','GrameneMart: the BioMart data portal for the Gramene project','Database (Oxford). 2012 Feb 28;2012:bar056','22374386','','','','','',0),(77,1,2012,'Chen C, DeClerck G, Tian F, Spooner W, McCouch S, Buckler E','PICARA, an analytical pipeline providing probabilistic inference about a priori candidates genes underlying genome-wide association QTL in plants.','PLoS One. 2012;7(11):e46596','23144785','','','','','',0),(78,1,2012,'Monaco MK, Sen TZ, Dharmawardhana PD, Ren L, Schaeffer M, Naithani S, Amarasinghe V, Thomason1 J, Harper L, Gardiner J, Cannon EKS, Lawrence CJ, Ware D, and Jaiswal P','Maize Metabolic Network Construction and Transcriptome Analysis','The Plant Genome','','','','','','',0),(79,1,2013,'Boyle B, Hopkins N, Lu Z, Raygoza Garay JA, Mozzherin D, Rees T, Matasci N, Narro ML, Piel WH, McKay SJ, Lowry S, Freeland C, Peet RK, Enquist BJ','The taxonomic name resolution service: an online tool for automated standardization of plant names','BMC Bioinformatics.2013, 14:16.','23324024','http://www.biomedcentral.com/1471-2105/14/16','','','','',0),(80,1,2013,'Dharmawardhana P, Ren L, Amarasinghe V, Monaco M, Thomason J, Ravenscroft D, McCouch S, Ware D and Jaiswal P','A Genome Scale Metabolic Network for Rice and Accompanying Analysis of Tryptophan, Auxin and Serotonin Biosynthesis Regulation Under Biotic Stress','Rice','','','','','','',0),(81,1,2013,'Lu, Z., Regulski M, Kendall J, Reinders J, Llaca V, Deschamps S,  Smith A, Levy D, McCombie WR, Tingey S, Rafalski A, Hicks J, Ware D, Martienssen R','The maize methylome modulates mRNA splicing and reveals widespread paramutation guided by small RNA','submitted to Genome Research','','','','','','',0),(82,1,2013,'Kumari S and Ware D','Genome-wide Computational Prediction and Analysis of Core Promoter Elements Across Plant Monocots and Dicots','submitted to PLOS ONE','','','','','','',0),(83,1,2013,'Luo MC, Gu YQ, You FM, Deal KR, Ma Y, Hu Y, Huo N, Wang Y, Wang J, Chen S, Jorgensen CM, Zhang Y, McGuire PE, Pasternak S, Stein JC, Ware D, Kramer M, McCombie WR, Kianian SF, Martis MM, Mayer KF, Sehgal SK, Li W, Gill BS, Bevan MW, Simkova H, Dolezel J, Weining S, Lazo GR, Anderson OD, Dvorak J.','A 4-gigabase physical map unlocks the structure and evolution of the complex genome of Aegilops tauschii, the wheat D-genome progenitor','Proc Natl Acad Sci U S A. 2013 May 7;110(19):7940-5. doi: 10.1073/pnas.1219082110. Epub 2013 Apr 22.','23610408','http://www.ncbi.nlm.nih.gov/pubmed/23610408','','','','',0);
/*!40000 ALTER TABLE `pub` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2013-06-11 11:03:57
