import os
import matplotlib.pyplot as plt
from collections import defaultdict
import pandas as pd
from rich.console import Console
from rich.table import Table

class Dataset:
    def __init__(self):
        self.subjects=defaultdict(dict)
        self.id='HugaDB'
        self.console=Console(record=True)
        self.classes=set()
    
    def load(self):
        for filename in os.listdir(os.path.join('','dataset')):
            subject_id,period_id=filename.removesuffix('.txt').split('_')[-2],filename.removesuffix('.txt').split('_')[-1]
            self.subjects[subject_id][period_id]=pd.read_csv(os.path.join('','dataset',filename),sep='\t',skiprows=[0,1,2])
            with open(os.path.join('','dataset',filename),'r') as reader:
                lines=reader.readlines()
                activities=lines[1]
                activities=activities.replace("#ActivityID","").strip().split()
                _=[self.classes.add(class_value) for class_value in activities]

        

    def statistics(self):
        self.console.print(f'[bold green]Subjects:{len(self.subjects)}',justify='left')
        self.console.print(f'[bold green]Records/Subject:{len(self.subjects[list(self.subjects.keys())[0]])}',justify='left')
        self.console.print(f'[bold green]Classes:{self.classes}')

        stats_table=Table(title='Statistics')
        stats_table.add_column("Subject",justify="right",style="cyan")
        stats_table.add_column("Moment",style='green')
        stats_table.add_column('Column',style="magenta")
        stats_table.add_column("Mean",style="green")
        stats_table.add_column("Median",style="magenta")
        stats_table.add_column("Std",style='green')
        stats_table.add_column("Iqr",style='magenta')
        stats_table.add_column("Skewness",style='green')
        stats_table.add_column("Kurtosis",style="magenta",justify='right')

        for subject_id,data in self.subjects.items():
            for moment_id,subject in data.items():
                columns=subject.columns.to_list()[0:len(subject)-1]
                for column in columns:
                    stats_table.add_row(str(subject_id),str(moment_id),str(column),str(subject[column].mean()),str(subject[column].median()),str(subject[column].std()),str(subject[column].quantile(0.75)-subject[column].quantile(0.25)),str(subject[column].skew()),str(subject[column].kurtosis()))
                break
        self.console.print(stats_table)
        self.console.save_html(os.path.join('','results','statistics.html'))
        import webbrowser
        webbrowser.open(os.path.join('','results','statistics.html'))

    def window(self):
        w=150


if __name__=='__main__':
    data=Dataset()
    data.load()
    data.statistics()