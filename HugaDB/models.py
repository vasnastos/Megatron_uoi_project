import tensorflow as tf 
from dataset import Dataset

class RModel:
    def __init__(self) -> None:
        self.dataset=Dataset()
        self.dataset.load()
        
        self.model=tf.keras.Sequential(
            steps=[
                tf.keras.layers.SimpleRNN(units=64,activation='tanh',input_shape=(None)),
                tf.keras.layers.Dense(units=len(self.dataset.classes),kernel_regularizer='l1-regulizer')
            ],name='Huga Model'
        )