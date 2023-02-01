import tensorflow as tf
import sklearn as sk
import pandas as pd
import os

class ForcePlate:
    def __init__(self):
        self.description=list()
        self.columns=list()
        self.units=list()
        self.rows=list()


    def add(self,column,line='Desc'):
        if line=='Desc':
            self.description=[x for x in column.split('\t')]
        elif line=='Column':
            self.columns=[k for k in column.split(',')]
        elif column=='Unit':
            self.units=[k for k in column.strip().split('')]
        
        else:
            self.rows.append([int(row_value) for row_value in column.split(',')])
        
    def toDF(self):
        dfColumns=[]
        cntDesc=0
        for cindex,column_value in enumerate(self.columns):
            if cindex<2:
                dfColumns.append(column_value)
            else:
                if (cindex-2)%3==0 and cindex!=2:
                    cntDesc+=1
                dfColumns.append(f'{self.description[cntDesc]}_{column_value}')
        
        return pd.DataFrame(data=self.rows,columns=dfColumns)

class GaitData:
    path_to_datasets=os.path.join('','datasets')
    def __init__(self) -> None:
        self.devices=-1
        self.parameters=-1
        
        self.units={"columns":list(),"data":list(),"first_line":True}
        self.rows=[]
        self.columns=[]
        line_use=''
        with open(os.path.join(GaitData.path_to_datasets,'Dynamic01.csv'),'r') as RF:
            for line in RF:
                if line.strip()=='Devices':
                    line_use='devices'
                    continue
                elif line.strip()=='Gait Cycle Parameters':
                    line_use='Gait_params'
                    continue

                if line.strip()=='':
                    continue
                
                if line_use=='Gait Cycle Parameters':
                    self.parameters=int(line.strip())
                    line_use='Units'
                
                elif line_use=='Units':
                    pass

                elif line_use=='Devices':
                    self.devices=int(line.strip())
                    line_use='Data'
                
                elif line_use=='Data':
                    pass
                
                self.rows.append([x for i,x in enumerate(line.split()) if i<4])
                



if __name__=='__main__':
    pass