import os
import pandas as pd
import matplotlib.pyplot as plt
from scipy.stats import mannwhitneyu

# +----------------------------------------+
# |              Problem 1                 |
# +----------------------------------------+

# create output folder and plots subfolder
output_dir = 'output'
plots_dir = os.path.join(output_dir, 'plots')
os.makedirs(plots_dir, exist_ok=True)

# read dataset files: cell-count.csv
data_file = os.path.join('data', 'cell-count.csv')
df = pd.read_csv(data_file)

# define six kinds of cells
cell_populations = ['b_cell', 'cd8_t_cell', 'cd4_t_cell', 'nk_cell', 'monocyte']
# calculate the total sum of the cells and store as total_count
df['total_count'] = df[cell_populations].sum(axis=1)

# create long table, add 'cell_populations' column, and split by cell type
df_long = df.melt(
    id_vars=['sample', 'total_count', 'condition', 'treatment', 'response', 'sample_type', 'time_from_treatment_start'],
    value_vars=cell_populations,
    var_name='population',
    value_name='count'
)

# calulate percentage of each cell type
df_long['percentage'] = (df_long['count'] / df_long['total_count']) * 100

# generate the output dataframe for problem 1 by selecting required column
out_df = df_long[['sample', 'total_count', 'population', 'count', 'percentage']]

# save the output dataframe as csv file (relative_frequencies.csv)
output_csv = os.path.join(output_dir, 'relative_frequencies.csv')
out_df.to_csv(output_csv, index=False)
print(f"file has been saved! {output_csv}")

# +----------------------------------------+
# |              Problem 2                 |
# +----------------------------------------+

# create dataframe for analysis
df_analysis = df_long[
    (df_long['treatment'] == 'tr1') &
    (df_long['sample_type'] == 'PBMC') &
    (df_long['condition'] == 'melanoma')
]

stat_results = {}  # used to store the statistics results

# loop over each type of cell in cell_populations
for pop in cell_populations:
    pop_data = df_analysis[df_analysis['population'] == pop]
    
    # extract the percentage of responders (response = 'y') and non-responders (response = 'n')
    responders = pop_data[pop_data['response'] == 'y']['percentage']
    non_responders = pop_data[pop_data['response'] == 'n']['percentage']
    
    # boxplot
    fig, ax = plt.subplots()
    ax.boxplot([responders, non_responders], labels=['responders', 'non-responders'])
    ax.set_title(f"cell type: {pop}")
    ax.set_ylabel("percentage (%)")
    
    # save boxplot
    plot_file = os.path.join(plots_dir, f"{pop}_boxplot.png")
    plt.savefig(plot_file)
    plt.close()
    
    # Conduct Mann–Whitney U test, check significance (Using Mann-Whitney U test is better than using Pair-T test in this case)
    if len(responders) > 0 and len(non_responders) > 0:
        stat, p_value = mannwhitneyu(responders, non_responders, alternative='two-sided')
        stat_results[pop] = p_value
    else:
        stat_results[pop] = None

# print statistical results
print("\n Mann-Whitney U test results:")
for pop, p in stat_results.items():
    if p is not None:
        significance = "Significant" if p < 0.05 else "Not Significant"
        print(f"{pop}: p-value = {p:.4f} ({significance})")