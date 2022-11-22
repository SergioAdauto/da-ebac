
# Bibliotecas:
import pandas as pd
import seaborn as sns

# Criando o dataframe:
df = pd.read_csv('./gasolina.csv')

# Salvando no grafico
with sns.axes_style('whitegrid'):
  grafico = sns.lineplot(data=df, x='dia', y='venda', ci=None)
  # Inserindo as informações do título, e legenda dos eixos (x,y):
  grafico.set(title='Observação da Cotação de Preço da Gasolina', xlabel='Dias de Julho', ylabel='Preço (R$)')
  grafico.get_legend()
  #Salvando o gráfico em um arquivo de imagem:
  grafico.get_figure().savefig('gasolina.png')
