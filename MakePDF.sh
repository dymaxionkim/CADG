#!/bin/bash
#############################################################
# Script to convert every documents
# 20170824, DymaxionKim
# Pre-Requisites : TexLive, Pandoc, Noto Sans CJK KR

# Variables
A="CADG"
B="CADG_01_Elmer_Intro"
C="CADG_02_Elmer_Install"
D="CADG_03_Elmer_Structure_1"
E="CADG_03_Elmer_Structure_2"
F="CADG_03_Elmer_Structure_3"
G="CADG_04_Elmer_Dynamics"
H="CADG_05_Elmer_Acoustic"
I="CADG_06_Elmer_Conduction"
J="CADG_07_Elmer_Convection"
K="CADG_08_Elmer_Radiation"
L="CADG_09_Elmer_MultiBody"
M="CADG_10_Elmer_Optimization"
PDF="--latex-engine=xelatex -s -S --dpi=600 --table-of-contents --highlight-style tango -f markdown+multiline_tables+grid_tables+pipe_tables+table_captions"
DOCX="-s -S --table-of-contents --highlight-style tango -f markdown+multiline_tables+grid_tables+pipe_tables+table_captions --reference-docx=Format.docx"
ODT="-s -S --highlight-style tango -f markdown+multiline_tables+grid_tables+pipe_tables+table_captions --reference-odt=Format.odt"

echo "Start MakePDF..."

# md 2 pdf
echo "Making PDF files.."
pandoc ${A}.md -o ./pdf/${A}.pdf ${PDF}
pandoc ${B}.md -o ./pdf/${B}.pdf ${PDF}
pandoc ${C}.md -o ./pdf/${C}.pdf ${PDF}
pandoc ${D}.md -o ./pdf/${D}.pdf ${PDF}
pandoc ${E}.md -o ./pdf/${E}.pdf ${PDF}
pandoc ${F}.md -o ./pdf/${F}.pdf ${PDF}
pandoc ${G}.md -o ./pdf/${G}.pdf ${PDF}
pandoc ${H}.md -o ./pdf/${H}.pdf ${PDF}
pandoc ${I}.md -o ./pdf/${I}.pdf ${PDF}
pandoc ${J}.md -o ./pdf/${J}.pdf ${PDF}
pandoc ${K}.md -o ./pdf/${K}.pdf ${PDF}
pandoc ${L}.md -o ./pdf/${L}.pdf ${PDF}
pandoc ${M}.md -o ./pdf/${M}.pdf ${PDF}

# md 2 docx
echo "Making DOCX files.."
pandoc ${A}.md -o ./docx/${A}.docx ${DOCX}
pandoc ${B}.md -o ./docx/${B}.docx ${DOCX}
pandoc ${C}.md -o ./docx/${C}.docx ${DOCX}
pandoc ${D}.md -o ./docx/${D}.docx ${DOCX}
pandoc ${E}.md -o ./docx/${E}.docx ${DOCX}
pandoc ${F}.md -o ./docx/${F}.docx ${DOCX}
pandoc ${G}.md -o ./docx/${G}.docx ${DOCX}
pandoc ${H}.md -o ./docx/${H}.docx ${DOCX}
pandoc ${I}.md -o ./docx/${I}.docx ${DOCX}
pandoc ${J}.md -o ./docx/${J}.docx ${DOCX}
pandoc ${K}.md -o ./docx/${K}.docx ${DOCX}
pandoc ${L}.md -o ./docx/${L}.docx ${DOCX}
pandoc ${M}.md -o ./docx/${M}.docx ${DOCX}

# md 2 odt
echo "Making ODT files.."
pandoc ${A}.md -o ./odt/${A}.odt ${ODT}
pandoc ${B}.md -o ./odt/${B}.odt ${ODT}
pandoc ${C}.md -o ./odt/${C}.odt ${ODT}
pandoc ${D}.md -o ./odt/${D}.odt ${ODT}
pandoc ${E}.md -o ./odt/${E}.odt ${ODT}
pandoc ${F}.md -o ./odt/${F}.odt ${ODT}
pandoc ${G}.md -o ./odt/${G}.odt ${ODT}
pandoc ${H}.md -o ./odt/${H}.odt ${ODT}
pandoc ${I}.md -o ./odt/${I}.odt ${ODT}
pandoc ${J}.md -o ./odt/${J}.odt ${ODT}
pandoc ${K}.md -o ./odt/${K}.odt ${ODT}
pandoc ${L}.md -o ./odt/${L}.odt ${ODT}
pandoc ${M}.md -o ./odt/${M}.odt ${ODT}

echo "Finished !"
exit 0
