import pandas as pd

# Monkey Patch Pandas DataFrames 
# http://stackoverflow.com/questions/20685635/pandas-dataframe-as-latex-or-html-table-nbconvert

pd.set_option('display.notebook_repr_html', True)

def _repr_latex_(self):
    return "\\begin{center}{" + self.to_latex() +  "}\\end{center}"

pd.DataFrame._repr_latex_ = _repr_latex_
