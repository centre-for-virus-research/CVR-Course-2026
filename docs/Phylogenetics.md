# Phylogenetics Practical

David L Robertson, MRC-University of Glasgow Centre for Virus Research

[**david.l.robertson@glasgow.ac.uk**](mailto:david.l.robertson@glasgow.ac.uk)


**Aim**

To introduce multiple sequence alignment and the inference of evolutionary history. You will learn how to align homologous virus sequence data, construct a phylogenetic tree, consider important parameters, use different methods and how to test the reliability of clades in your phylogeny. 


**Task**

Your task is to construct a phylogenetic tree similar to the one in Figure 1A of the paper [Iyer et al. 2017, Resistance to type 1 interferons is a major determinant of HIV-1 transmission fitness. PNAS 114(4):E590-E599](https://www.pnas.org/doi/10.1073/pnas.1620144114#fig01).  

To complete your analysis the key stages to consider are 1/ sequence alignment, 2/ the tree inference method and model choice, 3/ tree visualization and 4/ checking the reliability of clustering with bootstrapping.

**Data**

The data set from the Iyer paper is quite large (available at /home4/VBG_data/Phylogenetics on Alpha) so would take some time to align. To speed things up use the pre-processed fasta file Iyer-etal-2017-95.fst with fewer sequences (95) from the linked patients CH595 and CH455 that were presented in their figure 1. The file data-acquistion-info.txt explains how this file was derived from the larger sequence set of 666 sequences. 

**Copy files to your own directory.**

**Software**

Use the alignment software ***Mafft***: type 'mafft filename.fst > filename-mafft-aln'on the command line on the bioinformatics server Alpha2 <alpha2.cvr.gla.ac.uk. The authors used older software, ***CLUSTALW*** (commmand ‘clustalw2’ on the command line), have a go using that too. Other alignmen software such as ***Muscle*** is popular but slower to run.   

To infer a phylogenetic tree try using the popular software IQ-TREE (command: 'iqtree2 -s filename.ph -m HKY --threads-max 1'). Reflect on the lecture at the beginning of the class to choose appropriate parameters. ***Note***, the 'threads' command is important to prevent the program using multiple threads on the server. What are the different options doing?

Use ***FigTree*** (command: ‘figtree’) for visualizing your phylogenetic trees and highlighting specific sequence names. 

Now try the software ***RaXML***: type 'raxml-ng-mpi --threads 1 --model HKY --msa filename.fst'. An another alternative is ***PhyML***, type ‘phyml’ on the command line (or available online at http://www.atgc-montpellier.fr/phyml/). See PhyML’s online helpfile for further guidance on options: http://www.atgc-montpellier.fr/phyml/usersguide.php. Note, PhyML takes PHYLIP formatted alignments which can be generated with CLUSTALW (or use the .ph file in the Data folder). 

Note, alignments, tree methods and visualization can also be carried out with graphical user interface software, for example, ***SeaView*** (command: ‘/software/seaview-v5.0.5/seaview’).

Once you’ve generated some trees answer the questions below:

**Question 1**. Why is it important to be confident the data you're analysing is homologous before starting a phylogenetic analysis? Do the sequences being homologous guarantee a meaningful analysis? 

**Question 2**. What can you infer from your evolutionary tree about the relationship of virus from the two individuals: CH596 and CH455? What two properties of the phylogenetic tree support this relationship?

**Question 3**. Iyer et al. used the methods: *Nucleotide sequences were aligned using CLUSTALW, with ambiguous regions removed. Maximum likelihood trees with bootstrap support (1,000 replicates) were constructed using PhyML.*  Does this change the results in any meaningful way? Does using a different alignment method matter, e.g., MAFFT versus CLUSTALW?   

**Question 4**. What is the main differences between the maximum likelihood methods and the distance-method neighbor joining, e.g., available in CLUSTALW or SeaView? 

**Question 5**. Why is PhyML, despite being a maximum likelihood method, relatively quick? Why is the the software RAxML or IQ-TREE more appropriate to use? 

**Question 6**. Why does the substitution model used matter? What does the software jModelTest used in the Iyer paper do?

**Question 7**. Briefly explaining what bootstrapping is doing. How does it contribute to the analysis? 

***Bonus questions!***

**Question 8**. Have a look at the file HIV1-subtypes-AND-3-CRFs.fst (available at /home4/VBG_data/Phylogenetics). These sequences represent the diversity in the 'main' group M of HIV-1, responsible for the HIV/AIDS pandemic, which is split into 'subtypes' A - L and circulating recombinant form 'CRF' lineages (https://www.hiv.lanl.gov/components/sequence/HIV/crfdb/crfs.comp). Why should you be concerned about recombination when doing a phylogenetic analysis with virus data? Hint, you can explore inferring trees from sub-regions of the alignment using the 'extractalign' command. 

**Question 9**. Have a look at the file HIV1-groups-AND-ape-SIVs.fst. What is this telling us about the origins of HIV-1?
