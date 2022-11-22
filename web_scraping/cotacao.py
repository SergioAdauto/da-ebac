#Biblioteas necessárias:

import pandas as pd
import numpy as np
#import re
import requests
from requests.exceptions import HTTPError
from bs4 import BeautifulSoup


# Função para remover caracteres:
def replace_column(df):
      for column in df.columns:
        #df[column] =  [re.sub("\$|\%", "", str(x)).strip() for x in df[column]]
        df[column] =  df[column].str.replace(',','.')
        df[column] = df[column].str.replace(' %','')
        df[column] = df[column].str.replace(' -', '0')

        
#função para converter as colunas para tipo float, ou string:            
def format_column(df):
    for column in df.columns:
        try:
            df[column] =  df[column].astype(np.float64)
        except:
            df[column] =  df[column].astype(object)



URL = 'https://valorinveste.globo.com/cotacoes/'
# my user agent:
my_user_agents = {'User-Agent':'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36'}

# Requisição da página:
try:
  site = requests.get(URL, headers=my_user_agents)
  site.raise_for_status()
except HTTPError as erro:
  print(erro)#caso apresente algum erro
else:
  site = site.text



# Leitura da página:
pagina = BeautifulSoup(site, 'html.parser')
conteudo = pagina.find_all('div', attrs={'class':'vd-automatic-tables__section__content vd-automatic-tables__section__content__col-0'})



#Extração dos dados:
try:
    titulos = list() #Lista para guardar o nome das colunas
    conteudos = list()#lista para guardar os dados

    for tabela in pagina.find_all('div',{'class':'vd-table__content__overflow'}):
        #Lista temporárias:
        temp_titulo = list()
        temp_conteudo = list()

        #coletando as informações dos cabeçalhos das colunas:
        header = tabela.find('thead', {'class':'vd-table__head'})
        #Seprando as informações do HTML das strings:
        header = header.get_text().strip().split('  ')
        #Adicionando as informações a lista temporaria:
        temp_titulo.append(header)

        #Coletando o conteúdo das tabelas:
        body = tabela.find('tbody', {'class':'vd-table__body'})
        #loop para coletar as informações das linhas contidas na tag <tr>:
        for x in body.find_all('tr'):
            #Seprando as informações do HTML das strings:
            valores = x.get_text().strip().split('  ')
            #Adicionando as informações a lista temporaria:
            temp_conteudo.append(valores)

        #Adicionando as informações as listas permanentes:
        titulos.append(temp_titulo)
        conteudos.append(temp_conteudo)
except Exception as erro:
    print(erro)
else:
    print('Extração concluída !!!')

    

#Crianção dos DataFrames para transformação dos dados:
df_share = pd.DataFrame(data=conteudos[0], columns=[x.strip() for x in titulos[0][0]])

df_BDR = pd.DataFrame(data=conteudos[1], columns=[x.strip() for x in titulos[1][0]])


df_FII = pd.DataFrame(data=conteudos[2], columns=[x.strip() for x in titulos[2][0]])

replace_column(df_share)
replace_column(df_BDR)
replace_column(df_FII)

format_column(df_share)
format_column(df_BDR)
format_column(df_FII)

print('Transformação concluída.')

df_share.to_csv(path_or_buf='cotacao_acoes.csv',sep=';',index=False, encoding='latin-1')
df_BDR.to_csv(path_or_buf='cotacao_bdr.csv',sep=';',index=False, encoding='latin-1')
df_FII.to_csv(path_or_buf='cotacao_fii.csv',sep=';',index=False, encoding='latin-1')

print('Carregamento dos dados concluído.')



        