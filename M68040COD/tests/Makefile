#
#	Makefile for generating and verifying Floating Point Software Package
#
# 'make generate' to build test cases from the source sub-directory
# 'make verify' to run test cases and create results
# To compare 68881 results with 68040, run 'make generate' on an '881
# based system and then run 'make verify' on an '040 system.
#

verify:
	-rm -fr results; mkdir results
	find F* -print \
	| sed 's/.*/echo &; sed "\/^$$\/d" <& | sed "\/^#\/d" | fpcheck | uniq >results\/&/' \
	| sh
	find results -size 0 -print                                                                                                                                                                                                                                                                                                                                                                                                                          