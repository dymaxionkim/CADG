#!/bin/bash

# Script to convert every documents
# 20170812, DymaxionKim
# Pre-Requisites : TexLive, Pandoc, Noto Sans CJK KR

echo "Start MakePDF..."

# md 2 pdf
pandoc -s -S --dpi=600 -f markdown+footnotes+grid_tables+pipe_tables+table_captions --latex-engine=xelatex --table-of-contents --highlight-style espresso -o ./pdf/CADG.pdf CADG.md
pandoc -s -S --dpi=600 -f markdown+footnotes+grid_tables+pipe_tables+table_captions --latex-engine=xelatex --table-of-contents --highlight-style espresso -o ./pdf/CADG_01_Elmer_Intro.pdf CADG_01_Elmer_Intro.md
pandoc -s -S --dpi=600 -f markdown+footnotes+grid_tables+pipe_tables+table_captions --latex-engine=xelatex --table-of-contents --highlight-style espresso -o ./pdf/CADG_02_Elmer_Install.pdf CADG_02_Elmer_Install.md
pandoc -s -S --dpi=600 -f markdown+footnotes+grid_tables+pipe_tables+table_captions --latex-engine=xelatex --table-of-contents --highlight-style espresso -o ./pdf/CADG_03_Elmer_Structure_1.pdf CADG_03_Elmer_Structure_1.md
pandoc -s -S --dpi=600 -f markdown+footnotes+grid_tables+pipe_tables+table_captions --latex-engine=xelatex --table-of-contents --highlight-style espresso -o ./pdf/CADG_03_Elmer_Structure_2.pdf CADG_03_Elmer_Structure_2.md
pandoc -s -S --dpi=600 -f markdown+footnotes+grid_tables+pipe_tables+table_captions --latex-engine=xelatex --table-of-contents --highlight-style espresso -o ./pdf/CADG_04_Elmer_Dynamics.pdf CADG_04_Elmer_Dynamics.md
#pandoc -s -S --dpi=600 -f markdown+footnotes+grid_tables+pipe_tables+table_captions --latex-engine=xelatex --table-of-contents --highlight-style espresso -o ./pdf/CADG_05_Elmer_Acoustic.pdf CADG_05_Elmer_Acoustic.md
#pandoc -s -S --dpi=600 -f markdown+footnotes+grid_tables+pipe_tables+table_captions --latex-engine=xelatex --table-of-contents --highlight-style espresso -o ./pdf/CADG_06_Elmer_Conduction.pdf CADG_06_Elmer_Conduction.md
#pandoc -s -S --dpi=600 -f markdown+footnotes+grid_tables+pipe_tables+table_captions --latex-engine=xelatex --table-of-contents --highlight-style espresso -o ./pdf/CADG_07_Elmer_Convection.pdf CADG_07_Elmer_Convection.md
#pandoc -s -S --dpi=600 -f markdown+footnotes+grid_tables+pipe_tables+table_captions --latex-engine=xelatex --table-of-contents --highlight-style espresso -o ./pdf/CADG_08_Elmer_Radiation.pdf CADG_08_Elmer_Radiation.md
#pandoc -s -S --dpi=600 -f markdown+footnotes+grid_tables+pipe_tables+table_captions --latex-engine=xelatex --table-of-contents --highlight-style espresso -o ./pdf/CADG_09_Elmer_MultiBody.pdf CADG_09_Elmer_MultiBody.md
#pandoc -s -S --dpi=600 -f markdown+footnotes+grid_tables+pipe_tables+table_captions --latex-engine=xelatex --table-of-contents --highlight-style espresso -o ./pdf/CADG_10_Elmer_Optimization.pdf CADG_10_Elmer_Optimization.md

# md 2 docx
pandoc -s --highlight-style espresso --table-of-contents --from=markdown+multiline_tables -S CADG.md -o ./docx/CADG.docx
pandoc -s --highlight-style espresso --table-of-contents --from=markdown+multiline_tables -S CADG_01_Elmer_Intro.md -o ./docx/CADG_01_Elmer_Intro.docx
pandoc -s --highlight-style espresso --table-of-contents --from=markdown+multiline_tables -S CADG_02_Elmer_Install.md -o ./docx/CADG_02_Elmer_Install.docx
pandoc -s --highlight-style espresso --table-of-contents --from=markdown+multiline_tables -S CADG_03_Elmer_Structure_1.md -o ./docx/CADG_03_Elmer_Structure_1.docx
pandoc -s --highlight-style espresso --table-of-contents --from=markdown+multiline_tables -S CADG_03_Elmer_Structure_2.md -o ./docx/CADG_03_Elmer_Structure_2.docx
pandoc -s --highlight-style espresso --table-of-contents --from=markdown+multiline_tables -S CADG_04_Elmer_Dynamics.md -o ./docx/CADG_04_Elmer_Dynamics.docx
#pandoc -s --highlight-style espresso --table-of-contents --from=markdown+multiline_tables -S CADG_05_Elmer_Acoustic.md -o ./docx/CADG_05_Elmer_Acoustic.docx
#pandoc -s --highlight-style espresso --table-of-contents --from=markdown+multiline_tables -S CADG_06_Elmer_Conduction.md -o ./docx/CADG_06_Elmer_Conduction.docx
#pandoc -s --highlight-style espresso --table-of-contents --from=markdown+multiline_tables -S CADG_07_Elmer_Convection.md -o ./docx/CADG_07_Elmer_Convection.docx
#pandoc -s --highlight-style espresso --table-of-contents --from=markdown+multiline_tables -S CADG_08_Elmer_Radiation.md -o ./docx/CADG_08_Elmer_Radiation.docx
#pandoc -s --highlight-style espresso --table-of-contents --from=markdown+multiline_tables -S CADG_09_Elmer_MultiBody.md -o ./docx/CADG_09_Elmer_MultiBody.docx
#spandoc -s --highlight-style espresso --table-of-contents --from=markdown+multiline_tables -S CADG_10_Elmer_Optimization.md -o ./docx/CADG_10_Elmer_Optimization.docx

echo "Finished !"

exit 0
